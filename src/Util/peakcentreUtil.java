package Util;

import org.bson.Document;

import com.peakcentre.web.entity.Userinfo;

public class peakcentreUtil {
	public static Userinfo setValuesForUserByDoc(Document user){
		String itemUserId = user.get("id") == null ? "unknown" : user.get("id").toString();
		String itemUsertype = user.get("usertype") == null ? "unknown" : user.get("usertype").toString();
		String itemCity = user.get("city") == null ? "unknown" : user.get("city").toString();
		String itemUsername = user.get("username") == null ? "unknown" : user.get("username").toString();
		String itemPassword = user.get("password") == null ? "unknown" : user.get("password").toString();
		String itemFname = user.get("fname") == null ? "unknown" : user.get("fname").toString();
		String itemLname = user.get("lname") == null ? "unknown" : user.get("lname").toString();
		String itemLevel = user.get("level") == null ? "unknown" : user.get("level").toString();
		String itemGender = user.get("gender") == null ? "unknown" : user.get("gender").toString();
		String itemDob = user.get("dob") == null ? "unknown" : user.get("dob").toString();
		String itemPicpath = "";
		if (user.get("picpath") == null || user.get("picpath").equals("")) {
			itemPicpath = "1";
		} else {
			itemPicpath = user.get("picpath").toString();
		}
		Userinfo temp = new Userinfo();
		temp.setId(Integer.parseInt(itemUserId));
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
		return temp;
	}

}
