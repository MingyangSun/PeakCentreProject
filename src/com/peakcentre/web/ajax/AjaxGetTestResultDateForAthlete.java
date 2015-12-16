package com.peakcentre.web.ajax;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.peakcentre.web.dao.TestResultDao;

/**
 * Servlet implementation class AjaxGetTestResultDateForAthlete
 */
@WebServlet("/jsp/AjaxGetTestResultDateForAthlete")
public class AjaxGetTestResultDateForAthlete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxGetTestResultDateForAthlete() {
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
		String templateName = request.getParameter("templateName");
		String username = request.getSession(true).getAttribute("username").toString();
		
		TestResultDao trd = new TestResultDao();
		
		ArrayList<String> dates = trd.getDatesByUserNameAndTemplateName(username, templateName);
		
		String dateJson = new Gson().toJson(dates);
		String usernameJson = new Gson().toJson(username);
		String templatenameJson = new Gson().toJson(templateName);
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8"); 
		String result = "[" + dateJson + "," + usernameJson+","+templatenameJson+"]";
		response.getWriter().write(result);
	}

}
