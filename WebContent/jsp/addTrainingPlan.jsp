<!doctype html>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.peakcentre.web.entity.Userinfo"%>
<%@ page import="com.peakcentre.web.dao.TestResultTemplateDao"%>
<%@ page import="Util.GenerateVideoHtml"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - Add Training Plan</title>
<link rel="shortcut icon" href="../image/favicon.png">
<!---CSS Files-->
<link rel="stylesheet" href="../css/master.css">
<link rel="stylesheet" href="../css/tables.css">
<link rel="stylesheet" type='text/css' href="../css/fullcalendar.css" />
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
<!---Fonts-->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Ubuntu:500'
	rel='stylesheet' type='text/css'>
<%
	HttpSession session2 = request.getSession(false); 
	if(session2.getAttribute("id")==null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
    }
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
			<p>Add Training Plan</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>User Profile Search</h2>
			</div>
			<form method="post" action="">
				<input type="hidden" value="addTrainingPlan" name="page" />
				<div class="box-content">
					<div class="form-row">
						<p><%=resb.getString("PLEASE_ENTER_USERNAME_NAME_TO_ADD_PLAN")%></p>
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
		<form method="post" onsubmit="return addJson()" action="SaveTrainingPlanServlet">
				<div class="box grid_4" id="userProfile" style="display: none">
					<div class="box-head">
						<h2>User Profile</h2>
					</div>
					<div class="box-content">
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_USER_TO_ADD_TRAINING_PLAN")%></p>
						</div>
						<br>
						<div class="form-row">
							<div class="form-item" id="usernameForm">
								<select name="userlist">			
								</select>
							</div>
						</div>
						<div class="form-row">
							<p><%=resb.getString("PLEASE_ENTER_DATE_TO_ADD_PLAN")%></p>
						</div>
						<br>
						<div class="form-row">
							<label class="form-label">Start Date</label>
							<div class="form-item">
								<input type="text" class="datepicker" id="startdate"
									name="startdate" required />
							</div>
						</div>
						<div class="form-row">
							<label class="form-label">End Date</label>
							<div class="form-item">
								<input type="text" class="datepicker" id="enddate"
									name="enddate" required />
							</div>
						</div>
						<div class="form-row">
							<div class="form-item" id ="errmessageDates">
						</div>
						</div>
						<div class="form-row">
							<div class="form-item">
								<p id="message" style="color: #ff6666; font-size: 11px"></p>
							</div>
						</div>
						<div class="form-row" style="text-align: right;">
							<input type="button" class="button green" value="start"
								onclick="validDates()" />
						</div>
					</div>
				</div>

				<div id="div1" class="box grid_12" style="display: none"></div>
				<div class="box grid_12">
					<div id="div2" class="box grid_12" style="display: none">
						<div class="form-row" style="text-align: right;">
							<input type="submit" class="button green"  id="submitTrainingPlan" value="save">
						</div>
					</div>
				</div>
		</form>
	</div>

	<div class="footer">
		<p>© Peak Centre. All rights reserved.</p>
	</div>
