package com.peakcentre.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.*;

import com.peakcentre.web.dao.TestResultDao;
import com.peakcentre.web.entity.TestResult;
import com.google.gson.*;

/**
 * Servlet implementation class SaveTestResultServlet
 */
@WebServlet("/jsp/SaveTestResultServlet")
public class SaveTestResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SaveTestResultServlet() {
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
		// TODO Auto-generated method stub
		//TestResult tr = new TestResult();
		TestResult tr = new TestResult();
		TestResultDao trd = new TestResultDao();
		
		String username = request.getParameter("username");
		String tempId = request.getParameter("tempId");
		String templateName = request.getParameter("templateName");
		String date = request.getParameter("date");
		String data = request.getParameter("data");
		
		tr.setUsername(username);
		tr.setTempId(Integer.parseInt(tempId));
		tr.setDate(date);
		
		JSONObject dataJson;
		try {
			dataJson = new JSONObject(data);
			// this parses the json
			Iterator it = dataJson.keys(); //gets all the keys

			while(it.hasNext())
			{
				String key = (String)it.next();
				String value = (String)dataJson.get(key);
				System.out.println(key+"<------->"+value);
				tr.setData(key,value);
			}
			
			
		} catch (JSONException e) {
			e.printStackTrace();
		}

		trd.insertTestResult(tr);

		response.sendRedirect("dashboard.jsp");
	}
}
