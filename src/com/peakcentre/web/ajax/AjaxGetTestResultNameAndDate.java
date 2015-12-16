package com.peakcentre.web.ajax;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.peakcentre.web.dao.TestResultDao;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

/**
 * Servlet implementation class AjaxGetTestResultNameAndDate
 */
@WebServlet("/jsp/AjaxGetTestResultNameAndDate")
public class AjaxGetTestResultNameAndDate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxGetTestResultNameAndDate() {
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
		TestResultDao trdao = new TestResultDao();
		String username = request.getParameter("userlist");
		//Get all test result names of one user
		ArrayList<String> nameList = trdao.getTemplateNames(username);
		//Get all test result dates of one user
		ArrayList<String> dateList = trdao.getDates(username);

		
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		ArrayList<Userinfo> list = new ArrayList<Userinfo>();
		UserinfoDao uidao = new UserinfoDao();
		list = uidao.getUserinfo(fname, lname);

		
		String nameListJson = new Gson().toJson(nameList); 
		String dateListJson = new Gson().toJson(dateList);
		String listJson = new Gson().toJson(list);
		String usernameJson = new Gson().toJson(username);
		String fnameJson = new Gson().toJson(fname);
		String lnameJson = new Gson().toJson(lname);
		response.setContentType("application/json"); 
		response.setCharacterEncoding("utf-8"); 
		String bothJson = "["+nameListJson+","+dateListJson+","+listJson+","+usernameJson+","+fnameJson+","+lnameJson+"]"; //Put many objects in an array
		response.getWriter().write(bothJson);

	}

}
