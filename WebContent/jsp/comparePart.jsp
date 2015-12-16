<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%
	Locale locale = Locale.ENGLISH;
	ResourceBundle resb = ResourceBundle
	.getBundle("peakcentre", locale);
	request.getSession(true).setAttribute("locale", locale);
%>
<div class="box grid_4" id="compareDetail" title="Search First User" style="display: block">
			<div class="box-head">
				<h2>User Profile Search</h2>
			</div>
			<form method="" id="firstUserSearch" action="">
				<div class="box-content">
					<div class="form-row">
						<!-- 
						<p><%=resb.getString("PLEASE_ENTER_USER_NAME_TO_ADD_TEST_RESULT")%></p>
						-->
						<p>First User</p><br>
						<p>Please specify the first name and last name</p>
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
						<div class="form-item" id="errmessage">
						</div>
					</div>
				<% String mode = request.getParameter("mode"); %>
				<% if(mode.equals("1")) {%>
						<div class="form-row">
						<p>Second User</p><br>
						<p>Please specify the first name and last name</p>
						</div>
						<br> <br>
						<div class="form-row">
							<label class="form-label">First Name</label>
							<div class="form-item">
								<input type="text" name="Secondfname" required />
							</div>
						</div>
						<div class="form-row">
							<label class="form-label">Last Name</label>
							<div class="form-item">
								<input type="text" name="Secondlname" required />
							</div>
						</div>
					<div class="form-row">
						<div class="form-item" id="errmessage2">
						</div>
					</div>
				<% }%>
					<input type="hidden" name="templateName" value="<%= request.getParameter("templateName")%>">

					<div class="form-row" style="text-align: right;">
					<% if(mode.equals("1")) {%>
						<input type="button" onclick="getTwoUsers()" class="button green" value="Search">
					<% } else { %> 
						<input type="button" onclick="getFirstUser()" class="button green" value="Search">
					<% } %>
					</div>
				</div>
			</form>
			
		</div>

		<div class="box grid_4"  id="confirmUser" style="display: none">
				<div class="box-head">
					<h2>User Profile</h2>
				</div>
				<form method="" action="">
					<div class="box-content">
						<div class="form-row" id="usernameForm">
							<!-- 
							<p><%=resb.getString("PLEASE_CHOOSE_USER_TO_ADD_TEST_RESULT")%></p>
							 -->
							<p>Please Confirm User</p>
						</div>
						<br>
						<% if(mode.equals("1")) {%>
							<div class="form-row">
							<p>First User</p>
							</div>
						<% } %>
						<div class="form-row">
							<div class="form-item">
								<select name="userlist">
								</select>
							</div>
						</div>
						<% if(mode.equals("1")) {%>
							<div class="form-row">
							<p>Second User</p>
							</div>
							<div class="form-row">
								<div class="form-item">
									<select name="Seconduserlist">
									</select>
								</div>
						</div>
						<% } %>
						<input type="hidden" name="templateName" value="<%= request.getParameter("templateName")%>">
						
						<div class="form-row" style="text-align: right;">
						<% if(mode.equals("1")) {%>
							<input type="button" onclick="getTwoTestResultDates()" class="button green" value="Next">
						<% } else { %>
							<input type="button" onclick="getTestResultDate()" class="button green" value="Next">
						<% } %>
						</div>	
					</div>	
					<br>
				</form>
		</div>
		<div class="box grid_4"  id="selectDates" style="display: none;">
				<div class="box-head">
					<h2>Select Two Entries</h2>
				</div>
				<form method="" action="">
					<div class="box-content">
						<div class="form-row">
							<!-- 
							<p><%=resb.getString("PLEASE_CHOOSE_USER_TO_ADD_TEST_RESULT")%></p>
							 -->
							<p>Please Select At Least Two Entries</p>
						</div>
						<br>
						<% if(mode.equals("1")) {%>
							<div class="form-row">
							<p>First User:</p>
							<p>TestResult Dates:</p>
							</div>
						<% }%>
						<div class="form-row">
							<div class="form-item">
								<select name="date[]"  id ="date1" multiple>
								</select>
							</div>
						</div>
						<% if(mode.equals("1")) {%>
							<div class="form-row">
							<p>Second User:</p>
							<p>TestResult Dates:</p>
							</div>
							<div class="form-row">
							<div class="form-item">
								<select name="date2[]"  id ="date2" multiple>
								</select>
							</div>
						</div>
						<% }%>
						<input type="hidden" name="templateName" value="<%= request.getParameter("templateName")%>">
						<div class="form-row" style="text-align: right;">
						<% if(mode.equals("1")) {%>
							<input type="button" onclick="getTwoComparisonGraphs()" class="button green" value="Compare">
						<% } else {%>
							<input type="button" onclick="getComparisonGraph()" class="button green" value="Compare">
						<% } %>	
						</div>	
					</div>	
					<br>
				</form>
		</div>

