package com.peakcentre.web.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.bson.Document;

import com.peakcentre.web.entity.*;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;

import com.peakcentre.web.mongo.*;


//Used for Test Result Template related database manipulation
public class TestResultTemplateDao {
	MongoDBConnection connec = new MongoDBConnection();
	MongoCollection<Document> tempCollection;

	//Check if template name exists
	public boolean checkTempName(String name) {
		tempCollection = connec.getRequiredCollection("TestResultTemplate");

		boolean flag = true;
		
		Document doc = new Document("name", name);
		FindIterable<Document> tempList = tempCollection.find(doc);
		if (tempList.first() != null) {
			flag = false;
		}

		connec.closeConnection();
		return flag;
	}

	//Get next id of table TestResultTemplate
	public String getNextId() {
		return null;
	}

	//insert date into table TestResultTemplate
	public boolean insertTemplate(TestResultTemplate trt) {

		int id = NextId();
		
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		final long previousCount = tempCollection.count();
		
		Document doc = new Document("name", trt.getName()).append("temppath", trt.getTemppath()).append("id", id);
		
		tempCollection.insertOne(doc);
		boolean a = tempCollection.count() > previousCount;
		connec.closeConnection();
		return a;

	}

	//Create Template table in db
	public boolean createTemplateTable(String templateName, int tableNumber,
			ArrayList<ArrayList<String>> columns) {
		return false;

	}
	
	public int TestNextId() {
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		int max = 0;
		int count = (int) tempCollection.count();
		Document doc = new Document("id", new Document("$gt", count-1));
		FindIterable<Document> list = tempCollection.find(doc);
		for(Document d : list) {
			int temp = Integer.parseInt(d.get("id").toString());
			if(temp > max)  max=temp;
		}
		connec.closeConnection();
		return max+1;
	}
	
	public int NextId() {
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		int max = 0;
		FindIterable<Document> tempList = tempCollection.find();
		for(Document d : tempList) {
			int temp = Integer.parseInt(d.get("id").toString());
			if(temp >  max) max = temp;
		}
		connec.closeConnection();
		return max+1;
	}
	//Delete a template
	public boolean deleteTemplate(String name) {
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		final long previousCount = tempCollection.count();
		
		
		Document doc = new Document("name", name);
		tempCollection.deleteOne(doc);
		boolean a = previousCount > tempCollection.count();
		connec.closeConnection();
		return a;
	}

	//Delete template table from db
	public boolean deleteTemplateTable(String name) {
		return false;
	}

	//Get template path from table TestResultTemplate by template name
	public String getTempPathByName(String name) {
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		String tempPath = null;
		
		Document doc = new Document("name", name);
		FindIterable<Document> tempList = tempCollection.find(doc);
		if (tempList.first() != null) {
			tempPath = tempList.first().get("temppath").toString();
		}
		
		connec.closeConnection();
		return tempPath;

	}

	//Get template alias 
	public ArrayList<String> getAllTemplateAlias() {
		ArrayList<String> result = new ArrayList<String>();
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		FindIterable<Document> tempList = tempCollection.find();
		for(Document d : tempList) {
			String path = d.get("temppath").toString();
			result.add(path.substring(0, path.indexOf(".xml")));
		}
		connec.closeConnection();
		return result;
	}
	
	//Get template id from table TestResultTemplate by template name
	public int getTempIdByName(String name) {
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		int id = 0;
		
		Document doc = new Document("name", name);
		FindIterable<Document> tempList = tempCollection.find(doc);
		if (tempList.first() != null) {
			System.out.println("id: " + tempList.first().get("id"));
			id = (int)tempList.first().getInteger("id");
		}
		
		connec.closeConnection();
		return id;

	}
	public ArrayList<String> getAllTempName(){
		ArrayList<String> allNames = new ArrayList<String>();
		
		FindIterable<Document> list = connec.getRequiredCollection("TestResultTemplate").find();
		for(Document doc: list){
			allNames.add(doc.get("name").toString());
		}
		
		connec.closeConnection();
		return allNames;
		
	}
	
	public String getTempNameByAlias(String alias) {
		String result = "";
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		Document doc = new Document("temppath", alias+".xml");
		FindIterable<Document> list = tempCollection.find(doc);
		result = list.first().get("name").toString();
		connec.closeConnection();
		return result;
	}
}