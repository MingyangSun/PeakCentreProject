<!doctype html>
<%@page import="com.peakcentre.web.dao.CoachAthletesDao"%>
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
if(session2.getAttribute("username")==null){
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

	<!--- HEADER -->
	<%@ include file="header.jsp"%>
	
	<!--- CONTENT AREA -->
	<div class="content container_12">

		<!-- header of this page -->
		<div class="ad-notif-success grid_12 small-mg">
			<p>Manage My Athletes</p>
		</div>

		<!-- search grid -->
		<div class="box grid_4">
			<div class="box-head">
				<h2>User Profile Search</h2>
			</div>
			<form method="post" action="">
				<input type="hidden" value="addRelationship" name="page" />
				<div class="box-content">
					<div class="form-row">
						<p>Click to add to your athlete list</p>
					</div>
					<br>
					<br>
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
						<input type="button" id="userProfileSearch" class="button green"
							value="search">
					</div>
				</div>
			</form>
		</div>
		
		<!-- show users found -->
		<%
			if(request.getAttribute("list") != null){
		%>
		<div class="box grid_4" id="confirmUser" title="User Selection">
			<%
				}else{
			%>
			<div class="box grid_4" id="confirmUser" title="User Selection"
				style="display: none">
				<%
					}
				%>

				<div class="box-head">
					<h2>User Profile</h2>
				</div>
				<form id="addAthlete_form" method="post" action="AddAthleteServlet">
					<div class="box-content">
						<div class="form-row">
							<p>You can click add button to add this athlete to your list.</p>
						</div>
						<br>
						<div class="form-row">
							<div class="form-item" id="hiddenPart">
								<select name="userlist">
									<%
										if (request.getAttribute("list") != null) {
											int i=0;
											ArrayList<Userinfo> list = (ArrayList<Userinfo>)request.getAttribute("list");
											for (Userinfo ui : list) {
									%>
									<option value=<%=i++%>><p><%=ui.getFname()%>&nbsp;<%=ui.getLname()%>&nbsp;&nbsp;<%=ui.getUsername()%>&nbsp;&nbsp;<%=ui.getCity()%></p>
									</option>

									<%
										}}
									%>
								</select>
								<%
									if (request.getAttribute("list") != null) {
										int i=0;
										ArrayList<Userinfo> list = (ArrayList<Userinfo>)request.getAttribute("list");
								%>
								<input name="fname" type="hidden"
									value=<%=list.get(0).getFname()%> /> <input name="lname"
									type="hidden" value=<%=list.get(0).getLname()%> />
								<%
									}
								%>
							</div>
						</div>
						<div class="form-row" style="text-align: right;">
							<input type="button" class="button green" id="open-dialog"
								value="ADD TO LIST">
						</div>
					</div>

				</form>
			</div>
			</div>

		<!-- athletes table -->
		<div class="box grid_4">
			<div class="box-head">
				<h2>All my athletes</h2>
			</div>
			<div class="box-content">
				<div class="form-row">
					<p>You can manage your athletes by clicking 'delete'.</p>
				</div>
				<br>
				<form id="showMyAthletes_form" method="get" action="">
					<br>
					<%
						CoachAthletesDao caDao = new CoachAthletesDao();
						int pageSize = 3;//每页显示的记录  
						int totalpages = caDao.getTotalPage(pageSize, session.getAttribute("username").toString()) - 1; //最大页数  
						String currentPage = request.getParameter("pageIndex"); //获得当前的页数，即第几页  
						if (currentPage == null) {
							currentPage = "0";
						}
						int pageIndex = Integer.parseInt(currentPage);
						//添加逻辑判断，防止页数异常  
						if (pageIndex < 0) {
							pageIndex = 0;
						} else if (pageIndex > totalpages) {
							pageIndex = totalpages;
						}
						ArrayList<Userinfo> athList = caDao.getAllathByPage(session.getAttribute("username").toString(), pageSize,
								pageIndex); //返回特定页数的数据
					%>
					<!-- 循环显示员工的数据 -->
					<table id = "showAths" border="1">
						
							<tr space = "10">
								<td align="center">Username</td>
								<td align="center">First name</td>
								<td align="center">Last name</td>
								<td align="center">Gender</td>
								<td align="center">City</td>
								<td align="center">Level</td>
								<td align="center">Manage Athlete</td>
							</tr>

						


						<tbody id = "showAthsBody">
							<%
							if(athList!= null &&  athList.size() > 0){
								for (Userinfo temAth : athList) {
							%>
							<tr id=<%=temAth.getId()%>>
								<td><%=temAth.getUsername()%></td>
								<td><%=temAth.getFname()%></td>
								<td><%=temAth.getLname()%></td>
								<td><%=temAth.getGender()%></td>
								<td><%=temAth.getCity()%></td>
								<td><%=temAth.getLevel()%></td>
								<td>
									<div class="form-row" style="text-align: right;">
										<input type="button" class="button green" onclick="delMyRow('<%=temAth.getUsername()%>')" value="delete">
									</div>

								</td>
							</tr>
							<%
								}
							}
							%>
						</tbody>

					</table>

					<br> <br>
					<div align="right">

						<a href="useraccountManageAthlete.jsp?pageIndex=0">First</a> <a
							href="useraccountManageAthlete.jsp?pageIndex=<%=pageIndex - 1%>">Previous</a>
						<a href="useraccountManageAthlete.jsp?pageIndex=<%=pageIndex + 1%>">Next</a>
						<a href="useraccountManageAthlete.jsp?pageIndex=<%=totalpages%>">Last</a> <br>

						<p style="color: Green">
							Current page:<%=pageIndex + 1%></p>
						<br>
						<p style="color: Green">
							Total page:<%=totalpages + 1%></p>
						<br> <br>

						<p id = "showTextForDeletedAth">	</p>
						<br> <br>
					</div>
				</form>
			</div>
		</div>


		<div class="footer">
			<p>© Peak Centre. All rights reserved.</p>
		</div>
		
			<div id="dialog" title="Comfirmation">
		<div>
			<p>Do you want to add this athlete to your list?</p>
		</div>
		<div class="form-row" style="text-align: left;">
			<input type="button" class="button green" value="yes"
				onclick="del();"> 
				<input type="button" class="button green"
				value="no"
				onclick="$(this).closest('.ui-dialog-content').dialog('close');" />

		</div>
	</div>


		<script>
			$('#userProfileSearch')
					.click(
							function() {
								$("#errmessage").html("");
						
								var post = {
									fname : $("input[name=fname]").val(),
									lname : $("input[name=lname]").val(),
			
								};
								console.log("fname : " + post.fname);
								console.log("lanme : " + post.lname);
								$
										.post(
												'AjaxSearchUser',
												post,
												function(data) {
													console.log(data);
													var message = data[0];
													var list = data[1];
													if (message == "") {
														var innerHtml = "";
														for ( var i in list) {
															innerHtml = innerHtml
																	+ "<option value=" + i + ">"
																	+ list[i].fname
																	+ " "
																	+ list[i].lname
																	+ " "
																	+ list[i].username
																	+ " "
																	+ list[i].city
																	+ "</option>";
														}
														var hiddenpart = "<input name='fname' type='hidden' value='" + list[0].fname + "' >"
																+ "<input name='lname' type='hidden' value='" + list[0].lname + "' >";
														console
																.log("InnerHTML : "
																		+ innerHtml);
														$(
																"select[name=userlist]")
																.html(innerHtml);
														$("#hiddenPart")
																.append(
																		hiddenpart);
														$("#confirmUser").css({
															display : 'block'
														});
														//document.getElementById("userProfile").style.display="block";
													} else {
														$("#errmessage")
																.html(
																		"<p style='color: #ff6666; font-size: 11px'>"
																				+ message
																				+ "</p>");
														$("input[name=fname]")
																.val("");
														$("input[name=lname]")
																.val("");
													}
												});
							});
			
			
			function delMyRow(j) {
				$("#errmessage").html("");
				var tempPageindex = getParameter("pageIndex") == null ? 1 : getParameter("pageIndex");
				var post = {
						athUsername : j,
						pageindex : tempPageindex
				}
				
				$.post('AjaxDeleteMyAthlete',post, function(data){
					console.log(data);
					var message = data[0];
					var list = data[1];
					if(message == "") {
						$("#showAthsBody").html("");
						var totalTable = document.getElementById("showAths");
						var tableBody = document.getElementById("showAthsBody");
						
						
						for(var i in list) {
							var mytr = tableBody.insertRow();
							var mytd_0=mytr.insertCell();   
			                var mytd_1=mytr.insertCell();   
			                var mytd_2=mytr.insertCell();   
			                var mytd_3=mytr.insertCell();  
							var mytd_4=mytr.insertCell(); 
							var mytd_5=mytr.insertCell(); 
							var mytd_6=mytr.insertCell(); 

							mytd_0.innerHTML= list[i].username; 
							mytd_1.innerHTML= list[i].fname;
							mytd_2.innerHTML= list[i].lname;
							mytd_3.innerHTML= list[i].gender;
							mytd_4.innerHTML= list[i].city;
							mytd_5.innerHTML= list[i].level;
							mytd_6.innerHTML= "<td><div class=\"form-row\" style=\"text-align: right;\">"
											+ "<input type='button' value='delete' class='button green' onclick=\"delMyRow('"+list[i].username+"')\"></div></td>"
						}
						
						var alertText = document.getElementById("showTextForDeletedAth");
						alertText.innerHTML="The athlete is deleted from your list!";
						alertText.style.color="red"
						window.location.reload();
						
					} else {
						$("#errmessage").html("<p style='color: #ff6666; font-size: 11px'>"+message+"</p>");
					}
					
				})
			};
			
			function getParameter( val ) {
			    var re = new RegExp (val + "=([^&#]*)","i")
			    var a = re.exec(location.href)
			    if ( a == null )
			        return null;
			    return decodeURI(a[1]);
			};
			
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
				document.getElementById("addAthlete_form").submit();
				$("#dialog").dialog("close");
			}
		
		</script>