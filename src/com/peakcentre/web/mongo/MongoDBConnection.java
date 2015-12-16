package com.peakcentre.web.mongo;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class MongoDBConnection {
	
	private MongoClient mongoClient;
	
	public MongoCollection<Document> getRequiredCollection(String collec){
		mongoClient = new MongoClient( "localhost" , 27017 );
		return mongoClient.getDatabase("testpeak").getCollection(collec);
	}
	
	public void closeConnection(){
		if (mongoClient!=null){
			mongoClient.close();
		}
	}

}
