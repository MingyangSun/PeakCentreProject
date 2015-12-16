package com.peakcentre.web.servlet;

import java.io.File;
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
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.peakcentre.web.dao.TestResultDao;
import com.peakcentre.web.dao.TestResultTemplateDao;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

/**
 * Servlet implementation class GetTestResultServlet
 */
@WebServlet("/jsp/GetTestResultServletForAthlete")
public class GetTestResultServletForAthlete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetTestResultServletForAthlete() {
		super();
		// TODO Auto-generated constructor stub
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

	}

}
