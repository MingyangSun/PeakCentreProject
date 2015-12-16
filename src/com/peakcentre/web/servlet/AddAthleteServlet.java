package com.peakcentre.web.servlet;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.peakcentre.web.dao.CoachAthletesDao;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

/**
 * Servlet implementation class AddAthleteServlet
 */
@WebServlet("/jsp/AddAthleteServlet")
public class AddAthleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddAthleteServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getSession(false) != null && request.getSession(false).getAttribute("id") != null) {
			response.sendRedirect("dashboard.jsp");
		} else {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserinfoDao uidao = new UserinfoDao();
		Userinfo ui = new Userinfo();
		ArrayList<Userinfo> list = new ArrayList<Userinfo>();
		Locale locale = (Locale) request.getSession(true).getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);

		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		int i = Integer.parseInt(request.getParameter("userlist"));

		list = uidao.getUserinfoByFnameAndLname(fname, lname);
		ui = list.get(i);

		// add athlete to my list
		CoachAthletesDao caDao = new CoachAthletesDao();
		caDao.insertAthlete(ui.getUsername(), request.getSession().getAttribute("username").toString());
		response.sendRedirect("dashboard.jsp");
	}

}
