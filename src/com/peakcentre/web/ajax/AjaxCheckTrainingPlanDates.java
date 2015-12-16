package com.peakcentre.web.ajax;

import java.io.IOException;
import java.util.Date;
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
 * Servlet implementation class AjaxCheckTrainingPlanDates
 */
@WebServlet("/jsp/AjaxCheckTrainingPlanDates")
public class AjaxCheckTrainingPlanDates extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxCheckTrainingPlanDates() {
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
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String userlist = request.getParameter("userlist");
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		
		UserinfoDao uid = new UserinfoDao();
		List<Userinfo> uil = uid.getUserinfo(fname, lname);
		String username = uil.get(Integer.parseInt(userlist)).getUsername();
		
		TrainingPlanDao tpd = new TrainingPlanDao();
		List<String> l = tpd.getTrainingPlanDate(username);
		
		//if overlap
		Date dstart = new Date(startDate);
		Date dend = new Date(endDate);
		
		System.out.println("start:" + startDate);
		System.out.println("end  :" + endDate);
		
		String message = "";
		
		boolean flag = true;
		
		if(dstart.compareTo(dend) > 0) {
			message = "Start Date can not be later than End Date!";
		} else {		
			for(String s : l) {
				String d1 = s.substring(0,10);
				String d2 = s.substring(13);
				System.out.println("d1: " + d1);
				System.out.println("d2: " + d2);
				
				Date D1 = new Date(d1);
				Date D2 = new Date(d2);
				
				if(D1.compareTo(dstart)*D2.compareTo(dstart) <= 0) {
					flag = false;
					message = "Training Plan exists! Please change the dates!";
					break;
				}
				if(D1.compareTo(dend)*D2.compareTo(dend) <= 0) {
					flag = false;
					message = "Training Plan exists! Please change the dates!";
					break;
				}
				if(dstart.compareTo(D1)*dend.compareTo(D2) <= 0) {
					flag = false;
					message = "Training Plan exists! Please change the dates!";
					break;
				}
			}
		}
		String messageJson = new Gson().toJson(message);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(messageJson);
	}


}
