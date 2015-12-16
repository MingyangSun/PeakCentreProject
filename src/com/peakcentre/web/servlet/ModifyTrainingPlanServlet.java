package com.peakcentre.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.peakcentre.web.dao.TrainingPlanDao;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.TrainingPlan;
import com.peakcentre.web.entity.Userinfo;

/**
 * Servlet implementation class ModifyTrainingPlanServlet
 */
@WebServlet("/jsp/ModifyTrainingPlanServlet")
public class ModifyTrainingPlanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifyTrainingPlanServlet() {
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
		String username = request.getParameter("username");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String weekData = request.getParameter("weekData");
		String st1 = request.getParameter("st1");
		String st2 = request.getParameter("st2");
		String ft = request.getParameter("ft");
		
		System.out.println("Here");
		
		TrainingPlan tp = new TrainingPlan();
		tp.setData("weekData", weekData);
		tp.setData("st1", st1);
		tp.setData("st2", st2);
		tp.setData("ft", ft);
		tp.setStartdate(startdate);
		tp.setEnddate(enddate);
		tp.setUsername(username);
		
		TrainingPlanDao tpd = new TrainingPlanDao();
		tpd.updateTrainingPlan(tp);
		
		response.sendRedirect("dashboard.jsp");
	}

}