<script>
	function printPage() {
			window.print();
		}
	function replaceSymbol(name) {
		var find="'";
		var re = new RegExp(find, 'g');
		name = name.replace(re, "+");
		//console.log("Name"+name);
		return name;
	}
	//Parse the table content to Json and add the Json to hidden input
	function addJson() {
		$("td").css("border","");
		//var weeks = $("input[name=weeks]").val();
		var startdate = new Date(
					document.getElementsByName("startdate")[0].value);
		var startdate2 = startdate;
		var enddate = new Date(
				document.getElementsByName("enddate")[0].value);
			enddate.setDate(enddate.getDate() + 1);
		var perWeek = 24 * 60 * 60 * 1000 * 7;
			//get total weeks
		var weeks = Math.ceil((enddate.valueOf() - startdate.valueOf())
					/ perWeek);
		var tables = $("#div1").find("table");
		
		//Valid Week Table
		for(var i = 0; i < weeks; i++) {
			var days = $(tables[i]).find("thead tr:eq(1) th").length;
			for(var j = 1; j <= days; j++) {
				var content = "";
				$(tables[i]).find("tbody tr td:nth-child("+j+")").each(function(){ 
					content+=$(this).find("select").val();
				});
				if(content == "") {
					$(tables[i]).find("tbody tr td:nth-child("+j+")").css('border','2px solid red');
					alert("Please fill content in red box!");
					return false;				
				}
			}
		}
		//Get input data in Week Table//
		var allWeek ={};
		for(var i = 0; i < weeks; i++) {	
			var allTh=$(tables[i]).find("thead tr:eq(1) th");
			var days = allTh.length;
			allWeek["week"+(i+1)]=[];
			var allTr=$(tables[i]).find("tbody tr");
			for(var j = 0; j < allTr.length; j++) {
				var oneEntry = {};
				for(var m=0; m< days; m++) {
					console.log("key: " + $(allTh[m]).html());
					if($(allTr[j]).find("td:eq("+m+") select").val() == "off") {
						oneEntry[$(allTh[m]).html()]= "off";
					} else if ($(allTr[j]).find("td:eq("+m+") select").val() == "") {
						oneEntry[$(allTh[m]).html()]= "";
					} else {
						//replace ' with +
						oneEntry[$(allTh[m]).html()]= $(allTr[j]).find("td:eq("+m+") select").val() + " " + replaceSymbol($(allTr[j]).find("td:eq("+m+") input").val());
						//oneEntry[$(allTh[m]).html()]= $(allTr[j]).find("td:eq("+m+") select").val() + " " + $(allTr[j]).find("td:eq("+m+") input").val();
					}
				}
				allWeek["week"+(i+1)].push(oneEntry);
			}
		}
		console.log(JSON.stringify(allWeek));
		
		//Get Stage Data//
		var st1 = [];
		var st2 = [];
		//stage1
		var allTh = $(tables[i]).find("thead tr:eq(0) th");
		var allTr = $(tables[i]).find("tbody tr");
		for(var j = 0; j < allTr.length; j++) {
			var stage1 = {};
			for(var m=0; m < allTh.length; m++) {
				var content = $(allTr[j]).find("td:eq("+m+")").html();
				if(content != "Click to edit") {
					//replace ' with +
					stage1[$(allTh[m]).html()] = replaceSymbol(content);
					//stage1[$(allTh[m]).html()] = content;
				} else {
					$(allTr[j]).find("td:eq("+m+")").css('border','2px solid red');
					alert("Please fill content in red box!");
					return false;
				}
			}
			st1.push(stage1);
		}
		//stage2
		allTh = $(tables[i+1]).find("thead tr:eq(0) th");
		allTr = $(tables[i+1]).find("tbody tr");
		for(var j = 0; j < allTr.length; j++) {
			var stage2 = {};
			for(var m=0; m < allTh.length; m++) {
				var content = $(allTr[j]).find("td:eq("+m+")").html();
				if(content != "Click to edit") {
					//replace ' with +
					stage2[$(allTh[m]).html()] = replaceSymbol(content);
					//stage2[$(allTh[m]).html()] = content; 
				} else {
					$(allTr[j]).find("td:eq("+m+")").css('border','2px solid red');
					alert("Please fill content in red box!");
					return false;
				}
			}
			st2.push(stage2);
		}

		//Get Flexibility Training Data//
		var ft = [];
		allTh = $(tables[i+2]).find("thead tr:eq(0) th");
		allTr = $(tables[i+2]).find("tbody tr");
		for(var j = 0; j < allTr.length; j++) {
			var ftDetail = {};
			for(var m=0; m < allTh.length; m++) {
				if( m == 0) {
					ftDetail[$(allTh[m]).html()] = $(allTr[j]).find("td:eq("+m+") select").val();
				} else if(m == 3) {
					var tempSelect = $(allTr[j]).find("td:eq("+m+") select:eq(0)").val();
					if(tempSelect == 'No') {
						ftDetail[$(allTh[m]).html()] = $(allTr[j]).find("td:eq("+m+") select:eq(0)").val();
					} else {
						var tempContent = 'Yes ';
						tempContent += $(allTr[j]).find("td:eq("+m+") select:eq(1)").val();
						ftDetail[$(allTh[m]).html()] = tempContent;
					}
				} else{
					var content = $(allTr[j]).find("td:eq("+m+")").html();
					if(content != "Click to edit") {
						//replace ' with +
						ftDetail[$(allTh[m]).html()] = replaceSymbol(content);
						//ftDetail[$(allTh[m]).html()] = content; 
					} else {
						$(allTr[j]).find("td:eq("+m+")").css('border','2px solid red');
						alert("Please fill content in red box!");
						return false;
					}
				}
			}
			ft.push(ftDetail);
		}
		
		$("#div1").append("<input type='hidden' name='weekData' value='"+ JSON.stringify(allWeek) +"' >");
		$("#div1").append("<input type='hidden' name='st1' value='"+ JSON.stringify(st1) +"' >");
		$("#div1").append("<input type='hidden' name='st2' value='"+ JSON.stringify(st2) +"' >");
		$("#div1").append("<input type='hidden' name='ft' value='"+ JSON.stringify(ft) +"' >");
		console.log("HHHH:"+JSON.stringify(ft));
		return true;
	}
	<%
	if ("administrator".equals(usertype) || "coach".equals(usertype)) {
	%>
	$('#userProfileSearch').click(function(){
		$("#errmessage").html("");
		var post = {
			fname : $("input[name=fname]").val(),
			lname : $("input[name=lname]").val(),
			page: $('input[name=page]').val()
		};
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
				document.getElementById("userProfile").style.display="block";
			} else {
				$("#errmessage").html("<p style='color: #ff6666; font-size: 11px'>"+message+"</p>");
				$("input[name=fname]").val("");
				$("input[name=lname]").val("");
			}
		});
	});
	 
	 $(document).on('change', 'select.video', function(){
		//var videoContentSelect = "<select><option value='1'>Lying quad stretch</option><option value='2'>Groin stretch</option></select>";
		var videoContentSelect = '<%= GenerateVideoHtml.generateHtml() %>';
		var c = $(this).parent();
		var column = $(c).parent().children().index(c);
		var row = $(c).parent().parent().children().index(c.parentNode);
		if($(this).val() == 'Yes') {
			if(!$(this).next().is("select")) {
				$(this).parent().append(videoContentSelect);
			}
		} else {
			if($(this).next().is('select')) {
				$(this).next().remove();
			}
		}
	 });
	 $(document).on('change', 'select.grid', function () {
		//
		var c = $(this).parent();
		var column = $(c).parent().children().index(c);
	    var row = $(c).parent().parent().children().index(c.parentNode);
			if($(this).val() == "off") {
				if($(this).next().is("input")) {
					$(this).next().remove();
				}
			} else if($(this).val() == "") {
				if($(this).next().is("input")) {
					$(this).next().remove();
				}
			} else {
					if(!$(this).next().is("input")) {
						$(this).parent().append('<input name="text" required>');
					}
			}
	 });
	 $(document).on('change','td.copy',function() {
		 var c = $(this).closest('table').attr('id');
		 var d = c.substring(11);
			var column = $(this).parent().children().index(this);
		    var row = $(this).parent().parent().children().index(this.parentNode);
		 for(var i = 0; i < 3; i++) {
			 d++;
			 if($("#myDataTable" + d).length != 0) {
				 var selected = $(this).find('select').val();
				 $("#myDataTable"+d+" tbody tr:eq("+row+") td:eq("+column+")").html($(this).html()).find('select').val(selected);
				 if($(this).find('input').length != 0 && $(this).find('input').val() != '') {
					 $("#myDataTable"+d+" tbody tr:eq("+row+") td:eq("+column+")").find('input').val($(this).find('input').val());
				 }	 
			 }
		 }
	 });
	<%  } %>
	/*------------------------------------------------------------------------------*/
	function validDates() {
		$("#errmessageDates").html("");
		var startdate = document.getElementsByName("startdate")[0].value;
		var enddate = document.getElementsByName("enddate")[0].value;
		var post = {
				startDate: startdate,
				endDate: enddate,
				fname : $("#usernameForm input[name=fname]").val(),
				lname : $("#usernameForm input[name=lname]").val(),
				userlist : $("#usernameForm select[name=userlist]").val()
		};
		$.post('AjaxCheckTrainingPlanDates', post, function(data) {
			console.log("check:" + data);
			if(data == "") {
				showTable();
			} else {
				$("#errmessageDates").html("<p style='color: #ff6666; font-size: 11px'>"+data+"</p>");
			}
		});
		return true;
	}
	/*--------------------------------------------------------------------------*/
		//generate table base on data user entered
		function showTable() {
			var i = "";
			var startdate = new Date(
					document.getElementsByName("startdate")[0].value);
			var startdate2 = startdate;
			var enddate = new Date(
					document.getElementsByName("enddate")[0].value);
			enddate.setDate(enddate.getDate() + 1);
			
			//templateAlias
			var templateSelect = '<select class="grid" ><option value=""></option><option value="off">off</option>';
			<% TestResultTemplateDao tpd = new TestResultTemplateDao();%>
			<% ArrayList<String> tl = tpd.getAllTemplateAlias();%>
			<% for(String st : tl) {%>
				templateSelect = templateSelect + "<option value='<%=st%>'><%= st%></option>";
			<% }%>
			templateSelect += '</select>';
			//FT select
			var FTselect = "<select>"
					+ "<option value='Lying quad stretch'>Lying quad stretch</option>"
					+ "<option value='Standing hamstring stretch'>Standing hamstring stretch</option>"
					+ "<option value='Groin stretch'>Groin stretch</option>"
					+ "<option value='Hip Flexor stretch'>Hip Flexor stretch</option>"
					+ "<option value='Glute stretch'>Glute stretch</option>"
					+ "<option value='Triceps Stretch'>Triceps Stretch</option>"
					+ "<option value='Cross shoulder stretch'>Cross shoulder stretch</option>"
					+ "<option value='Kneeling wrist stretch'>Kneeling wrist stretch</option>"
					+ "<option value='Kneeling bench stretch'>Kneeling bench stretch</option>"
					+ "</select>";					
			//check empty
			if (document.getElementById("startdate").value == ""
					|| document.getElementById("enddate").value == "") {
				document.getElementById("message").innerHTML = "Start Date or End Date could not be empty.";
			} 
			else {
				document.getElementById("message").innerHTML = "";
				var perWeek = 24 * 60 * 60 * 1000 * 7;
				//get total weeks
				var weeks = Math.ceil((enddate.valueOf() - startdate.valueOf())
						/ perWeek);
				//get mod days
				var mod = (enddate.valueOf() - startdate.valueOf()) % perWeek
						/ (24 * 60 * 60 * 1000);		
				var table = "";
				for (i = 0; i < weeks; i++) {
					if ((i == (weeks - 1)) && (mod != 0)) {
						table += '<input type="hidden" name="weeks" value="'+weeks+'">';
						table += '<div class="box grid_12">';
						table += '<div class="box-head">'
								+ '<h2>Training Plan - Week' + (i + 1)
								+ '</h2>' + '</div>'
								+ '<div class="box-content no-pad">';
						table += '<ul class="table-toolbar">';
						table += '<li onClick="clickAddZoneLastTable('
							+ String(i)
							+ ','
							+ mod
							+ ')">'
							+ '<a>'
							+ '<img src="../image/icons/basic/plus.png" alt=""/>'
							+ ' Add Zone' + '</a>' + '</li>' + '</ul>';
					table += '<table id="myDataTable' + String(i) + '">';
						var weekday = new Array(7);
						weekday[0] = "Sunday";
						weekday[1] = "Monday";
						weekday[2] = "Tuesday";
						weekday[3] = "Wednesday";
						weekday[4] = "Thursday";
						weekday[5] = "Friday";
						weekday[6] = "Saturday";
						table += '<thead>' + '<tr>' + '';
						for (var d = 0; d < mod; d++) {
							table += '<th>' + weekday[startdate2.getDay()]
									+ '</th>';
							startdate2.setDate(startdate2.getDate() + 1);

						}
						table += '</tr>';
						enddate.setDate(enddate.getDate() - mod - 1);

						table += '<tr>' + '';
						for (var d = 0; d < mod; d++) {
							table += '<th>'
									+ new Date(enddate.setDate(enddate
											.getDate() + 1)).format("MM/dd")
									+ '</th>';

						}
						table += '</tr>' + '</thead>' + '<tbody>' + '<tr>';
						for (var d = 0; d < mod; d++) {
							table += '<td>' + templateSelect + '</td>';
						}
						table += '</tr>' + '</tbody>';
						table += '</table>';
						table += '</div>' + '</div>';
						startdate.setDate(startdate.getDate() + 1);

					} else {
						table += '<div class="box grid_12">';
						table += '<div class="box-head">'
								+ '<h2>Training Plan - Week' + (i + 1)
								+ '</h2>' + '</div>'
								+ '<div class="box-content no-pad">';
						table += '<ul class="table-toolbar">';
						table += '<li onClick="clickAddZone('
							+ String(i)
							+ ')">'
							+ '<a>'
							+ '<img src="../image/icons/basic/plus.png" alt=""/>'
							+ ' Add Zone' + '</a>' + '</li>' + '</ul>';
					table += '<table id="myDataTable' + String(i) + '">';

						var weekday = new Array(7);
						weekday[0] = "Sunday";
						weekday[1] = "Monday";
						weekday[2] = "Tuesday";
						weekday[3] = "Wednesday";
						weekday[4] = "Thursday";
						weekday[5] = "Friday";
						weekday[6] = "Saturday";

						var startWeekday1 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday2 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday3 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday4 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday5 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday6 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday7 = weekday[startdate.getDay()];

						table += '<thead>' + '<tr>' + '' + '<th>'
								+ startWeekday1 + '</th>' + '<th>'
								+ startWeekday2 + '</th>' + '<th>'
								+ startWeekday3 + '</th>' + '<th>'
								+ startWeekday4 + '</th>' + '<th>'
								+ startWeekday5 + '</th>' + '<th>'
								+ startWeekday6 + '</th>' + '<th>'
								+ startWeekday7 + '</th>' + '</tr>';

						startdate.setDate(startdate.getDate() - 6);

						table += '<tr>'
								+ ''
								+ '<th>'
								+ startdate.format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>';

						table += '</tr>' + '</thead>';
						table += '<tbody>'
								+ '<tr>';
						for(var temp = 0; temp < 7; temp++) {
							if(i%4 == 0) {
								table += '<td class="copy">'+ templateSelect +'</td>';
							} else {
								table += '<td>'+templateSelect+'</td>';								
							}
						}
						table += '</tr>';
						table += '</tbody>';
						table += '</table>';
						table += '</div>' + '</div>';
						startdate.setDate(startdate.getDate() + 1);
					}
				}

				table += '<div class="box grid_12">';
				table += '<div class="box-head">'
						+ '<h2>Training Plan - ST1</h2>' + '</div>'
						+ '<div class="box-content no-pad">';
				table += '<ul class="table-toolbar">';
				
				table += '<li onClick="clickAddRowST1()">' + '<a>'
						+ '<img src="../image/icons/basic/plus.png" alt=""/>'
						+ ' Add Row' + '</a>' + '</li>' + '</ul>';
				table += '<table id="ST1DataTable">';

				table += '<thead>' + '<tr>' + '<th>No.</th>'
						+ '<th>Exercise</th>' + '<th>Sets</th>'
						+ '<th>Reps</th>' + '<th>Tempo</th>' + '<th>Rest</th>'
						+ '</tr>' + '</thead>';
				table += '<tbody>' + '<tr>' + '<td></td>' + '<td></td>'
						+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
						+ '</tr>';
				table += '</tbody>';
				table += '</table>';
				table += '</div>' + '</div>';
				i++;

				table += '<div class="box grid_12">';
				table += '<div class="box-head">'
						+ '<h2>Training Plan - ST2</h2>' + '</div>'
						+ '<div class="box-content no-pad">';
				table += '<ul class="table-toolbar">';
				table += '<li onClick="clickAddRowST2()">' + '<a>'
						+ '<img src="../image/icons/basic/plus.png" alt=""/>'
						+ ' Add Row' + '</a>' + '</li>' + '</ul>';
				table += '<table id="ST2DataTable">';
				table += '<thead>' + '<tr>' + '<th>No.</th>'
						+ '<th>Exercise</th>' + '<th>Sets</th>'
						+ '<th>Reps</th>' + '<th>Tempo</th>' + '<th>Rest</th>'
						+ '</tr>' + '</thead>';
				table += '<tbody>' + '<tr>' + '<td></td>' + '<td></td>'
						+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
						+ '</tr>';
				table += '</tbody>';
				table += '</table>';
				table += '</div>' + '</div>';
				i++;
				var videoSelect = "<select class='video'>"
					+ "<option>No</option>"
					+ "<option>Yes</option>"
					+ "</select>";
				table += '<div class="box grid_12">';
				table += '<div class="box-head">'
						+ '<h2>Training Plan - Flexibility Training</h2>'
						+ '</div>' + '<div class="box-content no-pad">';
				table += '<ul class="table-toolbar">';
				table += '<li onClick="clickAddRowFT()">' + '<a>'
						+ '<img src="../image/icons/basic/plus.png" alt=""/>'
						+ ' Add Row' + '</a>' + '</li>' + '</ul>';
				table += '<table id="FTDataTable">';
				table += '<thead>' + '<tr>' + '<th>Stretching Exercise</th>'
						+ '<th>Sets</th>' + '<th>Hold (in sec)</th>' + '<th>Video</th>'+ '</tr>'
						+ '</thead>';
				table += '<tbody>' + '<tr>' + '<td>'+ FTselect + '</td>' + '<td></td>'
						+ '<td></td>' + '<td>'+videoSelect+'</td>' + '</tr>';
				table += '</tbody>';
				table += '</table>';
				table += '</div>' + '</div>';
				document.getElementById("div1").innerHTML = table;
				document.getElementById("div1").style.display = "block";
				document.getElementById("div2").style.display = "block";
			}

			for(var j = 0; j < weeks; j++) {
				if(j%4 == 0) {
					$("#myDataTable" + j).dataTable({
						sDom : 't',
						bLengthChange : false,
						bFilter : false,
						bPaginate : false,
						bSort : false,
						"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
							  $('td', nRow).addClass( "copy" );
							  return nRow;
							}
					});
				} else {
					$("#myDataTable" + j).dataTable({
						sDom : 't',
						bLengthChange : false,
						bFilter : false,
						bPaginate : false,
						bSort : false
					});
				}
			}
			
			if(mod != 0) {
				var w = (mod*100)/7;
				var w = w + '%';
				$("#myDataTable" + (weeks-1)).css({width:""+w,float:"left"});
			}
			
			$("#ST1DataTable").dataTable({
				sDom : 't',
				bLengthChange : false,
				bFilter : false,
				bPaginate : false,
				bSort : false
			}).makeEditable({
				sUpdateURL : function(value, settings) {
					return (value);
				},
				oEditableSettings : {
					event : 'click'
				}

			});
			$("#ST1DataTable").dataTable().on( 'key-focus', function ( e, datatable, cell ) {
		        editor.inline( cell.index(), {
		            onBlur: 'submit'
		        } );
		    } );
			$("#ST2DataTable").dataTable({
				sDom : 't',
				bLengthChange : false,
				bFilter : false,
				bPaginate : false,
				bSort : false
			}).makeEditable({
				sUpdateURL : function(value, settings) {
					return (value);
				},
				oEditableSettings : {
					event : 'click'
				}

			});
			$("#FTDataTable").dataTable({
				sDom : 't',
				bLengthChange : false,
				bFilter : false,
				bPaginate : false,
				bSort : false
			}).find('td').not(':eq(0),:eq(3)').editable(function(v, s) {
				console.log(v);
				return (v);
			});

		}
		//*****************************************//
		//add one more row
		function clickAddZone(o) {
			console.log("This: "+ $("#myDataTable"+o).find('thead tr:eq(0) th').length);
			var added = '<select class="grid" ><option value=""></option><option value="off">off</option>';
			<% for(String st : tl) {%>
				added = added + "<option value='<%=st%>'><%= st%></option>";
			<% }%>
			added += '</select>';
			if(o%4 == 0) {
				$('#myDataTable' + String(o)).dataTable().fnAddData([added,added,added,added,added,added,added]);
				for(var i = 0; i < 3; i++) {
					o++;
					if($("#myDataTable"+o).length != 0) {
						var l = $("#myDataTable"+o).find('thead tr:eq(0) th').length;
						var allAdded = [];
						for(var m = 0; m < l; m++) {
							allAdded.push(added);
						}
						$('#myDataTable' + String(o)).dataTable().fnAddData(allAdded);
					}	
				}
			} else {
				$('#myDataTable' + String(o)).dataTable().fnAddData([added,added,added,added,added,added,added]);
			}
		}
		function clickAddZoneLastTable(o, mod) {
			var tds = [];
			var added = '<select class="grid" ><option value=""></option><option value="off">off</option>';
			<% for(String st : tl) {%>
				added = added + "<option value='<%=st%>'><%= st%></option>";
			<% }%>
			added += '</select>';
			for (var i = 0; i < mod; i++) {
				tds.push(added);

			}
			$('#myDataTable' + String(o)).dataTable().fnAddData(tds);

		}
		function clickAddRowST1() {

			$('#ST1DataTable').dataTable()
					.fnAddData([ "", "", "", "", "", "" ]);
			$('#ST1DataTable').dataTable().find('td').editable(function(v, s) {
				console.log(v);
				return (v);
			});
		}
		function clickAddRowST2() {

			$('#ST2DataTable').dataTable()
					.fnAddData([ "", "", "", "", "", "" ]);
			$('#ST2DataTable').dataTable().find('td').editable(function(v, s) {
				console.log(v);
				return (v);
			});
		}
		function clickAddRowFT() {
			var FTselect = "<select>"
				+ "<option value='Lying quad stretch'>Lying quad stretch</option>"
				+ "<option value='Standing hamstring stretch'>Standing hamstring stretch</option>"
				+ "<option value='Groin stretch'>Groin stretch</option>"
				+ "<option value='Hip Flexor stretch'>Hip Flexor stretch</option>"
				+ "<option value='Glute stretch'>Glute stretch</option>"
				+ "<option value='Triceps Stretch'>Triceps Stretch</option>"
				+ "<option value='Cross shoulder stretch'>Cross shoulder stretch</option>"
				+ "<option value='Kneeling wrist stretch'>Kneeling wrist stretch</option>"
				+ "<option value='Kneeling bench stretch'>Kneeling bench stretch</option>"
				+ "</select>";
			var videoSelect = "<select class='video'>"
				+ "<option>No</option>"
				+ "<option>Yes</option>"
				+ "</select>";
			$('#FTDataTable').dataTable().fnAddData([ FTselect, "", "" ,videoSelect]);
			$('#FTDataTable').find('tbody tr').each(function(){
				$('#FTDataTable').dataTable().find(this).find('td').not(':eq(0),:eq(3)').editable(function(v, s) {
					console.log(v);
					return (v);
				});
			});
		}
		//*****************************************//
		$(".datepicker").datepicker({
			showMonthAfterYear : true,
			changeYear : true,
			changeMonth : true,
			numberOfMonths : 1,
			yearRange : "2010:2020"

		});

		Date.prototype.format = function(format) {
			var o = {
				"M+" : this.getMonth() + 1, //month
				"d+" : this.getDate(), //day
			};
			if (/(y+)/.test(format))
				format = format.replace(RegExp.$1, (this.getFullYear() + "")
						.substr(4 - RegExp.$1.length));
			for ( var k in o)
				if (new RegExp("(" + k + ")").test(format))
					format = format.replace(RegExp.$1,
							RegExp.$1.length == 1 ? o[k] : ("00" + o[k])
									.substr(("" + o[k]).length));
			return format;
		};
	</script>
</body>
</html>