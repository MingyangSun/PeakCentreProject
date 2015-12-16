package Util;

import com.peakcentre.web.entity.Userinfo;
import com.sun.istack.internal.FinalArrayList;

public class UserNonPrivateInfo {
	private String usertype;
	private String city;
	private String username;
	private String fname;
	private String lname;
	private String level;
	private String gender;
	private String dob;
	private String picpath;
	
	public UserNonPrivateInfo(String usertype, String city, String username, String fname, String lname, String level,
			String gender, String dob, String picpath) {
		super();
		this.usertype = usertype;
		this.city = city;
		this.username = username;
		this.fname = fname;
		this.lname = lname;
		this.level = level;
		this.gender = gender;
		this.dob = dob;
		this.picpath = picpath;
	}
	
	public UserNonPrivateInfo(final Userinfo ui) {
		this.usertype = ui.getUsertype();
		this.city = ui.getCity();
		this.username = ui.getUsername();
		this.fname = ui.getFname();
		this.lname = ui.getLname();
		this.level = ui.getLevel();
		this.gender = ui.getGender();
		this.dob = ui.getDob();
		this.picpath = ui.getPicpath();
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
