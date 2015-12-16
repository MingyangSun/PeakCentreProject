<!doctype html>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - Dashboard</title>
<link rel="shortcut icon" href="../image/favicon.png">
<!---CSS Files-->
<link rel="stylesheet" href="../css/master.css">
<link rel="stylesheet" href="../css/tables.css">
<!---jQuery Files-->
<script src="../js/jquery-1.7.1.min.js"></script>
<script src="../js/jquery-ui-1.8.17.min.js"></script>
<script src="../js/styler.js"></script>
<script src="../js/jquery.tipTip.js"></script>
<script src="../js/colorpicker.js"></script>
<script src="../js/sticky.full.js"></script>
<script src="../js/global.js"></script>
<script src="../js/flot/jquery.flot.min.js"></script>
<script src="../js/flot/jquery.flot.resize.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<!---Fonts-->
<%
	HttpSession session2 = request.getSession(false); 
	if(session2.getAttribute("id")==null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
    }
%>
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Ubuntu:500'
	rel='stylesheet' type='text/css'>
<%
	Locale locale = Locale.ENGLISH;
	ResourceBundle resb = ResourceBundle
			.getBundle("peakcentre", locale);
	request.getSession(true).setAttribute("locale", locale);
%>
</head>
<body>

	<%@ include file="./header.jsp" %>
	<!--- CONTENT AREA -->

	<div class="content container_12">
		<div class="ad-notif-success grid_12 small-mg">
			<p>Main Page</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>Test Result</h2>
			</div>
			<div class="box-content">
				<ul class="circle">
					<%
						if ("administrator".equals(usertype) || "coach".equals(usertype)) {
					%>
					<li><a href="addTestResult.jsp"><u><p>
									<font color="#a1b900">Add Test Result</font>
								</p></u></a></li>
					<p>Choose a template and add a test result for a user.</p>
					
					<li><a href="modifyTestResult.jsp"><u><p>
									<font color="#a1b900">Modify Test Result</font>
								</p></u></a></li>
					<p>Modify the data of a test result for a user.</p>
					
					<li><a href="viewTestResult.jsp"><u><p>
									<font color="#a1b900">View Test Result</font>
								</p></u></a></li>
					<p>View a test result of a user.</p>
					
					<li><a href="compareTestResult.jsp"><u><p>
									<font color="#a1b900">Compare Test Result</font>
								</p></u></a></li>
					<p>Compare test results.</p>
					<%
						} else if ("athlete".equals(usertype)) {
					%>
					<li><a href="viewTestResultForAthlete.jsp"><u><p>
									<font color="#a1b900">View Test Result</font>
								</p></u></a></li>
					<p>View your own test result.</p>
					<br>
					<li><a href="compareTestResultForAthlete.jsp"><u><p>
									<font color="#a1b900">Compare Test Result</font>
								</p></u></a></li>
					<p>Compare your test results.</p>
					<br>

					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>Training Plan</h2>
			</div>
			<div class="box-content">
				<ul class="circle">
					<%
						if ("administrator".equals(usertype) || "coach".equals(usertype)) {
					%>
					<li><a href="addTrainingPlan.jsp"><u><p>
									<font color="#a1b900">Add Training Plan</font>
								</p></u></a></li>
					<p>Add a training plan for a user.</p>
					<br>
					<li><a href="modifyTrainingPlan.jsp"><u><p>
									<font color="#a1b900">Modify Training Plan</font>
								</p></u></a></li>
					<p>Modify the training plan for a user.</p>
					<br>
					<li><a href="viewTrainingPlan.jsp"><u><p>
									<font color="#a1b900">View Training Plan</font>
								</p></u></a></li>
					<p>View a training plan of a user.</p>
					<%
						} else if ("athlete".equals(usertype)) {
					%>
					<br>
					<li><a href="viewTrainingPlan.jsp"><u><p>
									<font color="#a1b900">View Training Plan</font>
								</p></u></a></li>
					<p>View your own training plan.</p>
					<br>
					<br>
					<br>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>Workout Summary</h2>
			</div>
			<div class="box-content">
				<ul class="circle">
					<%
						if ("administrator".equals(usertype) || "coach".equals(usertype)) {
					%>
					<li><a href="viewWorkout.jsp"><u><p>
									<font color="#a1b900">View Workout Summary</font>
								</p></u></a></li>
					<p>View the workout summary of a user.</p>
					<br>
					<br>
					<br>
					<br><br><br><br>
					<%
						} else if ("athlete".equals(usertype)) {
					%>
					<li><a href="addWorkout.jsp"><u><p>
									<font color="#a1b900">Add Workout Summary</font>
								</p></u></a></li>
					<p>Add your workout summary.</p>
					<br>
					<li><a href="viewTrainingPlan.jsp"><u><p>
									<font color="#a1b900">View Workout Summary</font>
								</p></u></a></li>
					<p>View your own workout summary.</p>
					<br>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>User Account</h2>
			</div>
			<div class="box-content">
				<ul class="circle">
					<%
						if ("administrator".equals(usertype)) {
					%>
					<li><a href="createUser.jsp"><u><p>
									<font color="#a1b900">Create User</font>
								</p></u></a></li>
					<p>Create a new user account.</p>
					<br>
					<li><a href="modifyUser.jsp"><u><p>
									<font color="#a1b900">Modify User</font>
								</p></u></a></li>
					<p>Modify an existing user account.</p>
					<br>
					<li><a href="deleteUser.jsp"><u><p>
									<font color="#a1b900">Delete User</font>
								</p></u></a></li>
					<p>Delete a user account.</p>
					<%
						} else if ("coach".equals(usertype)) {
					%>
					<li><a href="createUser.jsp"><u><p>
									<font color="#a1b900">Create User</font>
								</p></u></a></li>
					<p>Create a new user account.</p>
					<br>
					<li><a href="modifyUser.jsp"><u><p>
									<font color="#a1b900">Modify User</font>
								</p></u></a></li>
					<p>Modify an existing user account.</p>
										<br>
					<li><a href="useraccountManageAthlete.jsp"><u><p>
									<font color="#a1b900">Manage Athletes</font>
								</p></u></a></li>
					<p>Manage my athletes.</p>
					<%
						} else if ("athlete".equals(usertype)) {
					%>
					<li><a href="modifyUserForAthlete.jsp"><u><p>
									<font color="#a1b900">Update</font>
								</p></u></a></li>
					<p>Modify an existing user account.</p>
					<br>
					<br>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<%
			if ("administrator".equals(usertype)) {
		%>
		<div class="box grid_4">
			<div class="box-head">
				<h2>Test Result Template</h2>
			</div>
			<div class="box-content">
				<ul class="circle">

					<li><a href="createTestResultTemp.jsp"><u><p>
									<font color="#a1b900">Create Template</font>
								</p></u></a></li>
					<p>Create a new test result template.</p>
					<br>
					<li><a href="deleteTestResultTemp.jsp"><u><p>
									<font color="#a1b900">Delete Template</font>
								</p></u></a></li>
					<p>Delete a test result template.</p>
				</ul>
			</div>
		</div>
		<%
			} else if ("coach".equals(usertype)) {
		%>
		<div class="box grid_4">
			<div class="box-head">
				<h2>Test Result Template</h2>
			</div>
			<div class="box-content">
				<ul class="circle">
					<li><a href="createTestResultTemp.jsp"><u><p>
									<font color="#a1b900">Create Template</font>
								</p></u></a></li>
					<p>Create a new test result template.</p>

				</ul>
			</div>
		</div>
		<%
			}
		%>
	</div>

	<div class="footer">
		<p>© Peak Centre. All rights reserved.</p>
	</div>

	<script>
		function printPage() {
			window.print();
		}
	</script>
</body>
</html>