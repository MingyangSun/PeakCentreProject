<link rel="shortcut icon" href="../image/favicon.png">


<div class="header">
<!-- <a href="dashboard.jsp"> -->
	<img src="../image/logo.png" alt="Logo" height="50" /></a>
</div>

<div class="top-bar">
	<ul id="nav">
		<li id="user-panel"><img
			src="http://localhost:8080/PeakCentreProject/pic/<%=session.getAttribute("picpath")%>.jpg"
			id="usr-avatar" alt="" />
			<div id="usr-info">
				<p id="usr-name">
					Welcome back,
					<%=session.getAttribute("fname")%>.
				</p>
				<form method="post" action="LogoutServlet">
					<p>
						<a href="#" onclick="$(this).closest('form').submit()">Logout</a>
					</p>
				</form>
			</div></li>
		<li>
			<ul id="top-nav">
				<li class="nav-item"><a href="dashboard.jsp"><img id='mainPageHeader'
						src="../image/nav/dash.png" alt="" />
						<p>Main Page</p></a></li>

				<li class="nav-item"><a><img src="../image/nav/anlt.png" id='testResultHeader'
						alt="" />
						<p>Test Result</p></a>
					<ul class="sub-nav">
						<%
							String usertype = session.getAttribute("usertype").toString();
							if ("administrator".equals(usertype) || "coach".equals(usertype)) {
						%>
						<li><a href="addTestResult.jsp">Add</a></li>
						<li><a href="modifyTestResult.jsp">Modify</a></li>
						<li><a href="viewTestResult.jsp">View</a></li>
						<li><a href="compareTestResult.jsp">Compare</a></li>
						<%
							} else if ("athlete".equals(usertype)) {
						%>
						<li><a href="viewTestResultForAthlete.jsp">View</a></li>
						<li><a href="compareTestResultForAthlete.jsp">Compare</a></li>
						<%
							}
						%>
					</ul></li>
				<li class="nav-item"><a><img id='trainingPlanHeader'
						src="../image/nav/cal.png" alt="" />
						<p>Training Plan</p></a>
					<ul class="sub-nav">
						<%
							if ("administrator".equals(usertype) || "coach".equals(usertype)) {
						%>
						<li><a href="addTrainingPlan.jsp">Add</a></li>
						<li><a href="modifyTrainingPlan.jsp">Modify</a></li>
						<li><a href="viewTrainingPlan.jsp">View</a></li>
						<%
							} else if ("athlete".equals(usertype)) {
						%>
						<li><a href="viewTrainingPlan.jsp">View</a></li>
						<%
							}
						%>
					</ul></li>
				<li class="nav-item"><a><img src="../image/nav/tb.png" id='workoutHeader'
						alt="" />
						<p>Workout</p></a>
					<ul class="sub-nav">
						<%
							if ("administrator".equals(usertype) || "coach".equals(usertype)) {
						%>
						<li><a href="viewWorkout.jsp">View</a></li>
						<%
							} else if ("athlete".equals(usertype)) {
						%>
						<li><a href="addWorkout.jsp">Add</a></li>
						<li><a href="viewWorkout.jsp">View</a></li>
						<%
							}
						%>
					</ul></li>
				<li class="nav-item"><a><img src="../image/nav/dash.png" id='userAccountHeader'
						alt="" />
						<p>User Account</p></a>
					<ul class="sub-nav">
						<%
							if ("administrator".equals(usertype)) {
						%>
						<li><a href="createUser.jsp">Create</a></li>
						<li><a href="modifyUser.jsp">Modify</a></li>
						<li><a href="deleteUser.jsp">Delete</a></li>
						<%
							} else if ("coach".equals(usertype)) {
						%>
						<li><a href="createUser.jsp">Create</a></li>
						<li><a href="modifyUser.jsp">Modify</a></li>
						<li><a href="useraccountManageAthlete.jsp">Manage</a></li>
						<%
							} else if ("athlete".equals(usertype)) {
						%>
						<li><a href="modifyUserForAthlete.jsp">Modify</a></li>
						<%
							}
						%>
					</ul></li>
				<%
					if ("administrator".equals(usertype)) {
				%>
				<li class="nav-item"><a><img src="../image/nav/icn.png" id='templateHeader'
						alt="" />
						<p>TR Template</p></a>
					<ul class="sub-nav">
						<li><a href="createTestResultTemp.jsp">Create</a></li>
						<li><a href="deleteTestResultTemp.jsp">Delete</a></li>
					</ul></li>
				<%
					} else if ("coach".equals(usertype)) {
				%>
				<li class="nav-item"><a><img src="../image/nav/icn.png" id='templateHeader' 
						alt="" />
						<p>TR Template</p></a>
					<ul class="sub-nav">
						<li><a href="createTestResultTemp.jsp">Create</a></li>
					</ul></li>
				<%
					}
				%>
				<li class="nav-item" style="float:right;" onclick="printPage()"><a><img src="../image/print.png" alt="" /><p>Print</p></a></li>
			</ul>
		</li>
	</ul>
