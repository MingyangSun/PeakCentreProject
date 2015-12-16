<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>PeakCentre - Add Workout Summary</title>
<link rel="shortcut icon" href="../image/favicon.png">
<!---CSS Files-->
<link rel="stylesheet" href="../css/master.css">
<link rel="stylesheet" href="../css/tables.css">
<link rel="stylesheet" type='text/css' href="../css/fullcalendar.css" />
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
<script src="../js/flot/jquery.flot.min.js"></script>
<script src="../js/flot/jquery.flot.resize.min.js"></script>
<script src="../js/fullcalendar/fullcalendar.min.js"></script>

<!---Fonts-->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Ubuntu:500'
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
			<p>Add Workout Summary</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>Workout Information</h2>
			</div>
			<form id="chooseuser_form" method="post" action="getTrainingPlan">
				<div class="box-content">
					<div class="form-row">
						<p>Please choose the Start Date associated with the training
							plan you would like to add.</p>
					</div>
					<br> <br>
					<div class="form-row">
						<label class="form-label">Start Date</label>
						<div class="form-item">
							<select name="date">
								<option value='option1'>2015/06/01</option>
								<option value='option2'>2015/06/02</option>
								<option value='option3'>2015/06/03</option>
							</select>
						</div>
					</div>
					<div class="form-row" style="text-align: right;">
						<input type="button" class="button green" value="show"
							onclick="showTable()" />
					</div>
				</div>
			</form>
		</div>
		<div id="div1" class="box grid_12" style="display: none"></div>
		<div id="div2" class="box grid_12" style="display: none">
			<div class="form-row" style="text-align: right;">
				<input type="submit" class="button green" value="save">
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
		function showTable() {
			var i = "";
			var startdate = new Date();
			var weeks = 3;
			var table = "";
			for (i = 0; i < weeks; i++) {
				table += '<div class="box grid_12">';
				table += '<div class="box-head">' + '<h2>Training Plan - Week'
						+ (i + 1) + '</h2>' + '</div>'
						+ '<div class="box-content no-pad">';
				table += '<table id="myDataTable' + String(i) + '">';
				table += '<thead>' + '<tr>' + '<th>Sunday</th>'
						+ '<th>Monday</th>' + '<th>Tuesday</th>'
						+ '<th>Wednesday</th>' + '<th>Thursday</th>'
						+ '<th>Friday</th>' + '<th>Saturday</th>'
						+ '<th rowspan="2">Percentage of Completeness</th>'
						+ '</tr>';
				table += '<tr>' + '<th>'
						+ startdate.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd") + '</th>' + '</tr>'
						+ '</thead>';
				table += '<tbody>' + '<tr>'
						+ '<td class="read_only">B Z1 35s</td>'
						+ '<td class="read_only">SW 30s</td>'
						+ '<td class="read_only">ST1</td>'
						+ '<td class="read_only">R Z3 15s</td>'
						+ '<td class="read_only">R Z1 50s</td>'
						+ '<td class="read_only">ST2</td>'
						+ '<td class="read_only">B Z3 15s</td>' + '<td></td>'
						+ '</tr>';
				table += '</tbody>';
				table += '</table>';
				table += '</div>' + '</div>';
				startdate.setDate(startdate.getDate() + 1);
			}
			table += '<div class="box grid_12">';
			table += '<div class="box-head">' + '<h2>Training Plan - ST1</h2>'
					+ '</div>' + '<div class="box-content no-pad">';
			table += '<table id="myDataTable' + String(i) + '">';
			table += '<thead>' + '<tr>' + '<th>Exercise</th>' + '<th>W1</th>'
					+ '<th></th>' + '<th></th>' + '<th></th>' + '<th></th>'
					+ '<th></th>' + '<th>W2</th>' + '<th></th>' + '<th></th>'
					+ '<th></th>' + '<th></th>' + '<th></th>' + '<th>W3</th>'
					+ '<th></th>' + '<th></th>' + '<th></th>' + '<th></th>'
					+ '<th></th>' + '<th>W4</th>' + '<th></th>' + '<th></th>'
					+ '<th></th>' + '<th></th>' + '<th></th>' + '</tr>'
					+ '</thead>';
			table += '<tbody>' + '<tr>'
					+ '<td class="read_only">Close Stance Back Squats</td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>';
			table += '<tr>' + '<td class="read_only"></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>'
					+ '<td class="read_only">Standing DB Overhead Press</td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>' + '<td class="read_only"></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>' + '<td class="read_only">Romanian Deadlift</td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>' + '<td class="read_only"></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>' + '<td class="read_only">Romanian Deadlift</td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>' + '<td class="read_only"></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '</tbody>';
			table += '</table>';
			table += '</div>' + '</div>';
			i++;
			table += '<div class="box grid_12">';
			table += '<div class="box-head">' + '<h2>Training Plan - ST2</h2>'
					+ '</div>' + '<div class="box-content no-pad">';
			table += '<table id="myDataTable' + String(i) + '">';
			table += '<thead>' + '<tr>' + '<th>Exercise</th>' + '<th>W1</th>'
					+ '<th></th>' + '<th></th>' + '<th></th>' + '<th></th>'
					+ '<th></th>' + '<th>W2</th>' + '<th></th>' + '<th></th>'
					+ '<th></th>' + '<th></th>' + '<th></th>' + '<th>W3</th>'
					+ '<th></th>' + '<th></th>' + '<th></th>' + '<th></th>'
					+ '<th></th>' + '<th>W4</th>' + '<th></th>' + '<th></th>'
					+ '<th></th>' + '<th></th>' + '<th></th>' + '</tr>'
					+ '</thead>';
			table += '<tbody>' + '<tr>' + '<td class="read_only">Deadlift</td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>';
			table += '<tr>' + '<td class="read_only"></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>' + '<td class="read_only">DB Chest Press</td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>' + '<td class="read_only"></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>' + '<td class="read_only">DB Walking Lunge</td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>' + '<td class="read_only"></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>' + '<td class="read_only">Pull Ups</td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">W</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '<tr>' + '<td class="read_only"></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '<td class="read_only">R</td>' + '<td></td>'
					+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
					+ '</tr>';
			table += '</tbody>';
			table += '</table>';
			table += '</div>' + '</div>';
			document.getElementById("div1").innerHTML = table;
			document.getElementById("div1").style.display = "block";
			document.getElementById("div2").style.display = "block";

			$("#myDataTable0").dataTable({
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
			$("#myDataTable1").dataTable({
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
			$("#myDataTable2").dataTable({
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
			$("#myDataTable3").dataTable({
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
			$("#myDataTable4").dataTable({
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
			$("#myDataTable5").dataTable({
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
			$("#myDataTable6").dataTable({
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

		}

		Date.prototype.format = function(format) {
			var o = {
				"M+" : this.getMonth() + 1, //month
				"d+" : this.getDate(), //day
			}
			if (/(y+)/.test(format))
				format = format.replace(RegExp.$1, (this.getFullYear() + "")
						.substr(4 - RegExp.$1.length));
			for ( var k in o)
				if (new RegExp("(" + k + ")").test(format))
					format = format.replace(RegExp.$1,
							RegExp.$1.length == 1 ? o[k] : ("00" + o[k])
									.substr(("" + o[k]).length));
			return format;
		}
	</script>

</body>
</html>