package com.peakcentre.web.ajax;

import java.io.IOException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.peakcentre.web.dao.TestResultDao;
import com.peakcentre.web.entity.TestResult;

/**
 * Servlet implementation class TestResultModifyJson
 */
@WebServlet("/jsp/TestResultModifyJson")
public class TestResultModifyJson extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestResultModifyJson() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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

		//ModelApplier.insertTestResultTable(tr);
		trd.updateTestResult(tr);;

		response.sendRedirect("dashboard.jsp");
	}

}