<script>
		function getFirstUser() {
			var fname = $("#compareDetail input[name=fname]").val();
			var lname = $("#compareDetail input[name=lname]").val();
			var post = {
				fname: fname,
				lname: lname
			};
			$.post("AjaxSearchUser",post,function(data){
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
					$("#usernameForm").append(hiddenpart);
					document.getElementById("confirmUser").style.display="block";
				} else {
					$("#errmessage").html("<p style='color: #ff6666; font-size: 11px'>"+message+"</p>");
				}
			})
		}
		/***************************Two User********************************/
		function getTwoUsers() {
			var fname = $("#compareDetail input[name=fname]").val();
			var lname = $("#compareDetail input[name=lname]").val();
			var post = {
				fname: fname,
				lname: lname
			};
			var post1 = {
					fname: $("#compareDetail input[name=Secondfname]").val(),
					lname: $("#compareDetail input[name=Secondlname]").val()
			}
			$.post("AjaxSearchUser",post,function(data){
				$.post("AjaxSearchUser",post1,function(data1){
					var message = data[0];
					var list = data[1];
					var message1 = data1[0];
					var list1 = data1[1];
					if(message == "" && message1 == "") {
						var innerHtml = "";
						for(var i in list) {
							innerHtml = innerHtml + "<option value=" + i + ">" + 
							list[i].fname + " " +list[i].lname + " " + list[i].username + " " + list[i].city + "</option>";
						}
						
						var innerHtml1 = "";
						for(var i in list) {
							innerHtml1 = innerHtml1 + "<option value=" + i + ">" + 
							list1[i].fname + " " +list1[i].lname + " " + list1[i].username + " " + list1[i].city + "</option>";
						}
						
						var hiddenpart = "<input name='fname' type='hidden' value='" + list[0].fname + "' >" +
						"<input name='lname' type='hidden' value='" + list[0].lname + "' >";
						hiddenpart += "<input name='Secondfname' type='hidden' value='" + list1[0].fname + "' >" +
						"<input name='Secondlname' type='hidden' value='" + list1[0].lname + "' >"
						console.log("InnerHTML : " + innerHtml);
						$("select[name=userlist]").html(innerHtml);
						$("select[name=Seconduserlist]").html(innerHtml1);
						$("#usernameForm").append(hiddenpart);
						document.getElementById("confirmUser").style.display="block";
					} else {
						if(message != "") {
							$("#errmessage").html("<p style='color: #ff6666; font-size: 11px'>"+message+"</p>");
						}
						if(message1 != "") {
							$("#errmessage2").html("<p style='color: #ff6666; font-size: 11px'>"+message1+"</p>");
						}
					}
				})
			})
		}
		/*******************************************************************/
		/*******************************************************************/
		function getTestResultDate() {
			var post = {
					templateName : $("input[name=templateName]").val(),
					fname : $("input[name=fname]").val(),
					lname : $("input[name=lname]").val(),
					userlist : $("select[name=userlist]").val()
			};
			console.log(post);
			$.post("AjaxGetTestResultDate",post,function(data){
				var datelist = data[0];
				var username = data[1];
				var hiddenUsername = "<input type='hidden' name='username' value='"+  username + "' >"
				var innerHtml = "";
				for(var i in datelist) {
					//innerHtml = innerHtml + "<input type='checkbox' value='" + datelist[i] + "' name='date1' />" + datelist[i] +"<br>";
					innerHtml = innerHtml + "<option value='"+datelist[i]+"'>" + datelist[i] + "</option>";
				}
				innerHtml = innerHtml + "<option value='average'>Average</option>";
				
				$("#selectDates #date1").html(innerHtml);
				$("#selectDates form").append(hiddenUsername);
				$("#selectDates").css({display: "block"});
			});
		}
		/***************************Two User********************************/
		function getTwoTestResultDates() {
			var post = {
					templateName : $("input[name=templateName]").val(),
					fname : $("input[name=fname]").val(),
					lname : $("input[name=lname]").val(),
					userlist : $("select[name=userlist]").val()
			};
			var post1 = {
					templateName : $("input[name=templateName]").val(),
					fname : $("input[name=Secondfname]").val(),
					lname : $("input[name=Secondlname]").val(),
					userlist : $("select[name=Seconduserlist]").val()
			};
			$.post("AjaxGetTestResultDate",post,function(data){
				$.post("AjaxGetTestResultDate",post1,function(data1){
					var datelist = data[0];
					var username = data[1];
					var datelist1 = data1[0];
					var username1 = data1[1];
					var hiddenUsername = "<input type='hidden' name='username' value='"+  username + "' >";
					hiddenUsername += "<input type='hidden' name='Secondusername' value='"+  username1 + "' >";
					var innerHtml = "";
					for(var i in datelist) {
						innerHtml = innerHtml + "<option value='"+datelist[i]+"'>" + datelist[i] + "</option>";
					}
					innerHtml = innerHtml + "<option value='average'>Average</option>";
					var innerHtml1 = "";
					for(var i in datelist1) {
						innerHtml1 = innerHtml1 + "<option value='"+datelist1[i]+"'>" + datelist1[i] + "</option>";
					}
					innerHtml1 = innerHtml1 + "<option value='average'>Average</option>";
					
					$("#selectDates #date1").html(innerHtml);
					$("#selectDates #date2").html(innerHtml1);
					$("#selectDates form").append(hiddenUsername);
					$("#selectDates").css({display: "block"});
				});
			});
		}
		/*******************************************************************/
		function getComparisonGraph() {
			var a = $("#date1").val();
			if(a.length < 2 || a.length == null) {
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
		/***************************Two User********************************/
		function getTwoComparisonGraphs() {
			var a = $("#date1").val();
			if(a == "") {
				alert("Please select!");
				return false;
			}
			var c = a.join("-");
			var post = {
					date1 :c,
					templateName : $("#selectDates input[name=templateName]").val(),
					username : $("#selectDates input[name=username]").val() 
			}
			var a1 = $("#date2").val();
			var c1 = a1.join("-");
			var post1 = {
					date1 :c1,
					templateName : $("#selectDates input[name=templateName]").val(),
					username : $("#selectDates input[name=Secondusername]").val() 
			}
			$.post("TestMultipleSelection",post, function(data) {
				$.post("TestMultipleSelection",post1, function(data1) {
					var htmlData = data[0];
					var cgData= data[1];
					var cgData1 = data1[1];
					$("#divtext1").html(htmlData);
					for(var i in cgData) {
						$("#flot-lines" + cgData[i].tableName).css({'min-height':"200px"});
					}
					$("div .box.grid_12").css({display:"block"});
					newTwoGraphs(cgData, post.username, cgData1, post1.username);
				});
			});
		}
		function newTwoGraphs(cgData1,username1, cgData2, username2) {
			for(var i in cgData1) {
				var dataArray = [];
				var xvalue = cgData1[i].xValues;
				var yvalue = cgData1[i].yValues;
				for(var j in xvalue) {
					var dataEntry = {};
					var points = [];
					var xaxis = xvalue[j];
					var yaxis = yvalue[j];
					for(var m=0; m < xaxis.length; m++) {
						points.push([xaxis[m],yaxis[m]]);
						console.log("cg1: " + xaxis[m] + "," + yaxis[m]);
					}
					console.log("*****"+ j + "*********");
					dataEntry.data = points;
					dataEntry.label =  "First User:" + j;
					dataArray.push(dataEntry);
				}
				var xvalue = cgData2[i].xValues;
				var yvalue = cgData2[i].yValues;
				for(var j in xvalue) {
					var dataEntry = {};
					var points = [];
					var xaxis = xvalue[j];
					var yaxis = yvalue[j];
					for(var m=0; m < xaxis.length; m++) {
						points.push([xaxis[m],yaxis[m]]);
					}
					dataEntry.data = points;
					dataEntry.label = "Second User:" + j;
					dataArray.push(dataEntry);
				}
				var plot = $.plot($("#flot-lines" + cgData1[i].tableName),
			            dataArray , {
			                 series: {
			                     lines: { show: true },
			                     points: { show: true }
			                 },
			                 xaxis: {
			                     axisLabel: cgData1[i].x,
			                     axisLabelUseCanvas: false,
			                     axisLabelFontSizePixels: 12,
			                     axisLabelPadding: 10
			                 },
			                 yaxis: {
			                     axisLabel: cgData1[i].y,
			                     axisLabelUseCanvas: false,
			                     axisLabelFontSizePixels: 12,
			                     axisLabelPadding: 10
			                 },
			                 grid: { hoverable: true },
			               });
			      var previousPoint = null;
			      $("#flot-lines" + cgData1[i].tableName).bind("plothover", function (event, pos, item) {
			          if ($("#enablePosition:checked").length > 0) {
			              var str = "(" + pos.x.toFixed(2) + ", " + pos.y.toFixed(2) + ")";
			              $("#hoverdata").text(str);
			          }
			      });
			}
		}
		/*******************************************************************/
</script>