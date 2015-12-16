package com.peakcentre.web.function;

import java.net.URI;
import java.util.*;

import javax.ws.rs.client.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;

import org.glassfish.jersey.client.ClientConfig;

import com.google.gson.Gson;

import com.peakcentre.web.entity.*;

public class ModelApplier {
	private static ClientConfig config = new ClientConfig();
	
	private static URI getBaseUri() {
		String uri = "http://localhost:8080/PeakCentreProject/rest";
		return UriBuilder.fromUri(uri).build();
	}
	
	public static String checkLogin(Userinfo ui) {
		Client client = ClientBuilder.newClient(config);
		WebTarget target = client.target(getBaseUri());
		return target.path("users").path("role=" + ui.getUsertype()).path("email="+ui.getUsername()).path("password="+ui.getPassword()).request().accept(MediaType.TEXT_HTML).get(String.class);
	}
}
