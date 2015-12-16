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
					
					<div class="form-row">
						<label class="form-label">Compare Mode</label>
						<div class="form-item">
							<select name="compareMode">
								<option value=0>Compare Same User</option>
								<option value=1>Compare Different Users</option>
							</select>
						</div>
					</div>
					<div class="form-row" style="text-align: right;">
						<input type="button" onclick="getTNameAndMode()" class="button green" value="Next">
					</div>
				</div>
			</form>
		</div>
	</div>
<div class="content container_12">
	<div class="box grid_12" style="display: block" id = "ComparePart">
		
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
		function getTNameAndMode() {
			var templateName = $("select[name=templateName]").val();
			var compareMode = $("select[name=compareMode]").val();
			if(compareMode == 0) {
				templateName = templateName.replace(" ","+");
				$("#ComparePart").load("comparePart.jsp?mode=0&templateName="+templateName);
			} else {
				//ajax load another jsp
				$("#ComparePart").load("comparePart.jsp?mode=1&templateName="+templateName);
			}
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