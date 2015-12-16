package com.peakcentre.web.ajax;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
/**
 * Servlet implementation class AjaxSearchUser
 */
@WebServlet("/jsp/AjaxSearchUser")
public class AjaxSearchUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxSearchUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getSession(false) != null && request.getSession(false).getAttribute("id") != null) {
			response.sendRedirect("dashboard.jsp");
		} else {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		
		UserinfoDao uidao = new UserinfoDao();
		ArrayList<Userinfo> list = new ArrayList<Userinfo>();
		Locale locale = (Locale) request.getSession(true)
				.getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);

		String message;

		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		//get which page this request from
		//String page = request.getParameter("page");
		String usertype = session.getAttribute("usertype").toString();
		String city = session.getAttribute("city").toString();
		
		//User first name and last name to search if user exist
		if (fname.isEmpty() || lname.isEmpty()) {
			message = resb.getString("FIRST_NAME_OR_LAST_NAME_EMPTY");
			String messageJson = new Gson().toJson(message); 
			String listJson = new Gson().toJson(list); 
			response.setContentType("application/json"); 
			response.setCharacterEncoding("utf-8"); 
			String bothJson = "["+messageJson+","+listJson+"]"; //Put both objects in an array of 2 elements
			response.getWriter().write(bothJson);
		} else {
			boolean flag;
			//If coach, check if user exists from the same city
			if (usertype.equals("coach")) {
				flag = uidao.checkUserExistsWithUsertype(fname, lname,
						city);
			} else {
				flag = uidao.checkUserExists(fname, lname);
			}
			if (!flag) {
				//if username does not exist
				message = resb.getString("USER_NAME_NOT_EXISTS");
				String messageJson = new Gson().toJson(message); 
				String listJson = new Gson().toJson(list); 
				response.setContentType("application/json"); 
				response.setCharacterEncoding("utf-8"); 
				String bothJson = "["+messageJson+","+listJson+"]"; //Put both objects in an array of 2 elements
				response.getWriter().write(bothJson);

			} else {
				//get user information from db by first name and last name
				//result might be one or more
				message = "";
				list = uidao.getUserinfo(fname, lname);
				for(Userinfo t : list) {
					t.setId(0);
				}
				String messageJson = new Gson().toJson(message); 
				String listJson = new Gson().toJson(list); 
				response.setContentType("application/json"); 
				response.setCharacterEncoding("utf-8"); 
				String bothJson = "["+messageJson+","+listJson+"]"; //Put both objects in an array of 2 elements
				response.getWriter().write(bothJson);
			}

		}

	}

}
