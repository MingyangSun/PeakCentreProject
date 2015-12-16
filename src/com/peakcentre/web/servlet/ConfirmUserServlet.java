package com.peakcentre.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

/**
 * Servlet implementation class ConfirmUserServlet
 */
@WebServlet("/jsp/ConfirmUserServlet")
public class ConfirmUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ConfirmUserServlet() {
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
		request.setAttribute("list", list);
		request.setAttribute("singlelist", list.get(i));
		rd = request.getRequestDispatcher("modifyUser.jsp");
		rd.forward(request, response);

	}

}
