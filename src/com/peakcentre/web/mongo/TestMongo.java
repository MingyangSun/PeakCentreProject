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

public class TestMongo {
	public static void main(String[] args) {
		TestResultTemplateDao tpd = new TestResultTemplateDao();
		System.out.println("next id: "+ tpd.TestNextId());
	}
	/*
	   public static void main (String args[]) {

		   String workingDir = System.getProperty("user.dir");
		   System.out.println("Current working directory : " + workingDir);
		   
	   }
	   */
/*
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		TestResultDao trd = new TestResultDao();
		List<List<Object>> r = trd.getAverage("111@a.com", "1", 1,"S1", "S2");
		List<Object> index = r.get(0);
		List<Object> value = r.get(1);
		for(int i = 0; i < index.size(); i++) {
			System.out.println("" +index.get(i)+ ","+value.get(i) );
		}
		/*
		MongoDBConnection conn = new MongoDBConnection();
		MongoCollection<Document> collection = conn.getRequiredCollection("TestResult");
		Document doc = new Document("username","111@a.com").append("tempId", 1).append("table","1");
		String map = "function() {" +
				"for(var i=0; i < this.data.length; i++) {"
				+	"emit(this.data[i].S1,parseInt(this.data[i].S2));"
				+	"}"
				+ "}";
		String reduce = "function(key, values) {"
				+"var ave=0;"
				+"for(var i=0; i<values.length; i++) {"
				+	"ave += values[i];"
				+"}"
				+"ave = ave/values.length;"
				+"return ave;"
				+"}";
		MapReduceIterable<Document> d = collection.mapReduce(map, reduce).filter(doc);
		for(Document x : d) {
			System.out.println("x:" + x.get("_id").toString());
			System.out.println("y:" + x.get("value").toString());
		}
		*/
	//}
	

}
