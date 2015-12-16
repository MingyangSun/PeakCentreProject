package com.peakcentre.web.servlet;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
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
import com.peakcentre.web.dao.TestResultTemplateDao;
import com.peakcentre.web.entity.TestResultTemplate;

/**
 * Servlet implementation class SaveTemplateServlet
 */
@WebServlet("/jsp/SaveTemplateServlet")
public class SaveTemplateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SaveTemplateServlet() {
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
		TestResultTemplate trt = new TestResultTemplate();
		TestResultTemplateDao tdao = new TestResultTemplateDao();

		Locale locale = (Locale) request.getSession(true)
				.getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);

		boolean flag;

		// Insert into template table in database
		String templateName = request.getSession(true)
				.getAttribute("templateName").toString();
		String templateNameAlias = request.getSession(true)
				.getAttribute("templateNameAlias").toString();
		String temppath = templateNameAlias + ".xml";
		trt.setName(templateName);
		trt.setTemppath(temppath);
		boolean f1 = tdao.insertTemplate(trt);

		boolean f2 = true;

		// Create table in database
		int tableNumber = 0;
		int divNumber = 0;

		if (request.getParameter("tableNumber").isEmpty()) {

		} else {
			divNumber = Integer.parseInt(request.getParameter("divNumber"));

			// Create table in database
			ArrayList<ArrayList<String>> columns = new ArrayList<ArrayList<String>>();
			for (int i = 0; i < divNumber; i++) {
				ArrayList<String> s1 = new ArrayList<String>();
				if (request.getParameter("table" + Integer.toString(i + 1)
						+ "th1") != null
						&& !((request.getParameter("table"
								+ Integer.toString(i + 1) + "th1")).isEmpty())) {
					tableNumber++;

				}
				for (int j = 0; j < 21; j++) {
					if (request.getParameter("table" + Integer.toString(i + 1)
							+ "th" + Integer.toString(j + 1)) != null
							&& !((request.getParameter("table"
									+ Integer.toString(i + 1) + "th"
									+ Integer.toString(j + 1))).isEmpty())) {
						String str = request.getParameter("table"
								+ Integer.toString(i + 1) + "th"
								+ Integer.toString(j + 1));

						s1.add(str);
					}

				}
				if (request.getParameter("table" + Integer.toString(i + 1)
						+ "th1") != null
						&& !((request.getParameter("table"
								+ Integer.toString(i + 1) + "th1")).isEmpty())) {
					columns.add(s1);

				}

			}

			f2 = tdao.createTemplateTable(templateName, tableNumber, columns);
			f2 = true;

		}

		// create template xml file in local disk
		File f = new File(GetFilePath.getBaseTemplatePath() + temppath);
		BufferedWriter bw = new BufferedWriter(new FileWriter(f));
		String xml = "<root>";

		int textNo = 1;
		int tableNo = 1;
		int GraphNo = 1;
		int dt = Integer.parseInt(request.getParameter("divNumber"));

		for (int i = 0; i < dt; i++) {
			String str = request.getParameter(Integer.toString(i + 1));
			if (str != null && (!str.isEmpty())) {
				// save text element
				if ("text".equals(str)) {
					xml += "<textarea>";
					xml += request.getParameter("text" + (i + 1));
					xml += "</textarea>";
					textNo++;
				// save table element
				} else if ("table".equals(str)) {
					int row = Integer.parseInt(request.getParameter("table"
							+ (i + 1) + "row"));
					int column = Integer.parseInt(request.getParameter("table"
							+ (i + 1) + "column"));
					int numberInTotal = Integer.parseInt(request
							.getParameter("table" + (i + 1) + "number"));
					String tableName = request.getParameter("tableName"
							+ (i + 1));
					xml += "<table>";
					xml += "<tableName>" + tableName + "</tableName>";
					xml += "<row>" + row + "</row>";
					xml += "<column>" + column + "</column>";
					xml += "<numberInTotal>" + numberInTotal
							+ "</numberInTotal>";

					for (int t = 0; t < 21; t++) {
						if (request.getParameter("table"
								+ Integer.toString(i + 1) + "th"
								+ Integer.toString(t + 1)) != null
								&& !((request.getParameter("table"
										+ Integer.toString(i + 1) + "th"
										+ Integer.toString(t + 1))).isEmpty())) {
							xml += "<th>"
									+ request.getParameter("table"
											+ Integer.toString(i + 1) + "th"
											+ Integer.toString(t + 1))
									+ "</th>";

						}
					}
					xml += "</table>";
					tableNo++;
				// save graph element
				} else if ("graph".equals(str)) {
					String col1 = request.getParameter("graph" + (i + 1)
							+ "column1");
					String col2 = request.getParameter("graph" + (i + 1)
							+ "column2");
					String tNumber = request.getParameter("graphTable"
							+ (i + 1));
					String graphName = request.getParameter("graphName"
							+ (i + 1));

					xml += "<img>";
					xml += "<graphName>" + graphName + "</graphName>";
					xml += "<tableNumber>" + tNumber + "</tableNumber>";
					xml += "<col1>" + col1 + "</col1>";
					xml += "<col2>" + col2 + "</col2>";
					xml += "</img>";
					GraphNo++;
				}

			}

		}

		xml += "</root>";
		bw.write(xml);
		bw.close();

		if (f1 && f2) {
			//if successful, go back to main page
			response.sendRedirect("dashboard.jsp");

		}

	}
}
