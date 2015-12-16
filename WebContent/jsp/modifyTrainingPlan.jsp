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
<title>PeakCentre - Modify Training Plan</title>
<link rel="shortcut icon" href="../image/favicon.png">
<!---CSS Files-->
<link rel="stylesheet" href="../css/master.css">
<link rel="stylesheet" href="../css/tables.css">
<link rel="stylesheet" type='text/css' href="../css/fullcalendar.css" />
<style>
table td {text-align:center}
table input {text-align:center}
#ST1Table td {text-align:left}
#ST2Table td {text-align:left}
#FTTable td {text-align:left}
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
			<p>Modify Training Plan</p>
		</div>
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
						
						</div>
						<div class="form-row">
							<div class="form-item" id ="errmessageDates">
							<!-- 
								<p style="color: #ff6666; font-size: 11px" id = "errmessage"><%=request.getAttribute("message")%></p>
 							-->
							</div>
						</div>
						<div class="form-row" style="text-align: right;">
							<input type="button" id="getTrainingPlan" class="button green" value="modify">
						</div>
					</div>
				</form>

			</div>
			
		<div class="content container_12">
				<div id="divtext1" class="box grid_12" style="display: none"></div>

		</div>
	<div class="footer">
		<p>© Peak Centre. All rights reserved.</p>
	</div>
	<script>
		function printPage() {
			window.print();
		}
	</script>
	<script>
	function addJson(weekdata) {
		var tables = $("#divtext1").find("table");
		$("td").css("border","");
		var weeks = weekdata;
		console.log("weeks:" + weeks);
		
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
		
		$("#divtext1 form").append("<input type='hidden' name='weekData' value='"+ JSON.stringify(allWeek) +"' >");
		$("#divtext1 form").append("<input type='hidden' name='st1' value='"+ JSON.stringify(st1) +"' >");
		$("#divtext1 form").append("<input type='hidden' name='st2' value='"+ JSON.stringify(st2) +"' >");
		$("#divtext1 form").append("<input type='hidden' name='ft' value='"+ JSON.stringify(ft) +"' >");
		console.log("weekData: " + JSON.stringify(allWeek));
		console.log("weekData: " + JSON.stringify(ft));
		//return false;
		return true;
	}
	//=============================================================//
	function replaceSymbol(name) {
		var find="'";
		var re = new RegExp(find, 'g');
		name = name.replace(re, "+");
		//console.log("Name"+name);
		return name;
	}
	function replaceBackward(html) {
		var find= "\\+";
		var re = new RegExp(find, 'g');
		html = html.replace(re, "&#39;");
		return html;
	}
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
				$("#getTrainingPlan").prop('disabled',true);
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
	//=============================================================//
	$("#getTrainingPlan").click(function() {
		var post = {
				username : $("#trainingPlanDate input[name=username]").val(),
				date : $("#trainingPlanDate select[name=date]").val()
		};
		$.post("AjaxModifyTrainingPlan", post, function(data) {
			var html = data[0];
			var totalWeeks = data[1];
			var mod = data[2];
			html=replaceBackward(html);
			$("#divtext1").html(html);

			$("div .box.grid_12").css({display:"block"});

			for(var j = 0; j <= totalWeeks; j++) {
				if(j%4 == 1) {
					$("#mytable" + j).dataTable({
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
					$("#mytable" + j).dataTable({
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
				$("#mytable" + totalWeeks).css({width:""+w,float:"left"});
			}
			//Set colum with equally
			var testwidth = 100/7;
			for(var j = 1; j < totalWeeks; j++) {
				for(var i =0; i < 7; i++) {
					$("#mytable"+j+" thead tr:eq(0) th:eq("+i+")").css({width:""+testwidth+"%"});
				}
			}
			//////////
			$("#ST1Table").dataTable({
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
			$("#ST2Table").dataTable({
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
			$("#FTTable").dataTable({
				sDom : 't',
				bLengthChange : false,
				bFilter : false,
				bPaginate : false,
				bSort : false
			});
			$('#FTTable').find('tbody tr').each(function(){
				$('#FTTable').dataTable().find(this).find('td').not(':eq(0), :eq(3)').editable(function(v, s) {
					console.log(v);
					return (v);
				});
			});
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
		 var d = c.substring(7);
			var column = $(this).parent().children().index(this);
		    var row = $(this).parent().parent().children().index(this.parentNode);
		 for(var i = 0; i < 3; i++) {
			 d++;
			 if($("#mytable" + d).length != 0) {
				 var selected = $(this).find('select').val();
				 $("#mytable"+d+" tbody tr:eq("+row+") td:eq("+column+")").html($(this).html()).find('select').val(selected);
				 if($(this).find('input').length != 0 && $(this).find('input').val() != '') {
					 $("#mytable"+d+" tbody tr:eq("+row+") td:eq("+column+")").find('input').val($(this).find('input').val());
				 }	 
			 }
		 }

	 });
	 <% TestResultTemplateDao tpd = new TestResultTemplateDao();%>
	 <% ArrayList<String> tl = tpd.getAllTemplateAlias();%>
	 	function clickAddZone(o) {
			var added = '<select class="grid" ><option value=""></option><option value="off">off</option>';
			<% for(String st : tl) {%>
				added = added + "<option value='<%=st%>'><%= st%></option>";
			<% }%>
			added += '</select>';
			if(o%4 == 1) {
				console.log("hee");
				$('#mytable' + String(o)).dataTable().fnAddData([added,added,added,added,added,added,added]);
				for(var i = 0; i < 3; i++) {
					o++;
					if($("#mytable"+o).length != 0) {
						var l = $("#mytable"+o).find('thead tr:eq(0) th').length;
						var allAdded = [];
						for(var m = 0; m < l; m++) {
							allAdded.push(added);
						}
						$('#mytable' + String(o)).dataTable().fnAddData(allAdded);
					}	
				}
			} else {
				$('#mytable' + String(o)).dataTable().fnAddData([added,added,added,added,added,added,added]);
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
			$('#mytable' + String(o)).dataTable().fnAddData(tds);

		}
		function clickAddRowST1() {

			$('#ST1Table').dataTable()
					.fnAddData([ "", "", "", "", "", "" ]);
			$('#ST1Table').dataTable().find('td').editable(function(v, s) {
				console.log(v);
				return (v);
			});
		}
		function clickAddRowST2() {

			$('#ST2Table').dataTable()
					.fnAddData([ "", "", "", "", "", "" ]);
			$('#ST2Table').dataTable().find('td').editable(function(v, s) {
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
			$('#FTTable').dataTable().fnAddData([ FTselect, "", "", videoSelect]);
			$('#FTTable').find('tbody tr').each(function(){
				$('#FTTable').dataTable().find(this).find('td').not(':eq(0), :eq(3)').editable(function(v, s) {
					console.log(v);
					return (v);
				});
			});
		}
	</script>
	</body>
	</html>