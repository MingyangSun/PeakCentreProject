package com.peakcentre.web.dao;
import java.util.ArrayList;

import org.bson.Document;

import Util.peakcentreUtil;

import com.peakcentre.web.entity.*;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.result.UpdateResult;
import com.peakcentre.web.mongo.*;

//Used for User Account related database manipulation

public class UserinfoDao {

MongoDBConnection connec = new MongoDBConnection();

MongoCollection<Document> userCollection;


//insert data into table Userinfo  updated

public boolean insertUser(final Userinfo userinfo) {

		Boolean flag = false;
		int id = Integer.parseInt(NextId());
		//connect to database
		
		userCollection = connec.getRequiredCollection("Userinfo");
		
		final long previousCount = userCollection.count();
		
		
		
		Document doc = new Document("usertype", userinfo.getUsertype()).append("city", userinfo.getCity())
		.append("username", userinfo.getUsername()).append("password", userinfo.getPassword())
		.append("fname", userinfo.getFname()).append("lname", userinfo.getLname())
		.append("level", userinfo.getLevel()).append("gender", userinfo.getGender())
		.append("dob", userinfo.getDob()).append("picpath", userinfo.getPicpath()).append("id", id);
		
		
		
		userCollection.insertOne(doc);
		
		//how to check if the insert operation works? I compared the count of collection.
		
		if (userCollection.count() > previousCount) {
		
		flag = true;
		
		}
		
		
		
		//close connection.
		
		connec.closeConnection();
		
		
		return flag;

}

public boolean checkExistByUsername(final String username) {
	return checkIfUserExist(new Document("username", username));
}

public Userinfo getUserinfoById(int id) {
	Userinfo result = new Userinfo();
	
	userCollection = connec.getRequiredCollection("Userinfo");
	
	Document doc = new Document("id", id);
	FindIterable<Document> user = userCollection.find(doc);
	for(Document d : user) {
		  result.setId(id);
		  result.setCity(d.get("city").toString());
		  result.setFname(d.get("fname").toString());
		  result.setGender(d.get("gender").toString());
		  result.setPassword(d.get("password").toString());
		  result.setLevel(d.get("level").toString());
		  result.setLname(d.get("lname").toString());
		  result.setDob(d.get("dob").toString());
		  result.setPicpath(d.get("picpath").toString());
		  result.setUsertype(d.get("usertype").toString());
		  result.setUsername(d.get("username").toString());
	}
	connec.closeConnection();
	return result;
}

public boolean checkLogin(Userinfo ui) {
	try {
		return this.checkLogin(ui.getUsername(), ui.getPassword(), ui.getUsertype());
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return false;
}
public Userinfo getUserinfoByUsernameAndType(final String username, final String type){
	return getUserinfoByDoc(new Document("username", username).append("usertype", type)).get(0);
}

private ArrayList<Userinfo> getUserinfoByDoc(final Document doc) {
	userCollection = connec.getRequiredCollection("Userinfo");

	ArrayList<Userinfo> list = new ArrayList<Userinfo>();

	FindIterable<Document> userList = userCollection.find(doc);

	if (userList != null) {

		for (Document user : userList) {
			// convert to userinfo with values in user(Document).
			list.add(peakcentreUtil.setValuesForUserByDoc(user));
		}
	}
	connec.closeConnection();
	return list;
}

// Check if user exists by username and usertype
public boolean checkExistsByUsernameAndType(final String username, final String userType) {
	return checkIfUserExist(new Document("username", username).append("usertype", userType));
}

// check user exists by using given attribute.
private boolean checkIfUserExist(final Document doc) {
	userCollection = connec.getRequiredCollection("Userinfo");
	FindIterable<Document> userList = userCollection.find(doc);

	// close connection.
	boolean userExist = (userList.first() != null);
	connec.closeConnection();
	return userExist;
}

public ArrayList<Userinfo> getUserinfoByFnameAndLname(String fname, String lname) {
	return getUserinfoByDoc(new Document("fname", fname).append("lname", lname));
}

	public String NextId() {
		userCollection = connec.getRequiredCollection("Userinfo");
		FindIterable<Document> userList = userCollection.find();
		int max = 0;
		for(Document d : userList) {
			int temp  = (int)d.get("id");
			if(temp > max) max = temp;
		}
		connec.closeConnection();
		return (max+1) + "";
	}
//Check if login information correct

public boolean checkLogin(final String username, final String password, final String usertype) throws Exception {

		userCollection = connec.getRequiredCollection("Userinfo");
		
		
		boolean flag = false;
		
		Document doc = new Document("username", username).append("usertype", usertype);
		
		//get collections according to username and type, then compare psw.
		
		
		FindIterable<Document> userList = userCollection.find(doc);
		
		if (userList != null) {
		
		for(Document user: userList){
		
		boolean match = user.get("password").equals(password);
		
		flag = flag || match;
		
		}

		}
		
		
		connec.closeConnection();
		
		return flag;

}



//Get a user's first name

public String getFirstName(Userinfo user) {

		userCollection = connec.getRequiredCollection("Userinfo");
		
		String username = user.getUsername();
		
		
		String fname = "user";
		
		FindIterable<Document> userList = userCollection.find(new Document("username", username));
		
		if (userList.first() != null) {
		
		fname = userList.first().get("fname").toString();
		
		}
		
		
		//close connection.
		
		connec.closeConnection();
		
		return fname;

}



//Get a user's city

public String getCity(Userinfo user) {

		userCollection = connec.getRequiredCollection("Userinfo");
		
		String username = user.getUsername();
		
		
		String city = "Ottawa";
		
		FindIterable<Document> userList = userCollection.find(new Document("username", username));
		
		if (userList.first() != null) {
		
		city = userList.first().get("city").toString();
		
		}
		
		
		//close connection.
		
		connec.closeConnection();
		
		return city;

}



//Get a user's id

public String getUserId(Userinfo user) {

		userCollection = connec.getRequiredCollection("Userinfo");
		
		String username = user.getUsername();
		
		
		String id = "id";
		
		FindIterable<Document> userList = userCollection.find(new Document("username", username));
		
		if (userList.first() != null) {
		
		id = userList.first().get("id").toString();
		
		}
		
		
		//close connection.
		
		connec.closeConnection();
		
		return id;

}



//Check if username already exists

public boolean checkUsername(String username) {

		userCollection = connec.getRequiredCollection("Userinfo");
		
		
		FindIterable<Document> userList = userCollection.find(new Document("username", username));
		
		
		//close connection.
		boolean a=(userList.first() != null);		
		connec.closeConnection();

		return !a;
		 

}


//Check if username already exists

public boolean checkUserExistsWithUsertype(String fname, String lname, String city) {

		userCollection = connec.getRequiredCollection("Userinfo");
		
		
		FindIterable<Document> userList = userCollection.find(new Document("fname", fname)
		
		.append("lname", lname).append("city", city));
		
		boolean a = (userList.first() != null);
		
		//close connection.
		
		connec.closeConnection();
		
		return a;

}


//Check if username already exists

public boolean checkUserExists(String fname, String lname) {

		userCollection = connec.getRequiredCollection("Userinfo");
		
		
		FindIterable<Document> userList = userCollection.find(new Document("fname", fname).append("lname", lname));
		
		
		
		//close connection.
		
		boolean a = (userList.first() != null);
		connec.closeConnection();
		
		return a;

}





//get user infomation accordind to fname and lname

public ArrayList<Userinfo> getUserinfo(String fname, String lname) {



		userCollection = connec.getRequiredCollection("Userinfo");
		
		ArrayList<Userinfo> list = new ArrayList<Userinfo>();
		
		Document doc = new Document("fname", fname).append("lname", lname);
		
		
		FindIterable<Document> userList = userCollection.find(doc);
		
		if (userList != null) {
		
		for(Document user: userList){
		
		int itemId = (Integer)user.get("id");
		
		  String itemUsertype = user.get("usertype").toString();
		
		  String itemCity = user.get("city").toString();
		
		  String itemUsername = user.get("username").toString();
		
		  String itemPassword = user.get("password").toString();
		
		  String itemFname = user.get("fname").toString();
		
		  String itemLname = user.get("lname").toString();
		
		  String itemLevel = user.get("level").toString();
		
		  String itemGender = user.get("gender").toString();
		
		  String itemDob = user.get("dob").toString();
		  String itemPicpath ="";
		  if(user.get("picpath") == null || user.get("picpath").equals("")) {
			  itemPicpath = "default";
		  }else {
           itemPicpath= user.get("picpath").toString();
		  }
		  Userinfo temp = new Userinfo();
		  temp.setId(itemId);
		  temp.setCity(itemCity);
		  temp.setFname(itemFname);
		  temp.setGender(itemGender);
		  temp.setPassword(itemPassword);
		  temp.setLevel(itemLevel);
		  temp.setLname(itemLname);
		  temp.setDob(itemDob);
		  temp.setPicpath(itemPicpath);
		  temp.setUsertype(itemUsertype);
		  temp.setUsername(itemUsername);
		  
		  list.add(temp);
		//list.add(new Userinfo(itemId, itemUsertype, itemCity, itemUsername,
		
		//itemPassword, itemFname, itemLname, itemLevel, itemGender, itemDob, itemPicpath));
		
		}
		
		}
		
		
		
		connec.closeConnection();
		
		return list;

}


//Update table userinfo

public boolean updateUserinfo(Userinfo user) {
	userCollection = connec.getRequiredCollection("Userinfo");
	boolean flag = false;
	
	ArrayList values = new ArrayList<String>();
	values.add(user.getUsertype());
	values.add(user.getCity());
	values.add(user.getUsername());
	values.add(user.getPassword());
	values.add(user.getFname());
	values.add(user.getLname());
	values.add(user.getLevel());
	values.add(user.getGender());
	values.add(user.getDob());
	values.add(user.getPicpath());

	
	Document newDoc = new Document();
	
	for (int i = 0; i < Userinfo.getPropertities().size(); i++) {
		newDoc.append(Userinfo.getPropertities().get(i), values.get(i));
	}
	
	UpdateResult result = userCollection.updateMany(new Document("id", user.getId()),
			new Document("$set", newDoc));
	flag = result.getModifiedCount() > 0;
	
	connec.closeConnection();
	return flag;
}
		
		
		
		//Delete user from table userinfo
		
		public boolean deleteUser(int id) {
		System.out.println("D:"+id);
		boolean flag = false;
		
		userCollection = connec.getRequiredCollection("Userinfo");
		
		final long previousCount = userCollection.count();
		
		userCollection.deleteOne(new Document("id", id));
		
		if (userCollection.count()< previousCount) {
		
		flag = true;
		
		}
		
		connec.closeConnection();
		
		return flag;
		
		}
		


}

