<!doctype html>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - Create Test Result Template</title>
<link rel="shortcut icon" href="../image/favicon.png">
<!---CSS Files-->
<link rel="stylesheet" href="../css/master.css">
<link rel="stylesheet" href="../css/tables.css">
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
			<p>Create Test Result Template</p>
		</div>
		<div class="box grid_5">
			<div class="box-head">
				<h2>Template Name</h2>
			</div>
			<form method="post" action="">
				<div class="box-content">
					<div class="form-row">
						<p><%=resb.getString("PLEASE_ENTER_TEMPLATE_NAME")%></p>
					</div>
					<br>
					<div class="form-row">
						<p class="form-label">Template Name</p>
						<div class="form-item">

							<input type="text" name="templateName" required />
							</div>
							</div>
							<div class="form-row">
								<p class="form-label">Template Name Alias</p>
								<div class="form-item">
							<input type="text" name="templateNameAlias" required />

						</div>
					</div>
					<div class="form-row">
						<div class="form-item" id = "errmessage">
						</div>
					</div>
					<div class="form-row" style="text-align: right;">
						<input id="checkTemplateName" type="button" class="button green" value="start">
					</div>
				</div>
			</form>
		</div>

			<div class="box grid_4" style="display: none">

				<div class="box-head">
					<h2>Template Element</h2>
				</div>
				<div class="box-content">
					<div class="form-row">
						<p><%=resb.getString("PLEASE_CHOOSE_ELEMENT_TO_ADD")%></p>
					</div>
					<br>
					<div class="form-row" style="text-align: left;">
						<input type="button" id="open-dialog" class="button green"
							value="Add Table"> <input type="button"
							class="button green" value="Add Text" onclick="addText()"
							id="addText"> <input type="button" id="open-dialog2"
							class="button green" value="Add Graph">
					</div>
				</div>
			</div>

				<div class="box grid_12" style="display: none">

					<div class="box-head">
						<h2>Template Content</h2>
					</div>
					<form method="post" action="SaveTemplateServlet"
						onsubmit="return validateEmpty();">
						<div class="box-content" id="field"></div>
						<div class="form-row">
							<div class="form-item" id="errorMessage3"></div>
						</div>
						<input type="hidden" id="divNumber" name="divNumber"> <input
							type="hidden" id="tableNumber" name="tableNumber"> <input
							type="hidden" id="graphNumber" name="graphNumber"> <input
							type="hidden" id="textNumber" name="textNumber">
						<div class="form-row" style="text-align: right;">
							<input type="submit" id="save" class="button green"
								value="save template" disabled>
						</div>
					</form>
				</div>
			</div>

			<div id="dialog" title="Input Row and Column">
				<div class="form-row">
					<label class="form-label">Column</label>
					<div class="form-item">
						<input type="text" name="column" id="column" required />
						<input type="hidden" name="row" id="row" value="1" >
					</div>
				</div>
				<div class="form-row">
					<div class="form-item" id="errorMessage1"></div>
				</div>
				<div class="form-row" style="text-align: right;">
					<input type="button" class="button green" value="close"
						onclick="$(this).closest('.ui-dialog-content').dialog('close');" />
					<input type="button" id="" class="button green"
						value="generate table" onclick="generateTable()">
				</div>
			</div>
			<div id="dialog2" title="Input the column number you want to compare">
				<div class="form-row">
					<p class="form-label">Table ID</p>
					<div class="form-item">
						<input type="text" name="tn1" id="tn1" />
					</div>
				</div>
				<div class="form-row">
					<p class="form-label">X Axis</p>
					<div class="form-item">
						<input type="text" name="cn1" id="cn1" placeholder="Column Number..."/>
					</div>
				</div>
				<!-- <div class="form-row">
					<p class="form-label">Table Number 2</p>
					<div class="form-item">
						<input type="text" name="tn2" id="tn2" />
					</div>
				</div> -->
				<div class="form-row">
					<p class="form-label">Y Axis</p>
					<div class="form-item">
						<input type="text" name="cn2" id="cn2" placeholder="Column Number..."/>
					</div>
				</div>
				<div class="form-row">
					<div class="form-item" id="errorMessage2"></div>
				</div>
				<div class="form-row" style="text-align: right;">
					<input type="button" class="button green" value="close"
						onclick="$(this).closest('.ui-dialog-content').dialog('close');">
					<input type="button" class="button green" value="generate graph"
						onclick="generateGraph()">
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
			<script type="text/javascript"
				src="https://www.google.com/jsapi?autoload={
            'modules':[{
              'name':'visualization',
              'version':'1',
              'packages':['corechart']
            }]
          }"></script>

			<script>
			/*--------------------------------------------------------------------*/
			$("#checkTemplateName").click(function() {
				var post = {};
				post.templateName = $("input[name=templateName]").val();
				post.templateNameAlias = $("input[name=templateNameAlias]").val();
				$.post("AjaxCheckTemplateName", post, function(data){
					var message = data;
					if(message == "") {
						console.log("here");
						$("div.box").css({display:"block"});
					} else {
						$("#errmessage").html("<p style=\"color: #ff6666; font-size: 11px\">"+message+"</p>");
						$("input[name=templateName]").val("");
					}
				});
			});
			/*--------------------------------------------------------------------*/
				var i = 1;//for all div
				var t = 1;//for table number
				var x = 1;//for text number
				var g = 1;//for graph number

				//add text element
				function addText() {
					document.getElementById("save").disabled = false;

					var text = '<div id="divtext'+ i+'"><textarea required class="display" rows="6" id="text' + x + '" name="text' + i + '">'
							+ '</textarea>'
							+ '<input type="hidden" name="'+i+'" value="text">'
							+ '<input type="button" class="small button green" value="delete" onclick="del(this)"/></div>';
					var subdiv = document.createElement("div");
					subdiv.innerHTML = text;
					document.getElementById("field").appendChild(subdiv);
					document.getElementById("divNumber").value = i;
					document.getElementById("textNumber").value = x;
					i++;
					x++;
				}

				//delete any element
				function del(o) {
					o.parentNode.parentNode.removeChild(o.parentNode);
				}

				//generate sample graph
				function generateGraph() {
					document.getElementById("save").disabled = false;

					var tn1S = document.getElementById("tn1").value;
					var cn1S = document.getElementById("cn1").value;
					var cn2S = document.getElementById("cn2").value;
					//check whether they are empty
					if ((!tn1S) || (!cn1S) || (!cn2S)) {
						document.getElementById("errorMessage2").innerHTML = '<p style="color: #ff6666; font-size: 11px">'
								+ "All the fields could not be empty." + '</p>';
					} else {

						var tn1 = parseInt(tn1S);
						var cn1 = parseInt(cn1S);
						var cn2 = parseInt(cn2S);
						var pi = /^[1-9]+[0-9]*]*$/;

						var table = document.getElementById("table" + tn1S);
						var column1 = document.getElementById("table" + tn1S
								+ "th" + cn1S);
						var column2 = document.getElementById("table" + tn1S
								+ "th" + cn2S);

						//check whether they are positive integer
						if (!(pi.test(tn1)) || !(pi.test(cn1))
								|| !(pi.test(cn2))) {
							document.getElementById("errorMessage2").innerHTML = '<p style="color: #ff6666; font-size: 11px">'
									+ "All fields must be positive integer."
									+ '</p>';
						//check whether two columns are different
						} else if (cn1 == cn2) {
							document.getElementById("errorMessage2").innerHTML = '<p style="color: #ff6666; font-size: 11px">'
									+ "Column Number 1 and Column Number 2 could not be same."
									+ '</p>';
						} else if ((!table) || (!column1) || (!column2)) {
							document.getElementById("errorMessage2").innerHTML = '<p style="color: #ff6666; font-size: 11px">'
									+ "Table Number or Column Number does not exist."
									+ '</p>';

						} else if ((!column1.value) || (!column2.value)) {
							document.getElementById("errorMessage2").innerHTML = '<p style="color: #ff6666; font-size: 11px">'
									+ "Column titles in the table could not be empty."
									+ '</p>';
						} else {
							var graph = "";
							var hAxisTitle = column1.value;
							var vAxisTitle = column2.value;

							graph += '<div id="divgraph' + i + '">';
							graph += '<input type="text" name="graphName'+i+'" placeholder="Graph Name..." required/>';
							graph += '<input type="hidden" name="'+i+'" value="graph">'
							graph += '<input type="hidden" id="graphTable'+i+'" name="graphTable'+i+'" value="'+tn1S+'">';
							graph += '<input type="hidden" id="graph'+i+'column1'+'" name="graph'+i+'column1'+'" value="'+hAxisTitle+'">';
							graph += '<input type="hidden" id="graph'+i+'column2'+'" name="graph'+i+'column2'+'" value="'+vAxisTitle+'">';
							graph += '<div id="flot-lines' + g + '">'
									+ '</div>';
							graph += '<input type="button" class="small button green" value="delete" onclick="del(this)"/>';
							graph += '</div>';
							var subdiv = document.createElement("div");
							subdiv.innerHTML = graph;
							document.getElementById("field")
									.appendChild(subdiv);

							$("#dialog2").dialog("close");

							google.setOnLoadCallback(drawChart());

							function drawChart() {
								var data = new google.visualization.DataTable();
								data.addColumn('number');
								data.addColumn('number');

								var options = {
									title : 'Sample Chart',
									titleTextStyle : {
										fontSize : '18',
										fontWidth : 'normal'
									},
									legend : {
										position : 'none'
									},
									series : {
										0 : {
											color : '#a1b900',
											lineWidth : 10
										},
									},
									width : 500,
									height : 300,
									hAxis : {
										title : hAxisTitle
									},
									vAxis : {
										title : vAxisTitle
									},
								
								};

								var chart = new google.visualization.LineChart(
										document.getElementById('flot-lines'
												+ g));
								chart.draw(data, options);
							}
							document.getElementById("divNumber").value = i;
							document.getElementById("graphNumber").value = g;
							i++;
							g++;
						}
					}
				}

				//add table element
				function generateTable() {
					document.getElementById("save").disabled = false;

					var rowS = document.getElementById("row").value;
					var columnS = document.getElementById("column").value;
					//check whether they are empty
					if ((!rowS) || (!columnS)) {
						document.getElementById("errorMessage1").innerHTML = '<p style="color: #ff6666; font-size: 11px">'
								+ "Both row and column could not be empty."
								+ '</p>';
					} else {
						var row = parseInt(rowS);
						var column = parseInt(columnS);
						var pi = /^[1-9]+[0-9]*]*$/;
						//check whether they are positive integer
						if (!(pi.test(row)) || !(pi.test(column))) {
							document.getElementById("errorMessage1").innerHTML = '<p style="color: #ff6666; font-size: 11px">'
									+ "Both row and column must be positive integer."
									+ '</p>';
						} else {
							var table = "";

							table += '<div id="divtable' + i + '">';
							table += '<p>Table ID: ' + i + '</p>';
							table += '<br>';
							table += '<input type="text" name="tableName'+i+'" placeholder="Table Name..." required/>';
							table += '<input type="hidden" name="'+i+'" value="table"/>'
							table += '<input type="hidden" id="table'+i+'row" name="table'+i+'row" value="'+row+'"/>';
							table += '<input type="hidden" id="table'+i+'column" name="table'+i+'column" value="'+column+'"/>';
							table += '<input type="hidden" id="table'+i+'number" name="table'+i+'number" value="'+i+'"/>';
							table += '<table class="display" id="table' + i + '">';
							table += '<thead>' + '<tr>';
							for (k = 0; k < column; k++) {
								table += '<th><input name="table'
										+ +i
										+ 'th'
										+ (k + 1)
										+ '" id="table'
										+ i
										+ 'th'
										+ (k + 1)
										+ '" required onkeydown="if(event.keyCode==13){return false;}" type="text" placeholder="Column Title..."></th>';
							}
							table += '</tr>' + '</thead>' + '<tbody>';

							for (var j = 0; j < row; j++) {
								table += '<tr>';
								for (var k = 0; k < column; k++) {
									table += '<td></td>';
								}
								table += '</tr>';
							}
							table += '</tbody>';
							table += '</table>';
							table += '<input type="button" class="small button green" value="delete" onclick="del(this)"/>';
							table += '</div>';
							var subdiv = document.createElement("div");
							subdiv.innerHTML = table;
							document.getElementById("field")
									.appendChild(subdiv);

							$("#dialog").dialog("close");
							document.getElementById("divNumber").value = i;
							document.getElementById("tableNumber").value = t;
							i++;
							t++;
						}
					}
				}

				function validateEmpty() {
					var flag = true;

					for (var vt = 1; vt < i; vt++) {
						for (var vth = 1; vth < 21; vth++) {
							var VTHtext = document.getElementById("table" + vt
									+ "th" + vth);
							if (VTHtext && (!(VTHtext.value))) {
								document.getElementById("errorMessage3").innerHTML = '<p style="color: #ff6666; font-size: 11px">'
										+ "Column titles in the table could not be empty."
										+ '</p>';

								flag = false;
							}

						}

					}
					for (var v = 1; v < x; v++) {
						var Vtext = document.getElementById("text" + v);
						if (Vtext && (!(Vtext.value))) {
							document.getElementById("errorMessage3").innerHTML = '<p style="color: #ff6666; font-size: 11px">'
									+ "Text must not be empty." + '</p>';

							flag = false;
						}

					}

					return flag;

				}

				$("#dialog").dialog({
					autoOpen : false,
					resizable : false,
					modal : true,
				});

				$("#open-dialog").click(function() {
					$("#dialog").dialog("open");
					return false;
				});
				$("#dialog2").dialog({
					autoOpen : false,
					resizable : false,
					modal : true,
				});

				$("#open-dialog2").click(function() {
					$("#dialog2").dialog("open");
					return false;
				});
			</script>
</body>
</html>