<!doctype html>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.peakcentre.web.entity.Userinfo"%>
<%@ page import="com.peakcentre.web.dao.TrainingPlanDao"%>
<%@ page import="Util.GenerateVideoHtml" %>
<head>
<meta charset="utf-8">
<title>PeakCentre - View Training Plan</title>
<link rel="shortcut icon" href="../image/favicon.png">
<!---CSS Files-->
<link rel="stylesheet" href="../css/master.css">
<link rel="stylesheet" href="../css/tables.css">
<link rel="stylesheet" type='text/css' href="../css/fullcalendar.css" />
<style>
table td {text-align:center}
</style>
<!---jQuery Files-->
<script src="../js/jquery-1.7.1.min.js"></script>
<script src="../js/jquery-ui-1.8.17.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<script src="../js/jquery.jeditable.js"></script>
<script src="../js/jquery.dataTables.editable.js"></script>
<script src="../js/styler.js"></script>
<script src="../js/jquery.tipTip.js"></script>
<script src="../js/colorpicker.js"></script>
<script src="../js/sticky.full.js"></script>
<script src="../js/global.js"></script>
<script src="../js/fullcalendar/fullcalendar.min.js"></script>
<script src="../js/test.js"></script>
<%
	HttpSession session2 = request.getSession(false); 
	if(session2.getAttribute("id")==null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
    }
