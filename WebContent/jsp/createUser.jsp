<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>PeakCentre - Create User Account</title>
<link rel="shortcut icon" href="../image/favicon.png">
<!---CSS Files-->
<link rel="stylesheet" href="../css/master.css">
<!-- <link rel="stylesheet" href="../css/iphone-check.css"> -->
<link href="../js/sh/shThemeDefault.css" rel="stylesheet"
	type="text/css" />
<link href="../js/sh/shCore.css" rel="stylesheet" type="text/css" />
<!---jQuery Files-->
<script src="../js/jquery-1.7.1.min.js"></script>
<script src="../js/jquery-ui-1.8.17.min.js"></script>
<script src="../js/styler.js"></script>
<script src="../js/jquery.tipTip.js"></script>
<script src="../js/colorpicker.js"></script>
<script src="../js/sticky.full.js"></script>
<script src="../js/global.js"></script>
<script src="../js/forms/fileinput.js"></script>
<script src="../js/forms/iphone-check.js"></script>
<script src="../js/forms/jquery.validate.min.js"></script>
<script src="../js/sh/shCore.js" type="text/javascript"></script>
<script src="../js/sh/shBrushXml.js" type="text/javascript"></script>
<!---Fonts-->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700'
	rel='stylesheet' type='text/css'>
</head>
<%
	HttpSession session2 = request.getSession(false); 
	if(session2.getAttribute("id")==null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
    }
