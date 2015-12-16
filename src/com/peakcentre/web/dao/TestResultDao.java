package com.peakcentre.web.dao;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.HashSet;

import org.bson.Document;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mongodb.Block;
import com.mongodb.DBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MapReduceIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.util.JSON;
import com.peakcentre.web.entity.TestResult;
import com.peakcentre.web.entity.TestResultTemplate;
import com.peakcentre.web.entity.Userinfo;
import com.sun.research.ws.wadl.Doc;
import com.peakcentre.web.mongo.*;

//Used for Test Result related database manipulation
public class TestResultDao {
	MongoDBConnection connec = new MongoDBConnection();
	MongoCollection<Document> testResultCollection;

	//insert data into TestResult Table
	public void insertTestResult(TestResult tr) {
		Map<String, String> hm = tr.getData();
		//Connect to the Collection(Table)
		testResultCollection = connec.getRequiredCollection("TestResult");
		List<Document> l = new ArrayList<Document>();
		try {
		Iterator it = hm.entrySet().iterator();
		while(it.hasNext()) {
			Map.Entry<String, String> e = (Map.Entry<String, String>)it.next();
			Document doc;
			
			ArrayList<DBObject> v = new ArrayList<DBObject>();
			JSONArray a = new JSONArray(e.getValue());
			for(int i = 0; i < a.length(); i++) {
				v.add((DBObject)JSON.parse(a.get(i).toString()));
			}
			
				doc = new Document("username",tr.getUsername())
				.append("date", tr.getDate())
				.append("tempId", tr.getTempId())
				.append("table", e.getKey())
				.append("data", v);
				l.add(doc);
		}
		//insert to mongodb
		testResultCollection.insertMany(l);
		
		//Close the Connection
		connec.closeConnection();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}



	//Get Template Names of one user
	public ArrayList<String> getTemplateNames(String username) {
		
		testResultCollection = connec.getRequiredCollection("TestResult");
		
		FindIterable<Document> tempList = testResultCollection.find(new Document("username", username));
		HashSet<Integer> tempIdList = new HashSet<Integer>();
		
		for(Document doc: tempList){
			if (doc != null) {
				tempIdList.add(Integer.parseInt(doc.get("tempId")+""));
			}
		}
		connec.closeConnection();
		
		ArrayList<String> tempNameList = new ArrayList<String>();
		
		for(int id : tempIdList) {
			testResultCollection = connec.getRequiredCollection("TestResultTemplate");
			FindIterable<Document> l = testResultCollection.find(new Document("id",id));
			for(Document doc: l){
				if (doc != null) {
					tempNameList.add(doc.get("name").toString());
				}
			}
			connec.closeConnection();
		}
		
		return tempNameList;
	}

	//Get test result dates of one user
	public ArrayList<String> getDates(String username) {
		testResultCollection = connec.getRequiredCollection("TestResult");
		
		FindIterable<Document> tempList = testResultCollection.find(new Document("username", username));
		HashSet<String> tempDateList = new HashSet<String>();
		
		for(Document doc: tempList){
			if (doc != null) {
				tempDateList.add(doc.get("date").toString());
			}
		}
		
		connec.closeConnection();
		
		ArrayList<String> result = new ArrayList<String>();
		for(String s : tempDateList) {
			result.add(s);
		}
		//Sort
		Collections.sort(result, new Comparator<String>() {
			public int compare(String s1, String s2) {
				Date d1 = new Date(s1);
				Date d2 = new Date(s2);
				return d1.compareTo(d2);
			}
		});
		
		return result;
		
	}

	public ArrayList<String> getDatesByUserNameAndTemplateName(String username, String templateName) {
		ArrayList<String> result = new ArrayList<String>();
		HashSet<String> temp = new HashSet<String>();
		
		testResultCollection = connec.getRequiredCollection("TestResultTemplate");
		int id=0;
		Document doc1 = new Document("name", templateName);
		FindIterable<Document> tempList1 = testResultCollection.find(doc1);
		if (tempList1.first() != null) {
			id = (int) tempList1.first().get("id");
		}		
		
		connec.closeConnection();
		
		testResultCollection = connec.getRequiredCollection("TestResult");
		Document doc = new Document("username", username).append("tempId", id);
		FindIterable<Document> allResult = testResultCollection.find(doc);
		for(Document d : allResult) {
			temp.add(d.get("date").toString());
		}
		for(String s : temp) {
			result.add(s);
		}
		Collections.sort(result, new Comparator<String>() {
			public int compare(String s1, String s2) {
				Date d1 = new Date(s1);
				Date d2 = new Date(s2);
				return d1.compareTo(d2);
			}
		});
		connec.closeConnection();
		
		return result;
	}
	//Check if template name and date exists of one user
	public boolean checkNameDate(String username, String tempName, String date)
			throws Exception {
		testResultCollection = connec.getRequiredCollection("TestResultTemplate");
		int id=0;
		Document doc1 = new Document("name", tempName);
		FindIterable<Document> tempList1 = testResultCollection.find(doc1);
		if (tempList1.first() != null) {
			id = (int) tempList1.first().get("id");
		}
		
		connec.closeConnection();
		
		testResultCollection = connec.getRequiredCollection("TestResult");
		boolean flag = false;
		
		if(id == 0) System.out.println("********Error**********");

		Document doc = new Document("username", username).append("date", date)
				.append("tempId", id);
		
		FindIterable<Document> tempList = testResultCollection.find(doc);
		if (tempList.first() != null) {
			flag = true;
		}
		
		connec.closeConnection();
		return flag;
	}

	
	//Get test result
	public TestResult getTestResult(String username, int tempId, String date) {
		final TestResult result = new TestResult();
		//Connect to the Collection(Table)
		testResultCollection = connec.getRequiredCollection("TestResult");
	
		result.setDate(date);
		result.setTempId(tempId);
		result.setUsername(username);
		FindIterable<Document> iterable = testResultCollection.find(new Document("username",username).append("tempId", tempId).append("date", date));
		
		iterable.forEach(new Block<Document>() {
			@Override
			public void apply(Document document) {
				try{
				String temp = document.toJson();
				JSONObject d = new JSONObject(temp);
				JSONArray ja = d.getJSONArray("data");
				List<String> ls = new ArrayList<String>();
				for(int i = 0; i < ja.length(); i++) {
					ls.add(ja.getJSONObject(i).toString());
				}
				result.setData((String)document.get("table"), ls.toString());
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		});
		
		//Close the Connection
		connec.closeConnection();
		
		return result;
	}
	
	public void updateTestResult(TestResult tr) {
		//Connect to the Collection(Table)
		testResultCollection = connec.getRequiredCollection("TestResult");
		
		String username = tr.getUsername();
		int tempId = tr.getTempId();
		String date = tr.getDate();
		Map<String, String> hm = tr.getData();
		try{
		Iterator it = hm.entrySet().iterator();
		
		while(it.hasNext()) {
			Map.Entry<String, String> e = (Map.Entry<String, String>)it.next();

			ArrayList<DBObject> v = new ArrayList<DBObject>();
			JSONArray a = new JSONArray(e.getValue());
			for(int i = 0; i < a.length(); i++) {
				v.add((DBObject)JSON.parse(a.get(i).toString()));
			}
			testResultCollection.updateOne(new Document("username", username).append("date", date).append("tempId", tempId).append("table", e.getKey()), new Document("$set", new Document("data", v)));
		}
		
		//Close the Connection
		connec.closeConnection();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<List<Object>> getAverage(String username, String table, int tempId, String col1, String col2 ) {
		List<List<Object>> result = new ArrayList<List<Object>>();
		List<Object> index = new ArrayList<Object>();
		List<Object> value = new ArrayList<Object>();
		testResultCollection = connec.getRequiredCollection("TestResult");
		Document doc = new Document("tempId", tempId).append("table",table);
		int n = 0;
		FindIterable<Document> l = testResultCollection.find(doc);
		for(Document d : l) {
			n++;
		}
		String map = "function() {" +
				"for(var i=0; i < this.data.length; i++) {"
				+	"emit(this.data[i]."+ col1 +",parseInt(this.data[i]." + col2+ "));"
				+	"}"
				+ "}";
		String reduce = "function(key, values) {"
				+"var ave=0;"
				+"for(var i=0; i<values.length; i++) {"
				+	"ave += values[i];"
				+"}"
				//+"ave = ave/values.length;"
				+"return ave;"
				+"}";
		MapReduceIterable<Document> d = testResultCollection.mapReduce(map, reduce).filter(doc);
		List<Document> temp = new ArrayList<Document>();
		for(Document x :  d) {
			temp.add(x);
		}
		Collections.sort(temp, new Comparator<Document>() {
			@Override
			public int compare(Document o1, Document o2) {
				int a = Integer.parseInt(o1.get("_id").toString());
				int b = Integer.parseInt(o2.get("_id").toString());
				if(a < b) return -1;
				if(a > b) return 1;
				return 0;
			}
		});
		for(Document x : temp) {
			index.add(x.get("_id"));
			double tempValue = Double.parseDouble(x.get("value").toString())/(double)n;
			value.add("" + tempValue);
		}
		result.add(index);
		result.add(value);
		
		return result;
	}
}
