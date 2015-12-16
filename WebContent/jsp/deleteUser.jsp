<!doctype html>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.peakcentre.web.entity.Userinfo"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - Delete User Account</title>
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
			<p>Delete User</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>User Profile Search</h2>
			</div>
			<form method="post" action="">
				<input type="hidden" value="delete" name="page" />
				<div class="box-content">
					<div class="form-row">
						<p><%=resb.getString("PLEASE_ENTER_USER_NAME_TO_DELETE")%></p>
					</div>
					<br><br>
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
						<div class="form-item" id="errmessage">

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
				<form id="deleteUser_form" method="post" action="DeleteUserServlet">
					<div class="box-content">
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_USER_TO_DELETE")%></p>
						</div>
						<br>
						<div class="form-row">
							<div class="form-item" id="hiddenPart">
								<select name="userlist">

								</select>

							</div>
						</div>
						<div class="form-row" style="text-align: right;">
							<input type="button" class="button green" id="open-dialog"
								value="delete">
						</div>
					</div>

				</form>
			</div>
		</div>
	</div>

	<div id="dialog" title="Comfirmation">
		<div>
			<p><%=resb.getString("SURE_TO_DELETE")%></p>
		</div>
		<div class="form-row" style="text-align: left;">
			<input type="button" class="button green" value="yes"
				onclick="del();"> 
				<input type="button" class="button green"
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
			console.log(data);
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
				console.log("InnerHTML : " + innerHtml);
				$("select[name=userlist]").html(innerHtml);
				$("#hiddenPart").append(hiddenpart);
				$("#confirmUser").css({display:'block'});
				//document.getElementById("userProfile").style.display="block";
			} else {
				$("#errmessage").html("<p style='color: #ff6666; font-size: 11px'>"+message+"</p>");
				$("input[name=fname]").val("");
				$("input[name=lname]").val("");
			}
		});
	});
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
			document.getElementById("deleteUser_form").submit();
			$("#dialog").dialog("close");
		}
	</script>
</body>
</html>