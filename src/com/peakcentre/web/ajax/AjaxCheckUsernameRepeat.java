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
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

@WebServlet("/jsp/AjaxCheckUsernameRepeat")
public class AjaxCheckUsernameRepeat extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxCheckUsernameRepeat() {
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
		String usertype = request.getParameter("usertype");
		
		ArrayList<Userinfo> list = new ArrayList<Userinfo>();
		UserinfoDao uidao = new UserinfoDao();
 
		System.out.println("here");
		
		boolean temp_repeat = uidao.checkExistByUsername(username);
		
		String repeat = new Gson().toJson(temp_repeat); 
		
		response.setContentType("application/json"); 
		response.setCharacterEncoding("utf-8");
		
		System.out.println("repeat: "+repeat);
		
		response.getWriter().write(repeat);

	}


}
