package com.peakcentre.web.config;

public class GetFilePath {
	public static String getBaseTemplatePath() {
		return "/Users/sunmingyang/Documents/temp/";
		//return "S:\\DemoWebsite\\tomcat7\\tomcat7\\webapps\\PeakCentreProject\\template\\";
		//return "/usr/share/tomcat7/webapps/PeakCentreProject/template/";
	}
	
	public static String getBasePicturePath() {
		return "/Users/sunmingyang/Desktop/peakcenter-2015-09-29/peakcenter/Peak Centre Project/PeakCentreProject/WebContent/pic/";
		//return "S:\\DemoWebsite\\tomcat7\\tomcat7\\webapps\\PeakCentreProject\\pic\\";
		//return "/usr/share/tomcat7/webapps/PeakCentreProject/pic/";
	}
	
	public static String getBaseVideoPath() {
		return "/Users/sunmingyang/Desktop/peakcenter-2015-09-29/peakcenter/Peak Centre Project/PeakCentreProject/WebContent/video/";
		//return "S:\\DemoWebsite\\tomcat7\\tomcat7\\webapps\\PeakCentreProject\\video\\";
		//return "/usr/share/tomcat7/webapps/PeakCentreProject/video/";
	}
	
	public static void main(String[] args) {
		String temp = getBaseTemplatePath();
		System.out.println("Path:" + temp);
		temp = getBaseVideoPath();
		System.out.println("Path:" + temp);
		
	}
	
}
