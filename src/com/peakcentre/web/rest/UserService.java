package com.peakcentre.web.rest;

import java.net.URI;
import java.net.URISyntaxException;

import com.peakcentre.web.entity.*;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.glassfish.jersey.server.Uri;

import com.peakcentre.web.entity.Userinfo;
import com.peakcentre.web.dao.*;

@Path("/users")
public class UserService {
	@GET
	@Path("/role={usertype}/email={username}/password={password}")
	@Produces(MediaType.TEXT_HTML)
	public String checkUser(@PathParam("usertype") String usertype,@PathParam("username") String username,@PathParam("password") String password) {		
		Userinfo ui = new Userinfo();
		UserinfoDao uidao = new UserinfoDao();
		ui.setUsername(username);
		ui.setPassword(password);
		ui.setUsertype(usertype);
		Boolean flag = false;
		try {
			//flag = uidao.checkLogin(ui);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""+flag;
	}
}
