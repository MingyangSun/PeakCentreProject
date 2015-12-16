<!doctype html>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.peakcentre.web.entity.Userinfo"%>
<%@ page import="com.peakcentre.web.dao.TestResultDao"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - View Test Result</title>
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
			<p>View Test Result</p>
		</div>

		<div class="box grid_4">
			<div class="box-head">
				<h2>Choose Test Name and Date</h2>
			</div>
			<form method="post" action="">
				<%
					//get test result names and dates of the user from database
					String username = session.getAttribute("username").toString();			
					TestResultDao trdao = new TestResultDao();
					ArrayList<String> nameList = trdao.getTemplateNames(username);
					ArrayList<String> dateList = trdao.getDates(username);
				%>
				<input type="hidden" value=<%=username%> name="username" />
				<div class="box-content">
					<div class="form-row">
						<p><%=resb.getString("PLEASE_CHOOSE_TEMP_AND_DATE")%></p>
					</div>
					<br>
					<%
						if(nameList.size()==0||nameList==null){
					%>
					<br>
					<p style="color: #ff6666; font-size: 11px">You do not have any
						test results.</p>
					<br>
					<%
						}
					%>
					<br>
					<div class="form-row">
						<label class="form-label">Test Name</label>
						<div class="form-item">

							<select name="tempName">
								<%
									for (String s : nameList) {
								%>
								<option value=<%=s%>><p><%=s%></p>
								</option>
								<%
									}
								%>
							</select>

						</div>
					</div>
					<div class="form-row">
						<label class="form-label">Date</label>
						<div class="form-item">

							<select name="date">
								<%
									for (String s : dateList) {
								%>
								<option value=<%=s%>><p><%=s%></p>
								</option>
								<%
									}
								%>
							</select>
						</div>

					</div>
					<div class="form-row">
						<div class="form-item" id="errmessageGetTestResult">
							<%
								if (request.getAttribute("messageGetTestResult") != null) {
							%>
							<p style="color: #ff6666; font-size: 11px"><%=request.getAttribute("messageGetTestResult")%></p>
							<%
								}
							%>
						</div>
					</div>
					<div class="form-row" style="text-align: right;">
						<%
							if(nameList.size()==0||nameList==null){
						%>
						<input type="submit" class="button green" value="show" disabled>
						<%
							}else{
						%>
						<input type="button" id="getTestResult" class="button green" value="show">
						<%
							}
						%>
					</div>
				</div>
			</form>

		</div>
	</div>
	<%
		if(request.getAttribute("html")!=null){
	%>
	<div class="content container_12">
		<div class="box grid_12">
			<%
				}else{
			%>
				<div class="content container_12">
			<div class="box grid_12" style="display: none">
				<%
					}
				%>
				<div class="box-head">
					<h2>Test Result</h2>
				</div>

				<div class="box-content" id="field">

					<div id="divtext1">
						<%=request.getAttribute("html")%>

					</div>
				</div>

			</div>
		</div>
	</div>

	<div class="footer">
		<p>© Peak Centre. All rights reserved.</p>
	</div>
	<script>
		function printPage() {
			window.print();
		}
	</script>
	<script type="text/javascript"
		src="https://www.google.com/jsapi?autoload={
            'modules':[{
              'name':'visualization',
              'version':'1',
              'packages':['corechart']
            }]
          }"></script>
	<script>
		$("#getTestResult").click(function(){
			$("#errmessageGetTestResult").html("");
			$("#divtext1").html("");
			var post = {
					date: $("select[name=date]").val(),
					tempName: $("select[name=tempName]").val(),
					username: $("input[name=username]").val()
			};
			$.post('TestResultGetJson',post,function(data){
				var message = data[0];
				var html = data[1];
				if(message == "") {
					$("#divtext1").html(html);
					console.log("Html:" + html);
					$(".box.grid_12").css({display:'block'});
					for (var i = 0; i < 10; i++) {
						if (document.getElementById("tn" + i)) {
							generateGraph(document.getElementById("tn"+i).value, $("#tn"+i).parent().find("input[name=X]").val(),$("#tn"+i).parent().find("input[name=Y]").val());
						}
					}
				} else {
					$("#errmessageGetTestResult").html('<p style="color: #ff6666; font-size: 11px">'+message+'</p>');	
				}
			});
		});
		//load graph
		window.onload = function() {
			for (var i = 0; i < 10; i++) {
				if (document.getElementById("tn" + i)) {
					generateGraph(document.getElementById("tn" + i).value);
				}

			}
		};
		function generateGraph(tableNumber,X,Y) {
			var col1Title = X;
			var col2Title = Y;

			var data1 = [];
			var data2 = [];
			//fectch x and y data from table
			var allTable=$("#divtext1").find("table");
			var Xposition = 0;
			var Yposition = 0;
			for(var i = 0; i < $(allTable[tableNumber-1]).find("th").length; i++) {
				console.log("i:" + i + "  Html: " + $(allTable[tableNumber-1]).find("th:eq("+i+")").html());
				if($(allTable[tableNumber-1]).find("th:eq("+i+")").html() == X) {
					Xposition = i;
				}
				if($(allTable[tableNumber-1]).find("th:eq("+i+")").html() == Y) {
					Yposition = i;
				}
			}
			
			console.log(Xposition+","+Yposition);
			
			for(var j = 1; j < $(allTable[tableNumber-1]).find("tr").length; j++) {
				for(var m = 1; m < $(allTable[tableNumber-1]).find("th").length; m++) {
					if(m == Xposition) {
					data1.push($(($(allTable[tableNumber-1]).find("tr"))[j]).find("td:eq("+m+")").html());
					}
					if(m == Yposition) {
					data2.push($(($(allTable[tableNumber-1]).find("tr"))[j]).find("td:eq("+m+")").html());
					}
				}
			}
			
			google.setOnLoadCallback(drawChart());

			function drawChart() {
				var data = new google.visualization.DataTable();
				data.addColumn('number');
				data.addColumn('number');

				for (var i = 0; i < data1.length; i++) {
					data.addRow([ parseInt(data1[i]), parseInt(data2[i]) ]);

				}
				var options = {
					legend : {
						position : 'none'
					},
					series : {
						0 : {
							color : '#a1b900',
							lineWidth : 10
						},
					},
					width : 500,
					height : 300,
					hAxis : {
						title : col1Title
					},
					vAxis : {
						title : col2Title
					},
				};

				var chart = new google.visualization.LineChart(document
						.getElementById('flot-lines' + tableNumber));
				chart.draw(data, options);
			}
		}
	</script>
</body>
</html>