package com.peakcentre.web.ajax;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.peakcentre.web.dao.TrainingPlanDao;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

/**
 * Servlet implementation class AjaxGetTrainingPlanDate
 */
@WebServlet("/jsp/AjaxGetTrainingPlanDate")
public class AjaxGetTrainingPlanDate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxGetTrainingPlanDate() {
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
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String userlist = request.getParameter("userlist");
		
		UserinfoDao ud = new UserinfoDao();
		ArrayList<Userinfo> l= ud.getUserinfo(fname, lname);
		String username = l.get(Integer.parseInt(userlist)).getUsername();
		
		TrainingPlanDao tpd = new TrainingPlanDao();
		List<String> dates = tpd.getTrainingPlanDate(username);
		String message = "";
		if(dates.size() == 0) {
			message = "There is no Training Plan!";
		}
		
		String datesJson = new Gson().toJson(dates);
		String usernameJson = new Gson().toJson(username);
		String messageJson = new Gson().toJson(message);
		String bothJson = "[" + usernameJson + "," + datesJson +","+messageJson+ "]";
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(bothJson);
	
	}

}
