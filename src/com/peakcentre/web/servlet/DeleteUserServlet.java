package com.peakcentre.web.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.peakcentre.web.config.GetFilePath;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

/**
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet("/jsp/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteUserServlet() {
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
		UserinfoDao uidao = new UserinfoDao();
		Userinfo ui = new Userinfo();
		ArrayList<Userinfo> list = new ArrayList<Userinfo>();
		Locale locale = (Locale) request.getSession(true)
				.getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);

		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		int i = Integer.parseInt(request.getParameter("userlist"));

		list = uidao.getUserinfo(fname, lname);
		ui = list.get(i);
		
		//delete user from table userinfo
		boolean flag = uidao.deleteUser(ui.getId());
		System.out.println("From delete user servlet: userlistt=" + i);
		System.out.println("From delete user servlet: lname=" + lname);
		System.out.println("From delete user servlet: fname=" + fname);
		System.out.println("From delete user servlet: flag=" + flag);
		if (flag) {
			//delete user profile picture
			String toPicDirectory = GetFilePath.getBasePicturePath();
			String toFileName = String.valueOf(ui.getId()) + ".jpg";
			File deleteFile = new File(toPicDirectory+toFileName);
			if( deleteFile.exists()){
				deleteFile.delete() ;
			}
			//return to main page
			response.sendRedirect("dashboard.jsp");
		}

	}
}
