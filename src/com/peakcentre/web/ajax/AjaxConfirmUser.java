package com.peakcentre.web.ajax;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

/**
 * Servlet implementation class AjaxConfirmUser
 */
@WebServlet("/jsp/AjaxConfirmUser")
public class AjaxConfirmUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxConfirmUser() {
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
		UserinfoDao uidao = new UserinfoDao();
		ArrayList<Userinfo> list = new ArrayList<Userinfo>();
		Locale locale = (Locale) request.getSession(true)
				.getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);

		// If there are two users have the same first name and last name, return
		// the user information list and the real user account they want to update.
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		int i = Integer.parseInt(request.getParameter("userlist"));

		list = uidao.getUserinfo(fname, lname);
		//request.setAttribute("list", list);
		//request.setAttribute("singlelist", list.get(i));
		
		String singlelistJson = new Gson().toJson(list.get(i)); 
		response.setContentType("application/json"); 
		response.setCharacterEncoding("utf-8"); 
		response.getWriter().write(singlelistJson);
		//rd = request.getRequestDispatcher("modifyUser.jsp");
		//rd.forward(request, response);
	}

}
