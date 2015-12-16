package com.peakcentre.web.ajax;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.peakcentre.web.dao.TestResultTemplateDao;

/**
 * Servlet implementation class AjaxCheckTemplateName
 */
@WebServlet("/jsp/AjaxCheckTemplateName")
public class AjaxCheckTemplateName extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxCheckTemplateName() {
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
			String messageJson = new Gson().toJson(message);
			response.setContentType("application/json"); 
			response.setCharacterEncoding("utf-8"); 
			response.getWriter().write(messageJson);
			
		} else {
			//check if the template name already exists
			boolean f = tdao.checkTempName(templateName);
			//template name exists
			if (!f) {
				message = resb.getString("TEMPLATE_NAME_EXISTS");
				String messageJson = new Gson().toJson(message);
				response.setContentType("application/json"); 
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().write(messageJson);
				
			//template name not exist
			} else {
				message = "";
				request.getSession(true).setAttribute("templateName", templateName);
				String templateNameAlias = request.getParameter("templateNameAlias");
				request.getSession(true).setAttribute("templateNameAlias", templateNameAlias);
				String messageJson = new Gson().toJson(message);
				response.setContentType("application/json"); 
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().write(messageJson);
			}
		}
	}

}
