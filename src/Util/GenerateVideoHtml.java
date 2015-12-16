package Util;

import java.io.File;

import com.peakcentre.web.config.GetFilePath;

public class GenerateVideoHtml {
	public static String generateHtml() {
		String result = "<select>";
		File folder = new File(GetFilePath.getBaseVideoPath());
		File[] listOfFiles = folder.listFiles();
		for (int i = 0; i < listOfFiles.length; i++) {
		      if (listOfFiles[i].isFile()) {
		    	  String tmp = listOfFiles[i].getName().substring(0,listOfFiles[i].getName().lastIndexOf(".mp4"));
		    	  result += "<option>" + tmp + "</option>";
		    	  System.out.println("File " + listOfFiles[i].getName().substring(0,listOfFiles[i].getName().lastIndexOf(".mp4")));
		      } 
		}
		result += "</select>";
		return result;
	}
	
	public static String[] getAllOptions() {
		File folder = new File(GetFilePath.getBaseVideoPath());
		File[] listOfFiles = folder.listFiles();
		String[] result = new String[listOfFiles.length];
		for (int i = 0; i < listOfFiles.length; i++) {
		      if (listOfFiles[i].isFile()) {
		    	  String tmp = listOfFiles[i].getName().substring(0,listOfFiles[i].getName().lastIndexOf(".mp4"));
		    	  result[i] = tmp;
		      } 
		}
		return result;
	}
}
