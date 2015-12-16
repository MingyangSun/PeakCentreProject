package com.peakcentre.web.servlet;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.peakcentre.web.dao.TestResultTemplateDao;

/**
 * Servlet implementation class CheckTemplateNameServlet
 */
@WebServlet("/jsp/CheckTemplateNameServlet")
public class CheckTemplateNameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CheckTemplateNameServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = null;
		TestResultTemplateDao tdao = new TestResultTemplateDao();

		Locale locale = (Locale) request.getSession(true)
				.getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);

		String message;
		boolean flag;

		String templateName = request.getParameter("templateName");

		//check if the template name is empty
		if (templateName.isEmpty()) {
			message = resb.getString("TEMPLATE_NAME_EMPTY");
			request.setAttribute("message", message);
			rd = request.getRequestDispatcher("createTestResultTemp.jsp");
			rd.forward(request, response);
		} else {
			//check if the template name already exists
			boolean f = tdao.checkTempName(templateName);
			//template name exists
			if (!f) {
				message = resb.getString("TEMPLATE_NAME_EXISTS");
				request.setAttribute("message", message);
				rd = request.getRequestDispatcher("createTestResultTemp.jsp");
				rd.forward(request, response);	
			//template name not exist
			} else {
				flag = true;
				request.setAttribute("flag", flag);
				request.setAttribute("templateName", templateName);
				request.getSession(true).setAttribute("templateName", templateName);
				rd = request.getRequestDispatcher("createTestResultTemp.jsp");
				rd.forward(request, response);
			}
		}

	}

}
