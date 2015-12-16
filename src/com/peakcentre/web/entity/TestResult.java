package com.peakcentre.web.entity;
import java.util.*;
/*
public class TestResult {
	private int id;
	private String username;
	private int tempId;
	private String date;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getTempId() {
		return tempId;
	}

	public void setTempId(int tempId) {
		this.tempId = tempId;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
*/	
/*
*New TestResult 
*/

public class TestResult {
	private String username;
	private int tempId;
	private String date;
	private Map<String, String> map = new HashMap<String, String>();
	

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getTempId() {
		return tempId;
	}

	public void setTempId(int tempId) {
		this.tempId = tempId;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	public void setData(String tableName, String data) {
		this.map.put(tableName, data);
	}
	
	public Map<String, String> getData() {
		return this.map;
	}

}
