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
<%@ page import="com.peakcentre.web.dao.TestResultTemplateDao" %>
<head>
<meta charset="utf-8">
<title>PeakCentre - Compare Test Result</title>
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
<script src="../js/flot/jquery.flot.axislabels.js"></script>
<!---Fonts-->
<%
	HttpSession session2 = request.getSession(false); 
	if(session2.getAttribute("id")==null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
    }
%>

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
			<p>Compare Test Result</p>
		</div>
		<div class="box grid_4" id="start">
			<div class="box-head">
				<h2>Choose One Tempalte</h2>
			</div>
			<form method="" action="">
				<div class="box-content">
					<div class="form-row">
						<!--  
						<p><%=resb.getString("PLEASE_ENTER_USER_NAME_TO_VIEW")%></p>
						-->
						<p>Please Select One Template</p>
					</div>
					<br> <br>
					<div class="form-row">
						<label class="form-label">Template Name</label>
						<div class="form-item">
							<select name="templateName">
								<%
									
									TestResultTemplateDao tdao = new TestResultTemplateDao();
									ArrayList<String> l = tdao.getAllTempName();
									for(String s: l) {
										
								%>
								<option value=<%=s%>><%=s%></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					
					<div class="form-row" style="text-align: right;">
						<input type="button" onclick="getDates()" class="button green" value="Next">
					</div>
				</div>
			</form>
		</div>
		<div class="box grid_4" id="selectDates" style="display: none;">
			<div class="box-head">
				<h2>Choose At Lease Two Entries to Compare</h2>
			</div>
			<form method="" action="">
				<div class="box-content">
					<div class="form-row">
						<!--  
						<p><%=resb.getString("PLEASE_ENTER_USER_NAME_TO_VIEW")%></p>
						-->
						<p>Please Select At Least Two Entries</p>
					</div>
					<br> <br>
					<div class="form-row">
						<label class="form-label">Dates: </label>
						<div class="form-item">
							<select name="date[]" id="date1" multiple>
							</select>
						</div>
					</div>
					
					<div class="form-row" style="text-align: right;">
						<input type="button" onclick="getCompareGraph()" class="button green" value="Compare">
					</div>
				</div>
			</form>
		</div>
	</div>
		
			<div class="content container_12">
				<div class="box grid_12" style="display: none">

					<div class="box-head">
						<h2>Comparison Result</h2>
					</div>

					<div class="box-content" id="field">

						<div id="divtext1">
							

						</div>
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
	<script>
		////////////////////////////////////////////////
		function getDates() {
			var post = {
					templateName : $("select[name=templateName]").val()
			}
			$.post("AjaxGetTestResultDateForAthlete", post, function(data){
				var datelist = data[0];
				var username = data[1];
				var templateName = data[2];
				var hiddenTemplateName = "<input type='hidden' name='templateName' value='"+  templateName + "' >";
				var hiddenUsername = "<input type='hidden' name='username' value='"+  username + "' >"
				var innerHtml = "";
				for(var i in datelist) {
					//innerHtml = innerHtml + "<input type='checkbox' value='" + datelist[i] + "' name='date1' />" + datelist[i] +"<br>";
					innerHtml = innerHtml + "<option value='"+datelist[i]+"'>" + datelist[i] + "</option>";
				}
				innerHtml = innerHtml + "<option value='average'>Average</option>";
				
				$("#selectDates #date1").html(innerHtml);
				$("#selectDates form").append(hiddenUsername+hiddenTemplateName);
				$("#selectDates").css({display: "block"});
			});
		}
		////////////////////////////////////////////////////
		function getCompareGraph() {
			var a = $("#date1").val();
			if(a.length < 2) {
				alert("Please Select At Least Two Entries!");
				return ;
			}
			var c = a.join("-");
			var post = {
					date1 :c,
					templateName : $("#selectDates input[name=templateName]").val(),
					username : $("#selectDates input[name=username]").val() 
			}
			$.post("TestMultipleSelection",post, function(data) {
				var htmlData = data[0];
				var cgData= data[1];
				$("#divtext1").html(htmlData);
				for(var i in cgData) {
					$("#flot-lines" + cgData[i].tableName).css({'min-height':"200px"});
				}
				$("div .box.grid_12").css({display:"block"});
				newGraph(cgData);
			});
		}
		//****************New Graph Function********************//
		function newGraph(allData) {
			for(var i in allData) {
				var dataArray = [];
				var xvalue = allData[i].xValues;
				var yvalue = allData[i].yValues;
				for(var j in xvalue) {
					var dataEntry = {};
					var points = [];
					var xaxis = xvalue[j];
					var yaxis = yvalue[j];
					for(var m=0; m < xaxis.length; m++) {
						points.push([xaxis[m],yaxis[m]]);
					}
					dataEntry.data = points;
					dataEntry.label = j;
					dataArray.push(dataEntry);
				}
				var plot = $.plot($("#flot-lines" + allData[i].tableName),
			            dataArray , {
			                 series: {
			                     lines: { show: true },
			                     points: { show: true }
			                 },
			                 xaxis: {
			                     axisLabel: allData[i].x,
			                     axisLabelUseCanvas: false,
			                     axisLabelFontSizePixels: 12,
			                     axisLabelPadding: 10
			                 },
			                 yaxis: {
			                     axisLabel: allData[i].y,
			                     axisLabelUseCanvas: false,
			                     axisLabelFontSizePixels: 12,
			                     axisLabelPadding: 10
			                 },
			                 grid: { hoverable: true },
			               });
			      var previousPoint = null;
			      $("#flot-lines" + allData[i].tableName).bind("plothover", function (event, pos, item) {
			          if ($("#enablePosition:checked").length > 0) {
			              var str = "(" + pos.x.toFixed(2) + ", " + pos.y.toFixed(2) + ")";
			              $("#hoverdata").text(str);
			          }
			      });
			}
		}
		//******************************************************//
	</script>
</body>
</html>