%>
<body>

	<%@ include file="./header.jsp" %>
	<!--- CONTENT AREA -->

	<div class="content container_12">
		<div class="ad-notif-success grid_12 small-mg">
			<p>Create User</p>
		</div>
		<div class="box grid_6">
			<div class="box-head">
				<h2>Register User</h2>
			</div>
			<form name="createuser_form" id="createuser_form" method="post"
				action="CreateUserServlet" enctype="multipart/form-data">
				<div class="box-content">
					<div class="form-row">
						<p>* Mandatory Fields</p>
					</div>
					<div class="form-row">
						<div class="form-item">
							<%
								if (request.getAttribute("empty_message") != null) {
							%>
							<p style="color: #ff6666; font-size: 11px"><%=request.getAttribute("empty_message")%></p>
							<%
								}
							%>
						</div>
					</div>

					<div class="form-row">
						<label class="form-label">*Type of User</label>
						<div class="form-item">
							<select name="usertype">
								<option value='Administrator'>Administrator</option>
								<option value='Coach'>Coach</option>
								<option value='Athlete'>Athlete</option>
							</select>
						</div>
					</div>
					<div class="form-row">
						<p class="form-label">*Username</p>
						<div class="form-item">
							<input type="text" id="username" name="username" onkeyup="checkUsername(); return false;" required />
						</div>
					</div>
					<div class="form-row">
						<p class="form-label"></p>
						<div class="form-item" id="confirmUsernameFormat" >
							<%
								if (request.getAttribute("usrname_message") != null) {
							%>
							<p style="color: #ff6666; font-size: 11px"><%=request.getAttribute("usrname_message")%></p>
							<%
								}
							%>
						</div>
					</div>
					<div class="form-row">
						<p class="form-label">*Password</p>
						<div class="form-item">
							<input id="password" type="password" name="password" required />
						</div>
					</div>
					<div class="form-row">
						<p class="form-label">*Re-enter Password</p>
						<div class="form-item">
							<input id="repassword" type="password" name="repassword"
								onkeyup="checkPass(); return false;" required />
						</div>
					</div>
					<div class="form-row">
						<p class="form-label"></p>
						<div class="form-item" id="confirmMessage">
							<%
								if (request.getAttribute("password_message") != null) {
							%>
							<p style="color: #ff6666; font-size: 11px"><%=request.getAttribute("password_message")%></p>
							<%
								}
							%>
						</div>
					</div>
					<div class="form-row">
						<p class="form-label">*First Name</p>
						<div class="form-item">
							<input type="text" name="fname" required />
						</div>
					</div>
					<div class="form-row">
						<p class="form-label">*Last Name</p>
						<div class="form-item">
							<input type="text" name="lname" required />
						</div>
					</div>
					<div class="form-row">
						<label class="form-label">Profile Picture</label>
						<!-- <div class="form-item file-upload">
							<input /> <input class="filebase" type="file" name="uploadFile" />
							<span
								class="form-icon fugue-2 control-eject"></span>
						</div> -->
						<div class="form-item file-upload">
							<input /><input name="pic" class="filebase" type='file'
								id="imgInp" /> <img id="blah" src="#" alt="Preview" height="60"
								width="60" />
						</div>
					</div>
					<div class="form-row">
						<label class="form-label">*Gender</label>
						<div class="form-item">
							<select name="gender">
								<option value='Male'>Male</option>
								<option value='Female'>Female</option>
								<option value='Other'>Other</option>
							</select>
						</div>
					</div>
					<div class="form-row">
						<label class="form-label">Athelete Level</label>
						<div class="form-item">
							<select name="level">
								<option value='Elite'>Elite</option>
								<option value='Competition'>Competition</option>
								<option value='Recreational'>Recreational</option>
								<option value='General Fitness'>General Fitness</option>
							</select>
						</div>
					</div>

					<div class="form-row">
						<label class="form-label">*Date of Birth</label>
						<div class="form-item">
							<input name="dob" type="text" id="datepicker" required />
						</div>
					</div>
					<div class="form-row">
						<p class="form-label">*City</p>
						<div class="form-item">
							<%
								if ("coach".equals(usertype)) {
							%>
							<input type="text" name="city"
								value="<%=session.getAttribute("city")%>" readonly />
							<%
								} else {
							%>
							<input type="text" name="city" required />
							<%
								}
							%>
						</div>
					</div>

					<div class="form-row" style="text-align: right;">
						<input type="button" class="button green" onclick='formSubmit()' value="submit">
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<div id="dialog_name" title="Comfirmation">
		<div>
			<p>Some of your information format not matched, please resubmit</p >
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
		$("#dialog_name").dialog({
			autoOpen : false,
			resizable : false,
			modal : true,
			buttons: {
	            Ok: function() {
	                $( this ).dialog( "close" );
	            }
	        }
		});
	
		$(function() {
			$("#dialog").dialog({
				autoOpen : false,
				resizable : false,
				buttons : {
					Close : function() {
						$(this).dialog("close");
					}
				}
			});

			$("#open-dialog").click(function() {
				$("#dialog").dialog("open");
				return false;
			});

			$("#modal-dialog").dialog({
				autoOpen : false,
				resizable : false,
				modal : true,
				buttons : {
					Close : function() {
						$(this).dialog("close");
					}
				}
			});

			$("#open-modal-dialog").click(function() {
				$("#modal-dialog").dialog("open");
				return false;
			});

			$('#open-notif').click(function() {
				$.sticky('I am a simple notification.')
			});

			$('#open-comp-notif')
					.click(
							function() {
								$
										.sticky('<b>I am a complex notification.</b><br><br><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>')
							});

			SyntaxHighlighter.all()


			$("#datepicker").datepicker({
				showMonthAfterYear : true,
				changeYear : true,
				changeMonth : true,
				numberOfMonths : 1,
				yearRange : "1930:2015"

			});

			$("#colorpicker").ColorPicker();

			function readURL(input) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();

					reader.onload = function(e) {
						$('#blah').attr('src', e.target.result);
					}

					reader.readAsDataURL(input.files[0]);
				}
			}

			$("#imgInp").change(function() {
				readURL(this);
			});

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
		
		function formSubmit() {	
			
			var post = {
					username : $("#createuser_form").find("input[name=username]").val(),
					usertype : $("#createuser_form").find("input[name=usertype]").val(),
			};
			
			$.post('AjaxCheckUsernameRepeat',post, function(data){
				
				console.log("data");
				console.log(data);
				
				if(!data && isUsernameLegal) {
					console.log("here in true")
					document.getElementById('createuser_form').submit();
					//return true;
				} else {
					
				    if(data){
				    	var badColor = "#ff6666";
				    	var message = document.getElementById('confirmUsernameFormat');
				    	message.style.fontSize = "11px";
						message.style.color = badColor;
						message.innerHTML = "The user name already exist, please use another one";
				    }
					console.log("here in false");
					$("#dialog_name").dialog("open");
					//return false;
				}
				
				
			});
		}
		
		function checkUsername() { 
			isUsernameLegal = false;
			var email = document.getElementById("username").value;   
			var message = document.getElementById('confirmUsernameFormat');
			//Set the colors we will be using ...
			var goodColor = "#66cc66";
			var badColor = "#ff6666";
			//Compare the values in the password field 
			//and the confirmation field
			if(!/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(email)) {
				//The passwords match. 
				//Set the color to the good color and inform
				//the user that they have entered the correct password 
				//email.style.backgroundColor = goodColor;
				message.style.fontSize = "11px";
				message.style.color = badColor;
				message.innerHTML = "Format Do not Match!";
			} else {
				//The passwords do not match.
				//Set the color to the bad color and
				//notify the user.
				//email.style.backgroundColor = badColor;
				message.style.fontSize = "11px";
				message.style.color = goodColor;
				message.innerHTML = "Format Match!";
				isUsernameLegal = true;
			}
	    } 
	</script>
</body>
</html>