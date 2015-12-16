<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="image/favicon.png">
<!---CSS Files-->
<link rel="stylesheet" type="text/css" href="css/master.css">
<link rel="stylesheet" type="text/css" href="css/login.css">
<!---jQuery Files-->
<script src="js/jquery-1.7.1.min.js"></script>
<script src="js/jquery.spinner.js"></script>
<script type="text/javascript" src="js/forms/jquery.validate.min.js"></script>
<!---Fonts-->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600'
	rel='stylesheet' type='text/css'>
  
<%
	Locale locale = Locale.ENGLISH;
	ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);
	request.getSession(true).setAttribute("locale", locale);
%>
<title>Login</title>
</head>
<body>
	<div class="wrapper">
		<div class="logo"></div>
		<div class="lg-body">
			<div class="inner">
				<div id="lg-head">
					<p>
						<span class="font-bold"><%=resb.getString("PLEASELOGIN")%></span>
					</p>
					<div class="separator"></div>
				</div>
				<div class="login">
					<form id="login_form" method="post" action="LoginServlet">
						<fieldset>
							<ul>
								<li id="usr-field"><input class="input required"
									name="username" type="text" size="26" minlength="1"
									placeholder=<%=resb.getString("USERNAME")%> required></li>
								<li id="psw-field"><input class="input required" 
									name="password" type="password" size="26" minlength="1"
									placeholder=<%=resb.getString("PASSWORD")%> required></li>
								<li class="radio"><input class="radio" type="radio"
									name="usertype" id="usertype1" value="Athlete" checked /> <label
									for="usertype1" class="radio-text">Athlete</label> <input
									class="radio" type="radio" name="usertype" id="usertype2"
									value="Coach" /> <label for="usertype2" class="radio-text">Coach</label>
									<input class="radio" type="radio" name="usertype"
									id="usertype3" value="Administrator" /> <label for="usertype3"
									class="radio-text">Administrator</label></li>


								<li><input class="submit" type="submit" value=" " /></li>
							</ul>
						</fieldset>
					</form>
					<%
						if (request.getAttribute("message") != null) {
					%>
					<p class="errorMessage"><%=request.getAttribute("message")%></p>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>