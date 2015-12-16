package com.peakcentre.web.ajax;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.peakcentre.web.dao.CoachAthletesDao;
import com.peakcentre.web.entity.Userinfo;

@WebServlet("/jsp/AjaxDeleteMyAthlete")
public class AjaxDeleteMyAthlete extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxDeleteMyAthlete() {
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
		final String athUsername = request.getParameter("athUsername");
		final String pageIndex = request.getParameter("pageindex");
		CoachAthletesDao caDao = new CoachAthletesDao();
		if (athUsername != null && !athUsername.isEmpty()) {
			caDao.deleteRelationship(athUsername, request.getSession().getAttribute("username").toString());
		}
		
		ArrayList<Userinfo> newAthList = caDao.getAllathByPage(request.getSession().getAttribute("username").toString() , 3, Integer.parseInt(pageIndex));
		System.out.println(newAthList.toArray().toString() + "size is " + newAthList.size());
		String message = "";
		String messageJson = new Gson().toJson(message); 
		String listJson = new Gson().toJson(newAthList); 
		response.setContentType("application/json"); 
		response.setCharacterEncoding("utf-8"); 
		String bothJson = "["+messageJson+","+listJson+"]";
		response.getWriter().write(bothJson);
	}

}
