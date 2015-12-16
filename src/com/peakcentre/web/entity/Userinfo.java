package com.peakcentre.web.entity;
import java.util.*;
public class Userinfo {
	private int id;
	private String usertype;
	private String city;
	private String username;
	private String password;
	private String fname;
	private String lname;
	private String level;
	private String gender;
	private String dob;
	private String picpath;

	
	public static ArrayList<String> getPropertities(){

		ArrayList<String> arrayList = new ArrayList<>();

		arrayList.add("usertype");

		arrayList.add("city");

		arrayList.add("username");

		arrayList.add("password");

		arrayList.add("fname");

		arrayList.add("lname");

		arrayList.add("level");

		arrayList.add("gender");

		arrayList.add("dob");

		arrayList.add("picpath");

		return arrayList;

		}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsertype() {
		return usertype;
	}

	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getPicpath() {
		return picpath;
	}

	public void setPicpath(String picpath) {
		this.picpath = picpath;
	}
}
