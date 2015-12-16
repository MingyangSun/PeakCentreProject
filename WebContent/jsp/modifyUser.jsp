<!doctype html>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.peakcentre.web.entity.Userinfo"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - Modify User Account</title>
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
			<p>Modify User Information</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>User Profile Search</h2>
			</div>
			<form id="searchuser_form" method="post" action="">
				<input type="hidden" value="modify" name="page" />
				<div class="box-content">
					<div class="form-row">
						<p><%=resb.getString("PLEASE_ENTER_USER_NAME")%></p>
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
							<%
								if (request.getAttribute("message") != null) {
							%>
							<p style="color: #ff6666; font-size: 11px"><%=request.getAttribute("message")%></p>
							<%
								}
							%>
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
				<form id="confirmuser_form" method="post"
					action="">
					<div class="box-content">
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_USER")%></p>
						</div>
						<br>
						<div class="form-row">
							<div class="form-item" id="hiddenpart">
								<select name="userlist">

								</select>

							</div>
						</div>
						<div class="form-row" style="text-align: right;">
							<input type="button" id="userConfirm" class="button green" value="ok">
						</div>
					</div>
				</form>
			</div>
			<div class="box grid_12"></div>

				<div class="box grid_6" id="userInformation" style="display: none">

					<div class="box-head">
						<h2>User Information</h2>
					</div>
					<form id="modifyuser_form" method="post" action="ModifyUserServlet"
						enctype="multipart/form-data">

						<div class="box-content">

						</div>
					</form>
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
//---------------------------------------------------------------------------------//
$("#userProfileSearch").click(function(){
	$("#errmessage").html("");
	var post = {
		page: $("#searchuser_form").find("input[name=page]").val(),
		lname: $("#searchuser_form").find("input[name=lname]").val(),
		fname: $("#searchuser_form").find("input[name=fname]").val()
	};
	console.log(post.lname);
	console.log(post.fname);
	$.post('AjaxSearchUser',post,function(data){
		var message = data[0];
		var list = data[1];
		if(message == "") {
			var innerHtml = "";
			var hiddenPart = "<input type='hidden' name='fname' value='" + list[0].fname + "' >" + 
			"<input type='hidden' name='lname' value='" + list[0].lname + "'>";
			for(var i in list) {
				innerHtml = innerHtml + "<option value='" + i + "' >" + list[i].fname + " " + list[i].lname + 
				" " + list[i].username + " " + list[i].city + " </option>";
			}
			$("#confirmUser").find("select[name=userlist]").html(innerHtml);
			$("#hiddenpart").append(hiddenPart);
			$("#confirmUser").css({display:'block'});
		} else {
			$("#errmessage").html("<p style=\"color: #ff6666; font-size: 11px\">" + message +"</p>");
		}
	});
});
$("#userConfirm").click(function(){
	var post = {
			userlist: $("#confirmUser").find("select[name=userlist]").val(),
			lname: $("#confirmUser").find("input[name=lname]").val(),
			fname: $("#confirmUser").find("input[name=fname]").val()
	};
	$.post('AjaxConfirmUser',post,function(data){
		console.log(data);
		var innerHtml="";
		var idPart = "<input name='id' type='hidden' value='" + data.id +"' >";
		var usertypePart = "<div class='form-row'><label class='form-label'>Type of User</label>" +
		"<div class='form-item'><select name='usertype'>"+ setUserTypeHtmlElement(data.usertype) +
		"</select></div></div>";
		
		var usernamePart = "<div class='form-row'><p class='form-label'>Username</p><div class='form-item'>" +
		"<input type='text' name='username' required value='" + data.username +"' readonly ></div></div>";
		
		var passwordPart = "<div class='form-row'><p class='form-label'>Password</p><div class='form-item'>" +
		"<input id='password' type='password' name='password' required value='" + data.password + "' ></div></div>" +
		"<div class='form-row'><p class='form-label'>Re-enter Password</p></div class='form-item'>" +
		"<input id='repassword' type='password' name='repassword' required value='" + data.password + "' onkeyup='checkPass();return false;' ></div></div>";
		
		var flnamePart = "<div class='form-row'><p class='form-label'>First Name</p><div class='form-item'>" +
		"<input type='text' name='fname' required value='" + data.fname +"' ></div></div>" +
		"<div class='form-row'><p class='form-label'>Last Name</p><div class='form-item'>" +
		"<input type='text' name='lname' required value='" + data.lname +"' ></div></div>";
		
		var picturePart = "<div class='form-row'><label class='form-label'>Profile Picture</label><div class='form-item file-upload'>" +
		"<input value='Select a file to change...' /><input name='pic' class='filebase' type='file' id='ImgInp' />" +
		"<img id='blah' src='http://localhost:8080/PeakCentreProject/pic/" + data.picpath + ".jpg' alt='Preview' height='60' width='60' /></div></div>";
		
		var genderPart = "<div class='form-row'><label class='form-label'>Gender</label><div class='form-item'>"+
		"<select name='gender'>" +setGenderHtmlElement(data.gender)+ "</select></div></div>";
		
		var levelPart = "<div class='form-row'><label class='form-label'>Athelete Level</label><div class='form-item'>" +
		"<select name='level'>" +setLevelHtmlElement(data.level) +"</select></div></div>";
		
		var dobPart="<div class='form-row'><label class='form-label'>Date of Birth</label><div class='form-item'>" +
		"<input type='text' id='datepicker' name='dob' required value='" + data.dob +"' ></div></div>";
		
		var cityPart = "<div class='form-row'><label class='form-label'>Gender</label><div class='form-item'>" +
		"<input type='text' name='city' required value='" + data.city +"'></div></div>";
		
		var submitButton="<div class='form-row' style='text-align:right;'><input type='submit' class='button green' value='submit'></div>";
		
		innerHtml = innerHtml + idPart + usertypePart + usernamePart + passwordPart + flnamePart +
		picturePart + genderPart + levelPart + dobPart + cityPart + submitButton;
		//console.log(innerHtml);
		$('#userInformation').find(".box-content").html(innerHtml);
		$("#userInformation").css({display:'block'});
		$(function() {
			$("#datepicker").datepicker({
				showMonthAfterYear : true,
				changeYear : true,
				changeMonth : true,
				numberOfMonths : 1,
				yearRange : "1930:2015"

			});
		});
	});
});
var setLevelHtmlElement=function(level) {
	var s1="<option value='Elite'>Elite</option>";
	var s2="<option value='Competition'>Competition</option>";
	var s3="<option value='Recreational'>Recreational</option>";
	var s4="<option value='General Fitness'>General Fitness</option>";
	if(level == "Elite") {
		return "<option value='Elite' selected='selected'>Elite</option>" +s2+s3+s4;
	}
	if(level == "Competition") {
		return s1+"<option value='Competition' selected='selected'>Competition</option>"+s3+s4
	}
	if(level == "Recreational") {
		return s1+s2+"<option value='Recreational' selected='selected'>Recreational</option>"+s4;
	}
	return s1+s2+s3+"<option value='General Fitness' selected='selected'>General Fitness</option>";
};
var setGenderHtmlElement=function(gender) {
	var s1 = "<option value='Male'>Male</option>";
	var s2 = "<option value='Female'>Female</option>";
	var s3 = "<option value='Other'>Other</option>";
	if(gender == "Male") {
		return "<option value='Male' selected='selected'>Male</option>"+s2+s3;
	}
	if(gender == "Female") {
		return s1+"<option value='Female' selected='selected'>Female</option>"+s3;
	}
	return s1+s2+"<option value='Other' selected='selected'>Other</option>";
};
var setUserTypeHtmlElement=function(usertype) {
	var s1 = "<option value='Administrator' >Administrator</option>";
	var s2 = "<option value='Coach' >Coach</option>";
	var s3 = "<option value='Athlete' >Athlete</option>";
	if(usertype == "Administrator") {
		return "<option selected='selected' value='Administrator' >Administrator</option>"+s2+s3;
	}
	if(usertype == "Coach") {
		return s1+"<option selected='selected' value='Coach' >Coach</option>"+s3;
	}
	return s1+s2+"<option selected='selected' value='Athlete' >Athlete</option>";
};
//---------------------------------------------------------------------------------//
				function readURL(input) {
					if (input.files && input.files[0]) {
						var reader = new FileReader();

						reader.onload = function(e) {
							$('#blah').attr('src', e.target.result);
						};

						reader.readAsDataURL(input.files[0]);
					}
				}

				$("#imgInp").change(function() {
					readURL(this);
				});



				function checkPass() {
					//Store the password field objects into variables ...
					var pass1 = document.getElementById('password');
					var pass2 = document.getElementById('repassword');
					//Store the Confimation Message Object ...
					var message = document.getElementById('confirmMessage');
					//Set the colors we will be using ...
					var goodColor = "#66cc66";
					var badColor = "#ff6666";
					//Compare the values in the password field 
					//and the confirmation field
					if (pass1.value == pass2.value) {
						//The passwords match. 
						//Set the color to the good color and inform
						//the user that they have entered the correct password 
						pass2.style.backgroundColor = goodColor;
						message.style.fontSize = "11px";
						message.style.color = goodColor;
						message.innerHTML = "Passwords Match!";
					} else {
						//The passwords do not match.
						//Set the color to the bad color and
						//notify the user.
						pass2.style.backgroundColor = badColor;
						message.style.fontSize = "11px";
						message.style.color = badColor;
						message.innerHTML = "Passwords Do Not Match!";
					}
				}
			</script>
</body>
</html>