</div>

<script>
	function printPage() {
		window.print();
	}
	window.onload = function() {
		var currentLocation = window.location.toString();
		console.log(currentLocation);
		var ifMatch = currentLocation.indexOf("Workout") >= 0;
		if (currentLocation.indexOf("dashboard") >= 0) {
			document.getElementById("mainPageHeader").src = "../image/nav/dash-active.png";
			document.getElementById("testResultHeader").src = "../image/nav/anlt.png";
			document.getElementById("workoutHeader").src = "../image/nav/tb.png";
			document.getElementById("trainingPlanHeader").src = "../image/nav/cal.png";
			document.getElementById("userAccountHeader").src = "../image/nav/dash.png";
		}else if (currentLocation.indexOf("User") >= 0) {
			document.getElementById("mainPageHeader").src = "../image/nav/dash.png";
			document.getElementById("testResultHeader").src = "../image/nav/anlt.png";
			document.getElementById("workoutHeader").src = "../image/nav/tb.png";
			document.getElementById("trainingPlanHeader").src = "../image/nav/cal.png";
			document.getElementById("userAccountHeader").src = "../image/nav/dash-active.png";
		}else if (currentLocation.indexOf("TestResultTemp") >= 0) {
			document.getElementById("mainPageHeader").src = "../image/nav/dash.png";
			document.getElementById("testResultHeader").src = "../image/nav/anlt.png";
			document.getElementById("workoutHeader").src = "../image/nav/tb.png";
			document.getElementById("trainingPlanHeader").src = "../image/nav/cal.png";
			document.getElementById("userAccountHeader").src = "../image/nav/dash.png";
			document.getElementById("templateHeader").src = "../image/nav/icn-active.png";
		}else if (currentLocation.indexOf("TrainingPlan") >= 0) {
			document.getElementById("mainPageHeader").src = "../image/nav/dash.png";
			document.getElementById("testResultHeader").src = "../image/nav/anlt.png";
			document.getElementById("workoutHeader").src = "../image/nav/tb.png";
			document.getElementById("trainingPlanHeader").src = "../image/nav/cal-active.png";
			document.getElementById("userAccountHeader").src = "../image/nav/dash.png";
		}else if (currentLocation.indexOf("Workout") >= 0) {
			document.getElementById("mainPageHeader").src = "../image/nav/dash.png";
			document.getElementById("testResultHeader").src = "../image/nav/anlt.png";
			document.getElementById("workoutHeader").src = "../image/nav/tb-active.png";
			document.getElementById("trainingPlanHeader").src = "../image/nav/cal.png";
			document.getElementById("userAccountHeader").src = "../image/nav/dash.png";
		}else if (currentLocation.indexOf("TestResult") >= 0) {
			document.getElementById("mainPageHeader").src = "../image/nav/dash.png";
			document.getElementById("testResultHeader").src = "../image/nav/anlt-active.png";
			document.getElementById("workoutHeader").src = "../image/nav/tb.png";
			document.getElementById("trainingPlanHeader").src = "../image/nav/cal.png";
			document.getElementById("userAccountHeader").src = "../image/nav/dash.png";

		}

	}
</script>