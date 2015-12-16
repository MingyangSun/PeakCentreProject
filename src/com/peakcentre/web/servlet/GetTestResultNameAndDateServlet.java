package com.peakcentre.web.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.peakcentre.web.dao.TestResultDao;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

/**
 * Servlet implementation class GetTestResultNameAndDateServlet
 */
@WebServlet("/jsp/GetTestResultNameAndDateServlet")
public class GetTestResultNameAndDateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetTestResultNameAndDateServlet() {
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
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;

		TestResultDao trdao = new TestResultDao();
		String username = request.getParameter("userlist");
		//Get all test result names of one user
		ArrayList<String> nameList = trdao.getTemplateNames(username);
		//Get all test result dates of one user
		ArrayList<String> dateList = trdao.getDates(username);
		request.setAttribute("nameList", nameList);
		request.setAttribute("dateList", dateList);
		
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		ArrayList<Userinfo> list = new ArrayList<Userinfo>();
		UserinfoDao uidao = new UserinfoDao();
		list = uidao.getUserinfo(fname, lname);
		request.setAttribute("list", list);
		
		request.setAttribute("username", username);
		request.setAttribute("fname", fname);
		request.setAttribute("lname", lname);
		
		rd = request.getRequestDispatcher("viewTestResult.jsp");
		rd.forward(request, response);

	}

}