%>
<!---Fonts-->
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
			<p>View Training Plan</p>
		</div>
		<% if(!usertype.equals("athlete")) {%>
		<div class="box grid_4">
			<div class="box-head">
				<h2>User Profile Search</h2>
			</div>

			<form method="post" action="">
				<input type="hidden" value="viewTrainingPlan" name="page" />
				<div class="box-content">
					<div class="form-row">
						<p><%=resb
					.getString("PLEASE_ENTER_USERNAME_NAME_TO_ADD_PLAN")%></p>
					</div>
					<br> <br>
					<div class="form-row">
						<label class="form-label">First Name</label>
						<div class="form-item">
							<input type="text" name="fname" required />
						</div>
					</div>
					<div class="form-row">
						<label class="form-label">Last Name</label>
						<div class="form-item">
							<input type="text" name="lname" required />
						</div>
					</div>
					<div class="form-row">
						<div class="form-item" id ="errmessage">

						</div>
					</div>
					<div class="form-row" style="text-align: right;">
						<input type="button" id="userProfileSearch" class="button green" value="search">
					</div>
				</div>
			</form>
		</div>

			<div class="box grid_4" id="confirmUser" title="User Selection"
				style="display: none">
				<div class="box-head">
					<h2>User Profile</h2>
				</div>
				<form method="post" action="">
					<div class="box-content">
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_USER_TO_VIEW_TEST_RESULT")%></p>
						</div>
						<br>
						<div class="form-row">
							<div class="form-item" id="usernameForm">
								<select name="userlist">
								</select>

							</div>
						</div>
						<div class="form-row" style="text-align: right;">
							<input type="button" id="getTrainingPlanDates" class="button green" value="confirm">
						</div>
				</form>
			</div>
			</div>
			
			<div class="box grid_4"  id="trainingPlanDate" style="display: none">

				<div class="box-head">
					<h2>Choose Training Plan Date</h2>
				</div>
				<form method="post" action="">

					<div class="box-content">
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_TEMP_AND_DATE")%></p>
						</div>
						<br> <br>

						<div class="form-row">
							<label class="form-label">Date</label>
							<div class="form-item" id="trainingPlanHidden">
								<select name="date">
								</select>
							</div>
							<div class="form-row">
								<div class="form-item" id ="errmessageDates">
								<!-- 
									<p style="color: #ff6666; font-size: 11px" id = "errmessage"><%=request.getAttribute("message")%></p>
	 							-->
								</div>
							</div>
						</div>
						<div class="form-row" style="text-align: right;">
							<input type="button" id="getTrainingPlan" class="button green" value="show">
						</div>
					</div>
				</form>

			</div>
			<% } else {%>
			<div class="box grid_4"  id="trainingPlanDate" style="display: block">
				<div class="box-head">
					<h2>Choose Training Plan Date</h2>
				</div>
				<form method="post" action="">

					<div class="box-content">
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_TEMP_AND_DATE")%></p>
						</div>
						<br> <br>

						<div class="form-row">
							<label class="form-label">Date</label>
							<div class="form-item" id="trainingPlanHidden">
								<select name="date">
								<% String username = session.getAttribute("username").toString(); %>
								<% TrainingPlanDao tpd = new TrainingPlanDao(); %>
								<% List<String> l = tpd.getTrainingPlanDate(username);%>
								<% for(String st: l) {%>
									<option value='<%= st%>'><%= st%></option>
								<% }%>
								</select>
							</div>
						<input type="hidden" name="username" value="<%= username%>" >
						</div>
						<div class="form-row">
							<div class="form-item" id ="errmessageDates">

							</div>
						</div>
						<div class="form-row" style="text-align: right;">

							<input type="button" id="getTrainingPlan" class="button green" value="show">

						</div>
					</div>
				</form>
			</div>
			<% } %>
		<div class="content container_12">
				<div class="box grid_12" style="display: none">

					<div class="box-head">
						<h2>Training Plan</h2>
					</div>
					<br>
						<div id="divtext1">
						</div>

			
				</div>
			</div>
		
		<div id="dialog" title="Test Result">
			<div id="testResult">
			</div>
			<div class="form-row" style="text-align: right;">

					<input type="button" class="button green"
					value="close"
					onclick="$(this).closest('.ui-dialog-content').dialog('close');" />
	
			</div>
		</div>
		
		<div id="dialog1" title="Flexibility Training">
			<div id="ftGraph">
			</div>
			<div class="form-row" style="text-align: right;">

					<input type="button" class="button green"
					value="close"
					onclick="closeVideo(event)" />
	
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
          }">
	</script>
	<script>
	//=============================================================//
	//=============================================================//
	$('#userProfileSearch').click(function(){
		$("#errmessage").html("");
		var post = {
			fname : $("input[name=fname]").val(),
			lname : $("input[name=lname]").val(),
			page: $('input[name=page]').val()
		};
		console.log("fname : " + post.fname);
		console.log("lanme : " + post.lname);
		$.post('AjaxSearchUser',post, function(data){
			//console.log(data);
			var message = data[0];
			var list = data[1];
			if(message == "") {
				var innerHtml = "";
				for(var i in list) {
					innerHtml = innerHtml + "<option value=" + i + ">" + 
					list[i].fname + " " +list[i].lname + " " + list[i].username + " " + list[i].city + "</option>";
				}
				var hiddenpart = "<input name='fname' type='hidden' value='" + list[0].fname + "' >" +
				"<input name='lname' type='hidden' value='" + list[0].lname + "' >";
				$("select[name=userlist]").html(innerHtml);
				$("#usernameForm").append(hiddenpart);
				document.getElementById("confirmUser").style.display="block";
			} else {
				$("#errmessage").html("<p style='color: #ff6666; font-size: 11px'>"+message+"</p>");
				$("input[name=fname]").val("");
				$("input[name=lname]").val("");
			}
		});
	});
	//=============================================================//
	//=============================================================//
	$('#getTrainingPlanDates').click(function(){
		var post = {
				fname: $("#confirmUser").find("input[name=fname]").val(),
				lname: $("#confirmUser").find("input[name=lname]").val(),
				userlist: $("#confirmUser").find("select[name=userlist]").val()
		};
		$.post('AjaxGetTrainingPlanDate',post,function(data){
			var username = data[0];
			var dateList = data[1];
			var message = data[2];
			if(message != "") {
				$("#errmessageDates").html('<p style="color: #ff6666; font-size: 11px">'+message+'</p>');
			}
			var innerHtmlDate = "";
			var hiddenpart = '<input type="hidden" name="username" value="' + username + '" >';
			for(var i in dateList) {
				innerHtmlDate = innerHtmlDate + "<option value='" + dateList[i] + "' >" +
				dateList[i] + "</option>";
			}

			$("#trainingPlanDate").find("select[name=date]").html(innerHtmlDate);
			$("#trainingPlanHidden").append(hiddenpart);
			$('#trainingPlanDate').css({display:'block'});
		});
	});
	//=============================================================//
	function replaceSymbol(html) {
		var find= "\\+";
		var re = new RegExp(find, 'g');
		html = html.replace(re, "'");
		return html;
	}
	//=============================================================//
	$("#getTrainingPlan").click(function() {
		var post = {
				username : $("#trainingPlanDate input[name=username]").val(),
				date : $("#trainingPlanDate select[name=date]").val()
		};
		$.post("AjaxGetTrainingPlan", post, function(data) {
			var html = data[0];
			var totalWeeks = data[1];
			var mod = data[2];
			console.log("before:"+html);
			html=replaceSymbol(html);
			console.log("after :" +html);
			$("#divtext1").html(html);
			

			$("div .box.grid_12").css({display:"block"});
			$("table").dataTable({
				sDom : 't',
				bLengthChange : false,
				bFilter : false,
				bPaginate : false,
				bSort : false
			});
			if(mod != 0) {
				var w = (mod*100)/7;
				var w = w + '%';
				$("#mytable").css({width:""+w,float:"left"});
			}

		});
	});
	//=============================================================//
	//=============================================================//
	$("#dialog").dialog({
			autoOpen : false,
			resizable : true,
			modal : true
		});
	$("#dialog1").dialog({
		autoOpen: false,
        resizable: false,
        modal: true,
        width:'auto'
	});
	//=============================================================//
	//=============================================================//
	function showFTGraph(name) {
		//var html = "<img src='../image/FT/Lying quad stretch.png'>";
		var html = "<img src='../image/FT/"+name+".png'>"
		$("#ftGraph").html(html);
		$("#dialog1").dialog("open");
		return false;
	}
	//=============================================================//
	//=============================================================//
	function showVideo(name) {
		var find="-";
		var re = new RegExp(find, 'g');
		name = name.replace(re, " ");
		console.log("Name"+name);
		var html = '<video width="400" controls>'
			+ '<source src="../video/'+ name +'.mp4" type="video/mp4">'
			+ '</video>';
		$("#ftGraph").html(html);
		$("#dialog1").dialog("open");
		return false;
	}
	//=============================================================//
	//=============================================================//
	function closeVideo() {
		if($("#ftGraph video").length > 0) {
			if(!$("#ftGraph video").get(0).paused) {
				$("#ftGraph video").get(0).pause();
			}
		}
		$('.ui-dialog-content').dialog('close');
		return false;
	}
	//=============================================================//
	//=============================================================//
	function showTR(date,templateName) {
		var post = {
				username : $("#trainingPlanDate input[name=username]").val(),
				tempName : templateName,
				date : date
		};
		$.post("TestResultGetJson", post, function(data) {
			var message = data[0];
			var html = data[1];
			console.log("TestResult: " + html);
			if(message == 0) {
				$("#testResult").html(html).end();
				for (var i = 0; i < 10; i++) {
					if(document.getElementById("tn"+i)){
						generateGraph(document.getElementById("tn"+i).value, $("#tn"+i).parent().find("input[name=X]").val(),$("#tn"+i).parent().find("input[name=Y]").val());
					}
				}
				$("#dialog").dialog("open"); 
			} else {
				$("#testResult").html("<p>There is no test result on this Date!</p>");
				$("#dialog").dialog("open");
			}
		})
		return false;
	}
	//=============================================================//
	//=============================================================//
	//generate graph
	function generateGraph(tableNumber,X,Y) {
		var col1Title = X;
		var col2Title = Y;

		var data1 = [];
		var data2 = [];
		//fectch x and y data from table
		var allTable=$("#testResult").find("table");
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
			for(var m = 0; m < $(allTable[tableNumber-1]).find("th").length; m++) {
				if(m == Xposition) {
					console.log("Here");
				data1.push($(($(allTable[tableNumber-1]).find("tr"))[j]).find("td:eq("+m+")").html());
				}
				if(m == Yposition) {
				data2.push($(($(allTable[tableNumber-1]).find("tr"))[j]).find("td:eq("+m+")").html());
				}
			}
		}
		
		console.log("Data : \n" + data1 + " \nData : " +data2 );
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