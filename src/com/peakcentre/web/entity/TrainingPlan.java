package com.peakcentre.web.entity;

import java.util.*;

public class TrainingPlan {
	private String username;
	private String startdate;
	private String enddate;
	private HashMap<String, String> data = new HashMap<String, String>();

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	
	public void setData(String key, String value) {
		data.put(key,value);
	}
	
	public Map<String,String> getData() {
		return this.data;
	}

}
