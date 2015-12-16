package com.peakcentre.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.peakcentre.web.dao.TestResultTemplateDao;

/**
 * Servlet implementation class DeleteTemplateServlet
 */
@WebServlet("/jsp/DeleteTemplateServlet")
public class DeleteTemplateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteTemplateServlet() {
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
		TestResultTemplateDao tdao = new TestResultTemplateDao();

		String templateName = request.getParameter("templateName");
		//delete data from table TestResultTemplate
		boolean f1 = tdao.deleteTemplate(templateName);
		//delete template tables
		boolean f2 = tdao.deleteTemplateTable(templateName);
		f2 = true;
		if (f1 && f2) {
			//return to main page.
			response.sendRedirect("dashboard.jsp");
		}
	}

}
