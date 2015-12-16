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
import com.peakcentre.web.dao.TestResultTemplateDao;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

/**
 * Servlet implementation class AjaxGetTestResultDate
 */
@WebServlet("/jsp/AjaxGetTestResultDate")
public class AjaxGetTestResultDate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxGetTestResultDate() {
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
		UserinfoDao uid = new UserinfoDao();
		TestResultDao trd = new TestResultDao();
		
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String templateName = request.getParameter("templateName");
		String userlist = request.getParameter("userlist");
		
		ArrayList<Userinfo> uil = uid.getUserinfo(fname, lname);
		String username = uil.get(Integer.parseInt(userlist)).getUsername();

		
		ArrayList<String> dates = trd.getDatesByUserNameAndTemplateName(username, templateName);
		
		String dateJson = new Gson().toJson(dates);
		String usernameJson = new Gson().toJson(username);
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8"); 
		String result = "[" + dateJson + "," + usernameJson+"]";
		response.getWriter().write(result);
		
	}

}
