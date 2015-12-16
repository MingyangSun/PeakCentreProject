package com.peakcentre.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.peakcentre.web.entity.TrainingPlan;
import com.peakcentre.web.entity.Userinfo;

import org.bson.Document;

import com.mongodb.Block;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.peakcentre.web.entity.TestResult;
import com.peakcentre.web.entity.TestResultTemplate;
import com.peakcentre.web.entity.Userinfo;
import com.sun.research.ws.wadl.Doc;
import com.peakcentre.web.mongo.*;

public class TrainingPlanDao{
	MongoDBConnection connec = new MongoDBConnection();
	MongoCollection<Document> trainingPlanCollection;

	public void insertTrainingPlan(TrainingPlan tp) {
		//Connect to the collection
		trainingPlanCollection = connec.getRequiredCollection("TrainingPlan");
		
		Document doc = new Document("username",tp.getUsername())
		.append("startDate", tp.getStartdate())
		.append("endDate", tp.getEnddate());
		
		Map<String, String> hm = tp.getData();
		
		Iterator it = hm.entrySet().iterator();
		
		while(it.hasNext()) {
			Map.Entry<String, String> e = (Map.Entry<String, String>) it.next();
			doc.append(e.getKey(), e.getValue());
		}
		
		//insert to mongoDB
		trainingPlanCollection.insertOne(doc);

		//Close the Connection
		connec.closeConnection();
	}
	
	public void updateTrainingPlan(TrainingPlan tp) {
		//Connect to Collection
		trainingPlanCollection = connec.getRequiredCollection("TrainingPlan");
		
		Document doc = new Document("username", tp.getUsername())
		.append("startDate", tp.getStartdate())
		.append("endDate", tp.getEnddate());
		
		Map<String, String> hm = tp.getData();
		Document temp = new Document();
		Iterator it = hm.entrySet().iterator();
		while(it.hasNext()) {
			Map.Entry<String, String> e = (Entry<String, String>) it.next();
			temp.append(e.getKey(), e.getValue());
		}
		
		Document updated = new Document("$set",temp);
		trainingPlanCollection.updateOne(doc, updated);
		
		//Close the Connection
		connec.closeConnection();
	}
	
	public List<String> getTrainingPlanDate(String username) {
		List<String> result = new ArrayList<String>();
		//Connect to the collection
		trainingPlanCollection = connec.getRequiredCollection("TrainingPlan");
		
		Document doc = new Document("username",username);
		FindIterable<Document> temp = trainingPlanCollection.find(doc);
		for(Document d : temp) {
			if(d != null) {
				result.add(d.get("startDate").toString() + " - " + d.get("endDate").toString());
			}
		}
		//Close the connection
		connec.closeConnection();
		Collections.sort(result, new Comparator<String>() {
			public int compare(String s1, String s2) {
				Date d1 = new Date(s1.substring(0,10));
				Date d2 = new Date(s2.substring(0,10));
				return d1.compareTo(d2);
			}
		});
		return result;
	}
	
	public TrainingPlan getTrainingPlan(String username, String startDate, String endDate) {
		TrainingPlan result = new TrainingPlan();
		result.setUsername(username);
		result.setStartdate(startDate);
		result.setEnddate(endDate);
		//Connect to the collection
		trainingPlanCollection = connec.getRequiredCollection("TrainingPlan");
		
		Document doc = new Document("username",username).append("startDate", startDate).append("endDate", endDate);
		
		FindIterable<Document> temp = trainingPlanCollection.find(doc);
		
		Document tempDoc = temp.first();
		
		result.setData("weekData", tempDoc.get("weekData").toString());
		result.setData("st1",tempDoc.get("st1").toString());
		result.setData("st2", tempDoc.get("st2").toString());
		result.setData("ft", tempDoc.get("ft").toString());
		
		
		//Close the connection
		connec.closeConnection();
		
		return result;
	}
	
}
