function gHtml() {

	
	var table = "";
	for (i = 0; i < weeks; i++) {
		if ((i == (weeks - 1)) && (mod != 0)) {
			table += '<input type="hidden" name="weeks" value="'+weeks+'">';
			table += '<div class="box grid_12">';
			table += '<div class="box-head">'
					+ '<h2>Training Plan - Week' + (i + 1)
					+ '</h2>' + '</div>'
					+ '<div class="box-content no-pad">';
			table += '<ul class="table-toolbar">';
			table += '<li onClick="clickAddZoneLastTable('
				+ String(i)
				+ ','
				+ mod
				+ ')">'
				+ '<a>'
				+ '<img src="../image/icons/basic/plus.png" alt=""/>'
				+ ' Add Zone' + '</a>' + '</li>' + '</ul>';
		table += '<table id="myDataTable' + String(i) + '">';

			var weekday = new Array(7);
			weekday[0] = "Sunday";
			weekday[1] = "Monday";
			weekday[2] = "Tuesday";
			weekday[3] = "Wednesday";
			weekday[4] = "Thursday";
			weekday[5] = "Friday";
			weekday[6] = "Saturday";

			table += '<thead>' + '<tr>' + '';
			for (var d = 0; d < mod; d++) {
				table += '<th>' + weekday[startdate2.getDay()]
						+ '</th>';
				startdate2.setDate(startdate2.getDate() + 1);

			}
			table += '</tr>';
			enddate.setDate(enddate.getDate() - mod - 1);

			table += '<tr>' + '';
			for (var d = 0; d < mod; d++) {
				table += '<th>'
						+ new Date(enddate.setDate(enddate
								.getDate() + 1)).format("MM/dd")
						+ '</th>';

			}
			table += '</tr>' + '</thead>' + '<tbody>' + '<tr>';
			for (var d = 0; d < mod; d++) {
				table += '<td class="test"><select class="grid" ><option value=""></option><option value="off">off</option><option value="sw">sw</option><option value="r">r</option></select></td>';

			}
			table += '</tr>' + '</tbody>';
			table += '</table>';
			table += '</div>' + '</div>';
			startdate.setDate(startdate.getDate() + 1);

		} else {
			table += '<div class="box grid_12">';
			table += '<div class="box-head">'
					+ '<h2>Training Plan - Week' + (i + 1)
					+ '</h2>' + '</div>'
					+ '<div class="box-content no-pad">';
			table += '<ul class="table-toolbar">';
			table += '<li onClick="clickAddZone('
				+ String(i)
				+ ')">'
				+ '<a>'
				+ '<img src="../image/icons/basic/plus.png" alt=""/>'
				+ ' Add Zone' + '</a>' + '</li>' + '</ul>';
		table += '<table id="myDataTable' + String(i) + '">';

			var weekday = new Array(7);
			weekday[0] = "Sunday";
			weekday[1] = "Monday";
			weekday[2] = "Tuesday";
			weekday[3] = "Wednesday";
			weekday[4] = "Thursday";
			weekday[5] = "Friday";
			weekday[6] = "Saturday";

			var startWeekday1 = weekday[startdate.getDay()];
			startdate.setDate(startdate.getDate() + 1);
			var startWeekday2 = weekday[startdate.getDay()];
			startdate.setDate(startdate.getDate() + 1);
			var startWeekday3 = weekday[startdate.getDay()];
			startdate.setDate(startdate.getDate() + 1);
			var startWeekday4 = weekday[startdate.getDay()];
			startdate.setDate(startdate.getDate() + 1);
			var startWeekday5 = weekday[startdate.getDay()];
			startdate.setDate(startdate.getDate() + 1);
			var startWeekday6 = weekday[startdate.getDay()];
			startdate.setDate(startdate.getDate() + 1);
			var startWeekday7 = weekday[startdate.getDay()];

			table += '<thead>' + '<tr>' + '' + '<th>'
					+ startWeekday1 + '</th>' + '<th>'
					+ startWeekday2 + '</th>' + '<th>'
					+ startWeekday3 + '</th>' + '<th>'
					+ startWeekday4 + '</th>' + '<th>'
					+ startWeekday5 + '</th>' + '<th>'
					+ startWeekday6 + '</th>' + '<th>'
					+ startWeekday7 + '</th>' + '</tr>';

			startdate.setDate(startdate.getDate() - 6);

			table += '<tr>'
					+ ''
					+ '<th>'
					+ startdate.format("MM/dd")
					+ '</th>'
					+ '<th>'
					+ new Date(startdate.setDate(startdate
							.getDate() + 1)).format("MM/dd")
					+ '</th>'
					+ '<th>'
					+ new Date(startdate.setDate(startdate
							.getDate() + 1)).format("MM/dd")
					+ '</th>'
					+ '<th>'
					+ new Date(startdate.setDate(startdate
							.getDate() + 1)).format("MM/dd")
					+ '</th>'
					+ '<th>'
					+ new Date(startdate.setDate(startdate
							.getDate() + 1)).format("MM/dd")
					+ '</th>'
					+ '<th>'
					+ new Date(startdate.setDate(startdate
							.getDate() + 1)).format("MM/dd")
					+ '</th>'
					+ '<th>'
					+ new Date(startdate.setDate(startdate
							.getDate() + 1)).format("MM/dd")
					+ '</th>';

			table += '</tr>' + '</thead>';
			table += '<tbody>'
					+ '<tr>';
			for(var temp = 0; temp < 7; temp++) {	
					table += '<td><select class="grid" ><option value=""></option><option value="off">off</option><option value="sw">sw</option><option value="r">r</option></select></td>';
			}
			table += '</tr>';
			table += '</tbody>';
			table += '</table>';
			table += '</div>' + '</div>';
			startdate.setDate(startdate.getDate() + 1);
		}
	}

	table += '<div class="box grid_12">';
	table += '<div class="box-head">'
			+ '<h2>Training Plan - ST1</h2>' + '</div>'
			+ '<div class="box-content no-pad">';
	table += '<ul class="table-toolbar">';
	
	table += '<li class="rows">' + '<a>'
			+ '<img src="../image/icons/basic/plus.png" alt=""/>'
			+ ' Add Row' + '</a>' + '</li>' + '</ul>';
	table += '<table id="ST1DataTable">';

	table += '<thead>' + '<tr>' + '<th>No.</th>'
			+ '<th>Exercise</th>' + '<th>Sets</th>'
			+ '<th>Reps</th>' + '<th>Tempo</th>' + '<th>Rest</th>'
			+ '</tr>' + '</thead>';
	table += '<tbody>' + '<tr>' + '<td></td>' + '<td></td>'
			+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
			+ '</tr>';
	table += '</tbody>';
	table += '</table>';
	table += '</div>' + '</div>';
	i++;

	table += '<div class="box grid_12">';
	table += '<div class="box-head">'
			+ '<h2>Training Plan - ST2</h2>' + '</div>'
			+ '<div class="box-content no-pad">';
	table += '<ul class="table-toolbar">';
	table += '<li onClick="clickAddRowST2()">' + '<a>'
			+ '<img src="../image/icons/basic/plus.png" alt=""/>'
			+ ' Add Row' + '</a>' + '</li>' + '</ul>';
	table += '<table id="ST2DataTable">';
	table += '<thead>' + '<tr>' + '<th>No.</th>'
			+ '<th>Exercise</th>' + '<th>Sets</th>'
			+ '<th>Reps</th>' + '<th>Tempo</th>' + '<th>Rest</th>'
			+ '</tr>' + '</thead>';
	table += '<tbody>' + '<tr>' + '<td></td>' + '<td></td>'
			+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
			+ '</tr>';
	table += '</tbody>';
	table += '</table>';
	table += '</div>' + '</div>';
	i++;

	table += '<div class="box grid_12">';
	table += '<div class="box-head">'
			+ '<h2>Training Plan - Flexibility Training</h2>'
			+ '</div>' + '<div class="box-content no-pad">';
	table += '<ul class="table-toolbar">';
	table += '<li onClick="clickAddRowFT()">' + '<a>'
			+ '<img src="../image/icons/basic/plus.png" alt=""/>'
			+ ' Add Row' + '</a>' + '</li>' + '</ul>';
	table += '<table id="FTDataTable">';
	table += '<thead>' + '<tr>' + '<th>Stretching Exercise</th>'
			+ '<th>Sets</th>' + '<th>Hold (in sec)</th>' + '</tr>'
			+ '</thead>';
	table += '<tbody>' + '<tr>' + '<td></td>' + '<td></td>'
			+ '<td></td>' + '</tr>';
	table += '</tbody>';
	table += '</table>';
	table += '</div>' + '</div>';
}