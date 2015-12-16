function validDates() {
	$("#errmessageDates").html("");
	var startdate = document.getElementsByName("startdate")[0].value;
	var enddate = document.getElementsByName("enddate")[0].value;
	var post = {
			startDate: startdate,
			endDate: enddate,
			fname : $("#usernameForm input[name=fname]").val(),
			lname : $("#usernameForm input[name=lname]").val(),
			userlist : $("#usernameForm select[name=userlist]").val()
	};
	$.post('AjaxCheckTrainingPlanDates', post, function(data) {
		console.log("check:" + data);
		if(data == "") {
			showTable();
		} else {
			$("#errmessageDates").html("<p style='color: #ff6666; font-size: 11px'>"+data+"</p>");
		}
	});
	return true;
}

function clickAddRowST1() {

	$('#ST1DataTable').dataTable()
			.fnAddData([ "", "", "", "", "", "" ]);
	$('#ST1DataTable').dataTable().find('td').editable(function(v, s) {
		console.log(v);
		return (v);
	});
}
function clickAddRowST2() {

	$('#ST2DataTable').dataTable()
			.fnAddData([ "", "", "", "", "", "" ]);
	$('#ST2DataTable').dataTable().find('td').editable(function(v, s) {
		console.log(v);
		return (v);
	});
}
function clickAddRowFT() {
	var FTselect = "<select>"
		+ "<option value='Lying quad stretch'>Lying quad stretch</option>"
		+ "<option value='Standing hamstring stretch'>Standing hamstring stretch</option>"
		+ "<option value='Groin stretch'>Groin stretch</option>"
		+ "<option value='Hip Flexor stretch'>Hip Flexor stretch</option>"
		+ "<option value='Glute stretch'>Glute stretch</option>"
		+ "<option value='Triceps Stretch'>Triceps Stretch</option>"
		+ "<option value='Cross shoulder stretch'>Cross shoulder stretch</option>"
		+ "<option value='Kneeling wrist stretch'>Kneeling wrist stretch</option>"
		+ "<option value='Kneeling bench stretch'>Kneeling bench stretch</option>"
		+ "</select>";
	var videoSelect = "<select class='video'>"
		+ "<option>No</option>"
		+ "<option>Yes</option>"
		+ "</select>";
	$('#FTDataTable').dataTable().fnAddData([ FTselect, "", "" ,videoSelect]);
	$('#FTDataTable').find('tbody tr').each(function(){
		$('#FTDataTable').dataTable().find(this).find('td').not(':eq(0),:eq(3)').editable(function(v, s) {
			console.log(v);
			return (v);
		});
	});
}
$(document).on('change', 'select.grid', function () {
	//
	var c = $(this).parent();
	var column = $(c).parent().children().index(c);
    var row = $(c).parent().parent().children().index(c.parentNode);
		if($(this).val() == "off") {
			if($(this).next().is("input")) {
				$(this).next().remove();
			}
		} else if($(this).val() == "") {
			if($(this).next().is("input")) {
				$(this).next().remove();
			}
		} else {
				if(!$(this).next().is("input")) {
					$(this).parent().append('<input name="text" required>');
				}
		}
 });
$(document).on('change','td.copy',function() {
	 var c = $(this).closest('table').attr('id');
	 var d = c.substring(11);
		var column = $(this).parent().children().index(this);
	    var row = $(this).parent().parent().children().index(this.parentNode);
	 for(var i = 0; i < 3; i++) {
		 d++;
		 if($("#myDataTable" + d).length != 0) {
			 var selected = $(this).find('select').val();
			 $("#myDataTable"+d+" tbody tr:eq("+row+") td:eq("+column+")").html($(this).html()).find('select').val(selected);
			 if($(this).find('input').length != 0 && $(this).find('input').val() != '') {
				 $("#myDataTable"+d+" tbody tr:eq("+row+") td:eq("+column+")").find('input').val($(this).find('input').val());
			 }	 
		 }
	 }
 });
