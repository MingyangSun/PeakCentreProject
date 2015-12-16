package com.peakcentre.web.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.Userinfo;
import com.peakcentre.web.config.GetFilePath;

/**
 * Servlet implementation class CreateUserServlet
 */
@WebServlet("/jsp/CreateUserServlet")
public class CreateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateUserServlet() {
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
		Userinfo ui = new Userinfo();
		Locale locale = (Locale) request.getSession(true)
				.getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);

		String usrname_message;
		String password_message;
		String empty_message;

		String usertype = null;
		String username = null;
		String password = null;
		String repassword = null;
		String fname = null;
		String lname = null;
		String gender = null;
		String level = null;
		String dob = null;
		String city = null;

		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
			items = upload.parseRequest(new ServletRequestContext(request));
		} catch (org.apache.tomcat.util.http.fileupload.FileUploadException e) {
			e.printStackTrace();
		}
		Iterator iter = items.iterator();
		while (iter.hasNext()) {
			FileItem item = (FileItem) iter.next();
			// If it is a form field
			if (item.isFormField()) { 
				//get field name
				String name = item.getFieldName(); 
				//get field value
				String value = item.getString();
				if (item.getFieldName().equals("usertype")) {
					usertype = value;
				}
				if (item.getFieldName().equals("username")) {
					username = value;
				}
				if (item.getFieldName().equals("password")) {
					password = value;
				}
				if (item.getFieldName().equals("repassword")) {
					repassword = value;
				}
				if (item.getFieldName().equals("fname")) {
					fname = value;
				}
				if (item.getFieldName().equals("lname")) {
					lname = value;
				}
				if (item.getFieldName().equals("gender")) {
					gender = value;
				}
				if (item.getFieldName().equals("level")) {
					level = value;
				}
				if (item.getFieldName().equals("dob")) {
					dob = value;
				}
				if (item.getFieldName().equals("city")) {
					city = value;
				}
			}
		}

		// Validate empty field
		if ((username != null && username.isEmpty())
				|| (password != null && password.isEmpty())
				|| (repassword != null && repassword.isEmpty())
				|| (fname != null && fname.isEmpty())
				|| (lname != null && lname.isEmpty())
				|| (dob != null && dob.isEmpty())
				|| (city != null && city.isEmpty())) {
			empty_message = resb.getString("EMPTY_MESSAGE_CREATE_USER");
			request.setAttribute("empty_message", empty_message);
			rd = request.getRequestDispatcher("createUser.jsp");
			rd.forward(request, response);
		} else {
			// Validate whether username already exists
			Boolean flag = uidao.checkUsername(username);
			if (!flag) {
				usrname_message = resb.getString("USERNAME_EXISTS");
				request.setAttribute("usrname_message", usrname_message);
				rd = request.getRequestDispatcher("createUser.jsp");
				rd.forward(request, response);
			} else {
				// Validate password match
				if (!password.equals(repassword)) {
					password_message = resb.getString("PASSWORD_NOT_MATCH");
					request.setAttribute("password_message", password_message);
					rd = request.getRequestDispatcher("createUser.jsp");
					rd.forward(request, response);
				} else {
					// Insert into db
					ui.setUsertype(usertype);
					ui.setUsername(username);
					ui.setPassword(password);
					ui.setFname(fname);
					ui.setLname(lname);
					//String nextId = ((username+password).hashCode() +"").substring(0,5);
					String nextId = uidao.NextId();
					ui.setPicpath(nextId +"");
					ui.setGender(gender);
					ui.setLevel(level);
					ui.setDob(dob);
					ui.setCity(city);

					boolean f = uidao.insertUser(ui);
					if (f) {
						//Save profile picture to local disk
						String toPicDirectory = GetFilePath.getBasePicturePath();
						String toFileName = nextId + ".jpg";

						DiskFileItemFactory factory1 = new DiskFileItemFactory();
						ServletFileUpload upload1 = new ServletFileUpload(
								factory1);
						List items1 = null;
						try {
							items1 = upload
									.parseRequest(new ServletRequestContext(
											request));
						} catch (org.apache.tomcat.util.http.fileupload.FileUploadException e) {
							e.printStackTrace();
						}
						Iterator iter1 = items.iterator();
						while (iter1.hasNext()) {
							FileItem item = (FileItem) iter1.next();
							if (!item.isFormField()) {
								File saveFile = new File(toPicDirectory
										+ toFileName);
								try {
									item.write(saveFile);
								} catch (Exception e) {
									e.printStackTrace();
								}
							}
						}
						//return to main page
						response.sendRedirect("dashboard.jsp");
					}
				}
			}
		}

	}
}
