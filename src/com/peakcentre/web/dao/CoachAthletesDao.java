package com.peakcentre.web.dao;

import java.util.ArrayList;
import org.bson.Document;
import com.mongodb.BasicDBObject;
import com.mongodb.MongoQueryException;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.peakcentre.web.entity.Userinfo;
import com.peakcentre.web.mongo.MongoDBConnection;


public class CoachAthletesDao {
	MongoDBConnection connec = new MongoDBConnection();
	MongoCollection<Document> athletesCollection;
	UserinfoDao uiDao = new UserinfoDao();

	// insert data into TestResult Table
	public void insertAthlete(String athUsername, String coachUsername) {
		boolean bothExist = uiDao.checkExistsByUsernameAndType(athUsername, "Athlete")
				&& uiDao.checkExistsByUsernameAndType(coachUsername, "Coach");
		if (!bothExist || checkRelationshipExists(athUsername, coachUsername)) {
			return;
		}
		UserinfoDao userinfoDao = new UserinfoDao();
		// Connect to the Collection(Table)
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		// insert to mongodb
		athletesCollection.insertOne(new Document("athUsername", athUsername)
				.append("coachUsername", coachUsername));
		// Close the Connection
		connec.closeConnection();
	}

	public ArrayList<Userinfo> getAtheltes(final String coachUsername) {
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		FindIterable<Document> athIdList = athletesCollection.find(
				new Document("coachUsername", coachUsername));

		ArrayList<Userinfo> athList = new ArrayList<>();
		if (athIdList != null) {
			for (Document document : athIdList) {
				Userinfo athlete = uiDao.getUserinfoByUsernameAndType(document.get("athUsername").toString(), "Athlete");
				athList.add(athlete);
			}
		}

		connec.closeConnection();
		return athList;
	}

	public boolean deleteRelationship(final String athUsername, final String coachUsername) {
		boolean flag = false;
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		final long previousCount = athletesCollection.count();
		Document doc = new Document("coachUsername", coachUsername).append("athUsername", athUsername);
		athletesCollection.deleteOne(doc);
		if (athletesCollection.count() < previousCount) {
			flag = true;
		}
		connec.closeConnection();
		return flag;
	}

	public boolean checkRelationshipExists(final String coachUsername, final String athUsername) {
		boolean flag = false;
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		Document doc = new Document("coachUsername", coachUsername).append("athUsername", athUsername);
		FindIterable<Document> relationshipList = athletesCollection.find(doc);
		flag = (relationshipList.first() != null);
		connec.closeConnection();
		return flag;
	}
	
	public ArrayList<Userinfo> getAllathByPage(final String coachUsername, int pageSize, int pageIndex) {
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		UserinfoDao uiDao = new UserinfoDao();
		BasicDBObject sort = new BasicDBObject();
		sort.put("athName", 1);
		ArrayList<Userinfo> athListByPage = new ArrayList<>();
		try {
			FindIterable<Document> cursor = athletesCollection.find(new Document("coachUsername", coachUsername))
					.sort(sort).skip(pageIndex * pageSize).limit(pageSize);
			if (cursor != null) {
				for (Document doc : cursor) {
					if (doc != null) {
						UserinfoDao userinfoDao = new UserinfoDao();
						athListByPage.add(
								userinfoDao.getUserinfoByUsernameAndType(doc.get("athUsername").toString(), "Athlete"));
					}
				}
			}
		} catch (MongoQueryException e) {
			// TODO: handle exception
		}

		return athListByPage;
	}
	
	public int getTotalPage(final int pageSize, final String coachUsername){
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		FindIterable<Document> athList = athletesCollection.find(
				new Document("coachUsername", coachUsername));
		int totalPage = 0;
		for (Document document : athList) {
			totalPage++;
		}
		return (totalPage%pageSize==0)?(totalPage/pageSize):(totalPage/pageSize+1);  
	}

}