function printPage() {
	window.print();more
}
function replaceSymbol(name) {
	var find="'";
	var re = new RegExp(find, 'g');
	name = name.replace(re, "+");
	//console.log("Name"+name);
	return name;
}
function addJson() {
	$("td").css("border","");
	//var weeks = $("input[name=weeks]").val();
	var startdate = new Date(
				document.getElementsByName("startdate")[0].value);
	var startdate2 = startdate;
	var enddate = new Date(
			document.getElementsByName("enddate")[0].value);
		enddate.setDate(enddate.getDate() + 1);
	var perWeek = 24 * 60 * 60 * 1000 * 7;
		//get total weeks
	var weeks = Math.ceil((enddate.valueOf() - startdate.valueOf())
				/ perWeek);
	var tables = $("#div1").find("table");
	
	//Valid Week Table
	for(var i = 0; i < weeks; i++) {
		var days = $(tables[i]).find("thead tr:eq(1) th").length;
		for(var j = 1; j <= days; j++) {
			var content = "";
			$(tables[i]).find("tbody tr td:nth-child("+j+")").each(function(){ 
				content+=$(this).find("select").val();
			});
			if(content == "") {
				$(tables[i]).find("tbody tr td:nth-child("+j+")").css('border','2px solid red');
				alert("Please fill content in red box!");
				return false;				
			}
		}
	}
	//Get input data in Week Table//
	var allWeek ={};
	for(var i = 0; i < weeks; i++) {	
		var allTh=$(tables[i]).find("thead tr:eq(1) th");
		var days = allTh.length;
		allWeek["week"+(i+1)]=[];
		var allTr=$(tables[i]).find("tbody tr");
		for(var j = 0; j < allTr.length; j++) {
			var oneEntry = {};
			for(var m=0; m< days; m++) {
				console.log("key: " + $(allTh[m]).html());
				if($(allTr[j]).find("td:eq("+m+") select").val() == "off") {
					oneEntry[$(allTh[m]).html()]= "off";
				} else if ($(allTr[j]).find("td:eq("+m+") select").val() == "") {
					oneEntry[$(allTh[m]).html()]= "";
				} else {
					//replace ' with +
					oneEntry[$(allTh[m]).html()]= $(allTr[j]).find("td:eq("+m+") select").val() + " " + replaceSymbol($(allTr[j]).find("td:eq("+m+") input").val());
					//oneEntry[$(allTh[m]).html()]= $(allTr[j]).find("td:eq("+m+") select").val() + " " + $(allTr[j]).find("td:eq("+m+") input").val();
				}
			}
			allWeek["week"+(i+1)].push(oneEntry);
		}
	}
	console.log(JSON.stringify(allWeek));
	
	//Get Stage Data//
	var st1 = [];
	var st2 = [];
	//stage1
	var allTh = $(tables[i]).find("thead tr:eq(0) th");
	var allTr = $(tables[i]).find("tbody tr");
	for(var j = 0; j < allTr.length; j++) {
		var stage1 = {};
		for(var m=0; m < allTh.length; m++) {
			var content = $(allTr[j]).find("td:eq("+m+")").html();
			if(content != "Click to edit") {
				//replace ' with +
				stage1[$(allTh[m]).html()] = replaceSymbol(content);
				//stage1[$(allTh[m]).html()] = content;
			} else {
				$(allTr[j]).find("td:eq("+m+")").css('border','2px solid red');
				alert("Please fill content in red box!");
				return false;
			}
		}
		st1.push(stage1);
	}
	//stage2
	allTh = $(tables[i+1]).find("thead tr:eq(0) th");
	allTr = $(tables[i+1]).find("tbody tr");
	for(var j = 0; j < allTr.length; j++) {
		var stage2 = {};
		for(var m=0; m < allTh.length; m++) {
			var content = $(allTr[j]).find("td:eq("+m+")").html();
			if(content != "Click to edit") {
				//replace ' with +
				stage2[$(allTh[m]).html()] = replaceSymbol(content);
				//stage2[$(allTh[m]).html()] = content; 
			} else {
				$(allTr[j]).find("td:eq("+m+")").css('border','2px solid red');
				alert("Please fill content in red box!");
				return false;
			}
		}
		st2.push(stage2);
	}
	
	//Get Flexibility Training Data//
	var ft = [];
	allTh = $(tables[i+2]).find("thead tr:eq(0) th");
	allTr = $(tables[i+2]).find("tbody tr");
	for(var j = 0; j < allTr.length; j++) {
		var ftDetail = {};
		for(var m=0; m < allTh.length; m++) {
			if( m == 0) {
				ftDetail[$(allTh[m]).html()] = $(allTr[j]).find("td:eq("+m+") select").val();
			} else if(m == 3) {
				var tempSelect = $(allTr[j]).find("td:eq("+m+") select:eq(0)").val();
				if(tempSelect == 'No') {
					ftDetail[$(allTh[m]).html()] = $(allTr[j]).find("td:eq("+m+") select:eq(0)").val();
				} else {
					var tempContent = 'Yes ';
					tempContent += $(allTr[j]).find("td:eq("+m+") select:eq(1)").val();
					ftDetail[$(allTh[m]).html()] = tempContent;
				}
			} else{
				var content = $(allTr[j]).find("td:eq("+m+")").html();
				if(content != "Click to edit") {
					//replace ' with +
					ftDetail[$(allTh[m]).html()] = replaceSymbol(content);
					//ftDetail[$(allTh[m]).html()] = content; 
				} else {
					$(allTr[j]).find("td:eq("+m+")").css('border','2px solid red');
					alert("Please fill content in red box!");
					return false;
				}
			}
		}
		ft.push(ftDetail);
	}
	
	$("#div1").append("<input type='hidden' name='weekData' value='"+ JSON.stringify(allWeek) +"' >");
	$("#div1").append("<input type='hidden' name='st1' value='"+ JSON.stringify(st1) +"' >");
	$("#div1").append("<input type='hidden' name='st2' value='"+ JSON.stringify(st2) +"' >");
	$("#div1").append("<input type='hidden' name='ft' value='"+ JSON.stringify(ft) +"' >");
	console.log("HHHH:"+JSON.stringify(ft));
	return false;
	//return true;
}
function enrich(i) {
	//FT select
	var FTselect = "<select>"
			+ "<option value='Lying quad stretch'>Lying quad stretch</option>"
			+ "<option value='Standing hamstring stretch'>Standing hamstring stretch</option>"
			+ "<option value='Groin stretch'>Groin stretch</option>"
			+ "<option value='Hip Flexor stretch'>Hip Flexor stretch</option>"
			+ "<option value='Glute stretch'>Glute stretch</option>"
			+ "<option value='Triceps Stretch'>Triceps Stretch</option>"
			+ "<option value='Cross shoulder stretch'>Cross shoulder stretch</option>"
			+ "<option value='Kneeling wrist stretch'>Kneeling wrist stretch</option>"
			+ "<option value='Kneeling bench stretch'>Kneeling bench stretch</option>"
			+ "</select>";	
	var table ="";
	table += '<div class="box grid_12">';
	table += '<div class="box-head">'
			+ '<h2>Training Plan - ST1</h2>' + '</div>'
			+ '<div class="box-content no-pad">';
	table += '<ul class="table-toolbar">';
	
	table += '<li onClick="clickAddRowST1()">' + '<a>'
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
	var videoSelect = "<select class='video'>"
		+ "<option>No</option>"
		+ "<option>Yes</option>"
		+ "</select>";
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
			+ '<th>Sets</th>' + '<th>Hold (in sec)</th>' + '<th>Video</th>'+ '</tr>'
			+ '</thead>';
	table += '<tbody>' + '<tr>' + '<td>'+ FTselect + '</td>' + '<td></td>'
			+ '<td></td>' + '<td>'+videoSelect+'</td>' + '</tr>';
	table += '</tbody>';
	table += '</table>';
	table += '</div>' + '</div>';
	return table;
}