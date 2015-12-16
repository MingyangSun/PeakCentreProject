package com.peakcentre.web.mongo;
import java.util.List;


import org.bson.Document;

import com.mongodb.DBCollection;
import com.mongodb.MapReduceCommand;
import com.mongodb.MapReduceOutput;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MapReduceIterable;
import com.mongodb.client.MongoCollection;
import com.peakcentre.web.entity.Userinfo;
import com.peakcentre.web.dao.*;

public class AddAdmin {
	public static void main(String[] args) {
		UserinfoDao uid = new UserinfoDao();
		Userinfo temp = new Userinfo();
		temp.setUsertype("Administrator");
		temp.setId(1);
		temp.setCity("ottawa");
		temp.setDob("12/01/2014");
		temp.setFname("a");
		temp.setGender("Male");
		temp.setLevel("Elite");
		temp.setLname("a");
		temp.setPassword("222");
		temp.setPicpath("1");
		temp.setUsername("222@a.com");
		uid.insertUser(temp);
	}
}