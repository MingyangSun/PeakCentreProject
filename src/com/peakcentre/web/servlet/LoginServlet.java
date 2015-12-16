package com.peakcentre.web.servlet;

import java.io.File;
import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;
import com.peakcentre.web.function.*;
import com.peakcentre.web.config.GetFilePath;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getSession(false) != null && request.getSession(false).getAttribute("id") != null) {
			response.sendRedirect("dashboard.jsp");
		} else {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		String message;
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String usertype = request.getParameter("usertype");

		UserinfoDao uidao = new UserinfoDao();
		Userinfo ui = new Userinfo();
		//Get locale
		Locale locale = (Locale) request.getSession(true).getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);
		
		//Check if username, password or usertype is empty
		if (username.isEmpty() || password.isEmpty() || usertype.isEmpty()) {
			message = resb.getString("EMPTY_MESSAGE");
			request.setAttribute("message", message);
			rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
		//not empty
		} else {
			ui.setUsername(username);
			ui.setPassword(password);
			ui.setUsertype(usertype);
			String flag = "";
			//Boolean flag = false;
			try {
				
				flag = ""+uidao.checkLogin(ui);
				//flag = ModelApplier.checkLogin(ui);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if (flag.equals("false")) {
				message = resb.getString("WRONG_LOGIN_MESSAGE");
				request.setAttribute("message", message);
				rd = request.getRequestDispatcher("index.jsp");
				rd.forward(request, response);
			} else {
				// Retrieve current HTTPSession object.
				HttpSession session = request.getSession(true);

				String fname = uidao.getFirstName(ui);
				String id = uidao.getUserId(ui);
				String city = uidao.getCity(ui);

				System.out.println(username);
				System.out.println(id);
				System.out.println(city);
				System.out.println(usertype);
				if(usertype.equals("Athlete")) usertype="athlete";
				if(usertype.equals("Coach")) usertype="coach";
				if(usertype.equals("Administrator")) usertype="administrator";
				//save username, first name, id, usertype, city into session
				session.setAttribute("username", username);
				session.setAttribute("fname", fname);
				session.setAttribute("id", id);
				session.setAttribute("usertype", usertype);
				session.setAttribute("city", city);
				session.setAttribute("picpath", id);
				
				//set session time
				session.setMaxInactiveInterval(1000000);
				
				
				//redirect to main page if login successful
				response.sendRedirect("jsp/dashboard.jsp");
			}
		}

	}

}
