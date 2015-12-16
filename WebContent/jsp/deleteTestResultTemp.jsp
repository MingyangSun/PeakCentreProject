<!doctype html>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="com.peakcentre.web.entity.*"%>
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.peakcentre.web.dao.TestResultTemplateDao"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - Delete Test Result Template</title>
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
			<p>Delete Test Result Template</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>Template Information</h2>
			</div>
			<form id="deleteTemplate_form" method="post"
				action="DeleteTemplateServlet">
				<div class="box-content">
					<div class="form-row">
						<p><%=resb.getString("PLEASE_CHOOSE_TEMPLATE_NAME_TO_DELETE")%></p>
					</div>
					<br>
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
						<input type="button" id="open-dialog" class="button green"
							value="delete">
					</div>
				</div>
			</form>
		</div>
	</div>
	<div id="dialog" title="Comfirmation">
		<div>
			<p>Are you sure you want to delete this template?</p>
		</div>
		<div class="form-row" style="text-align: left;">
			<input type="button" class="button green" value="yes"
				onclick="del();"> <input type="button" class="button green"
				value="no"
				onclick="$(this).closest('.ui-dialog-content').dialog('close');" />

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
		$("#dialog").dialog({
			autoOpen : false,
			resizable : false,
			modal : true
		});

		$("#open-dialog").click(function() {
			$("#dialog").dialog("open");
			return false;
		});
		function del() {
			document.getElementById("deleteTemplate_form").submit();
			$("#dialog").dialog("close");
		}
	</script>


</body>
</html>