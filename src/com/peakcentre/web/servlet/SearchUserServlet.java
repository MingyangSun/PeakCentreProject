package com.peakcentre.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;

/**
 * Servlet implementation class SearchUserServlet
 */
@WebServlet("/jsp/SearchUserServlet")
public class SearchUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchUserServlet() {
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
		HttpSession session = request.getSession(true);

		RequestDispatcher rd = null;
		UserinfoDao uidao = new UserinfoDao();
		ArrayList<Userinfo> list = new ArrayList<Userinfo>();
		Locale locale = (Locale) request.getSession(true)
				.getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);

		String message;

		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		//get which page this request from
		String page = request.getParameter("page");
		String usertype = session.getAttribute("usertype").toString();
		String city = session.getAttribute("city").toString();

		//User first name and last name to search if user exist
		if (fname.isEmpty() || lname.isEmpty()) {
			message = resb.getString("FIRST_NAME_OR_LAST_NAME_EMPTY");
			request.setAttribute("message", message);
			//return back to different page
			if (page.equals("modify")) {
				rd = request.getRequestDispatcher("modifyUser.jsp");
			} else if (page.equals("delete")) {
				rd = request.getRequestDispatcher("deleteUser.jsp");
			} else if (page.equals("addTestResult")) {
				rd = request.getRequestDispatcher("addTestResult.jsp");
			} else if (page.equals("viewTestResult")) {
				rd = request.getRequestDispatcher("viewTestResult.jsp");
			} else if (page.equals("addTrainingPlan")) {
				rd = request.getRequestDispatcher("addTrainingPlan.jsp");
			}
			rd.forward(request, response);
		} else {
			boolean flag;
			//If coach, check if user exists from the same city
			if (usertype.equals("coach")) {
				flag = uidao.checkUserExistsWithUsertype(fname, lname,
						city);
			} else {
				flag = uidao.checkUserExists(fname, lname);
			}
			if (!flag) {
				message = resb.getString("USER_NAME_NOT_EXISTS");
				request.setAttribute("message", message);
				//return to different page
				if (page.equals("modify")) {
					rd = request.getRequestDispatcher("modifyUser.jsp");
				} else if (page.equals("delete")) {
					rd = request.getRequestDispatcher("deleteUser.jsp");
				} else if (page.equals("addTestResult")) {
					rd = request.getRequestDispatcher("addTestResult.jsp");
				} else if (page.equals("viewTestResult")) {
					rd = request.getRequestDispatcher("viewTestResult.jsp");

				} else if (page.equals("addTrainingPlan")) {
					rd = request.getRequestDispatcher("addTrainingPlan.jsp");

				}
				rd.forward(request, response);

			} else {
				//get user information from db by first name and last name
				//result might be one or more
				list = uidao.getUserinfo(fname, lname);
				request.setAttribute("list", list);
				//return back to different page
				if (page.equals("modify")) {
					rd = request.getRequestDispatcher("modifyUser.jsp");
				} else if (page.equals("delete")) {
					rd = request.getRequestDispatcher("deleteUser.jsp");
				} else if (page.equals("addTestResult")) {
					rd = request.getRequestDispatcher("addTestResult.jsp");
				} else if (page.equals("viewTestResult")) {
					rd = request.getRequestDispatcher("viewTestResult.jsp");
				} else if (page.equals("addTrainingPlan")) {
					rd = request.getRequestDispatcher("addTrainingPlan.jsp");
				}
				rd.forward(request, response);

			}

		}

	}
}
