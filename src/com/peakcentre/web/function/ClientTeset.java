package com.peakcentre.web.function;

import java.io.File;
import java.net.URI;
import java.util.*;

import javax.ws.rs.client.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;

import org.glassfish.jersey.client.ClientConfig;

import com.google.gson.Gson;
import com.peakcentre.web.entity.*;
import com.peakcentre.web.dao.*;


public class ClientTeset {
	public static void main(String[] args) {
		File folder = new File("/Users/sunmingyang/Desktop/peakcenter-2015-09-29/peakcenter/Peak Centre Project/PeakCentreProject/WebContent/video/");
		File[] listOfFiles = folder.listFiles();

		    for (int i = 0; i < listOfFiles.length; i++) {
		      if (listOfFiles[i].isFile()) {
		        System.out.println("File " + listOfFiles[i].getName());
		      } else if (listOfFiles[i].isDirectory()) {
		        System.out.println("Directory " + listOfFiles[i].getName());
		      }
		    }
	}
/*
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		TestResultTemplateDao tpd = new TestResultTemplateDao();
		ArrayList<String> t = tpd.getAllTemplateAlias();
		for(String s: t) {
			System.out.println(s);
		}
		/*
		Userinfo ui = new Userinfo();
		ui.setUsertype("Administrator");
		ui.setUsername("222@a.com");
		ui.setPassword("2223");
		System.out.println("Test login : " + ModelApplier.checkLogin(ui));
		*/
		
		// TODO Auto-generated method stub
//		UserinfoDao doDao = new UserinfoDao();
//		Userinfo ui = new Userinfo();
//		 ui.setCity("Ottawa");
//		 ui.setUsertype("Athlete");
//		 ui.setUsername("a4");
//		 ui.setPassword("123");
//		 ui.setFname("a4");
//		 ui.setLname("a4");
//		 ui.setLevel("level");
//		 ui.setGender("female");
//		 doDao.insertUser(ui);
	/*
		CoachAthletesDao coachAthletesDao = new CoachAthletesDao();
		coachAthletesDao.insertAthlete("a1", "c1");
		coachAthletesDao.insertAthlete("a2", "c1");
		coachAthletesDao.insertAthlete("a3", "c1");
		coachAthletesDao.insertAthlete("a4", "c1");
		
	
		////
		// doDao.getUserinfoById("563aa2b9654171076124a2dc");
		// System.out.println("user is " +
		//// doDao.getUserinfoById("563aa2b9654171076124a2dc").getUsername());
//		CoachAthletesDao coachAthletesDao = new CoachAthletesDao();
//		ArrayList<Userinfo> test = coachAthletesDao.getAllathByPage("563c15216541710acf0d8a97", 3, 1);
//		for (Userinfo userinfo : test) {
//			System.out.println("user is " + userinfo.getUsername());
//		}
	}
*/
}
