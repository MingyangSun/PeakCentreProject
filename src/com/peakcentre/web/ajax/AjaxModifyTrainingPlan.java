package com.peakcentre.web.ajax;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.peakcentre.web.dao.TrainingPlanDao;
import com.peakcentre.web.entity.TrainingPlan;
import com.peakcentre.web.dao.TestResultTemplateDao;
import Util.GenerateVideoHtml;

/**
 * Servlet implementation class AjaxModifyTrainingPlan
 */
@WebServlet("/jsp/AjaxModifyTrainingPlan")
public class AjaxModifyTrainingPlan extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxModifyTrainingPlan() {
        super();
        // TODO Auto-generated constructor stub
    }
    /*public static String generateVideoPart(String option) {
    	if(option.equals("No")) {
    		return "<select class='video'><option>Yes</option><option selected>No</option></select>";
    	} else {
    		String result = "<select class='video'><option selected>Yes</option><option>No</option></select>";
    		result += "<select>";
    		if(option.substring(4).equals("1")) {
    			result += "<option value='1' selected>Lying quad stretch</option><option value='2'>Groin stretch</option>";
    		} else {
    			result += "<option value='1'>Lying quad stretch</option><option value='2' selected>Groin stretch</option>";
    		}
    		result += "</select>";
    		return result;
    	}
    }*/
    public static String generateVideoPart(String option) {
    	String[] allOptions = GenerateVideoHtml.getAllOptions();
    	if(option.equals("No")) {
    		return "<select class='video'><option>Yes</option><option selected>No</option></select>";
    	} else {
    		option = option.substring(4);
    		String result = "<select class='video'><option selected>Yes</option><option>No</option></select>";
    		result += "<select>";
    		String tempOptionEnd2 = "<option selected>";
        	String tempOption1 = "<option>";
        	String tempOptionEnd = "</option>";
        	for(int i = 0; i < allOptions.length; i++) {
        		if(allOptions[i].equals(option)) {
        			result = result + tempOptionEnd2 + option + tempOptionEnd;
        		} else {
        			result = result + tempOption1 + allOptions[i] + tempOptionEnd;
        		}
        	}
        	result = result +  "</select>";
    		return result;
    	}
    }
    public static String generateGrid(String option, String[] allOptions) {
    	String result = "<select class='grid' >";
    	String tempOptionEnd2 = "' selected>";
    	String tempOption1 = "<option value='";
    	String tempOptionEnd1 = "' >";
    	String tempOptionEnd = "</option>";
    	for(int i = 0; i < allOptions.length; i++) {
    		if(allOptions[i].equals(option)) {
    			result = result + tempOption1 + option + tempOptionEnd2 + option + tempOptionEnd;
    		} else {
    			result = result + tempOption1 + allOptions[i] + tempOptionEnd1 + allOptions[i] + tempOptionEnd;
    		}
    	}
    	result = result +  "</select>";
    	return result;
    }
    
    public static String generateFT(String option, String[] allOptions) {
    	String result = "<select>";
    	String tempOptionEnd2 = "' selected>";
    	String tempOption1 = "<option value='";
    	String tempOptionEnd1 = "' >";
    	String tempOptionEnd = "</option>";
    	for(int i = 0; i < allOptions.length; i++) {
    		if(allOptions[i].equals(option)) {
    			result = result + tempOption1 + option + tempOptionEnd2 + option + tempOptionEnd;
    		} else {
    			result = result + tempOption1 + allOptions[i] + tempOptionEnd1 + allOptions[i] + tempOptionEnd;
    		}
    	}
    	result = result +  "</select>";
    	return result;
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getSession(false) != null && request.getSession(false).getAttribute("id") != null) {
			response.sendRedirect("dashboard.jsp");
		} else {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String date = request.getParameter("date");
		
		String[] tempDate = date.split(" - ");
		String startDate = tempDate[0];
		String endDate = tempDate[1];
	
		System.out.println("startDate: " + startDate);
		System.out.println("endDate: " + endDate);
		
		TrainingPlanDao tpd = new TrainingPlanDao();
		TrainingPlan plan = tpd.getTrainingPlan(username, startDate, endDate);
		Map<String, String> allData = plan.getData();
		String weekData = allData.get("weekData");
		String st1 = allData.get("st1");
		String st2 = allData.get("st2");
		String ft = allData.get("ft");
		
		/***********************|   Select Option     |*************************************/
		TestResultTemplateDao templateDao = new TestResultTemplateDao();
		ArrayList<String> allAlias = templateDao.getAllTemplateAlias();
		String[] allOptions = new String[2+allAlias.size()];
		allOptions[0] = "";
		allOptions[1] = "off";
		for(int i = 0; i < allAlias.size(); i++) {
			allOptions[2+i] = allAlias.get(i);
		}
		String[] ftOptions = {"Lying quad stretch",
				"Standing hamstring stretch",
				"Groin stretch",
				"Hip Flexor stretch",
				"Glute stretch",
				"Triceps Stretch",
				"Cross shoulder stretch",
				"Kneeling wrist stretch",
				"Kneeling bench stretch"
				};
		/***********************|   Select Option     |*************************************/
		try {
			JSONObject weekJson = new JSONObject(weekData);
		
		/***********************|      Design HTML       |**********************************/
		String html = "";
		String[] weekday = {"Sunday", "Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
		Date start = new Date(startDate);
		Date end = new Date(endDate);
		Date endTemp = new Date(endDate);
		endTemp.setDate(endTemp.getDate()+1);
		int perWeek = 24*60*60*1000*7;
		int perDay = 24*60*60*1000;
		int weeks = (int)Math.ceil((endTemp.getTime()-start.getTime())/perWeek);
		int mod = (int)(((endTemp.getTime()-start.getTime())%perWeek)/perDay);
		if(mod != 0) weeks++;
		html += "<form method='post' onsubmit='return addJson("+weeks+")' action='ModifyTrainingPlanServlet' >"
				+ "<input type='hidden' name='username' value='"+username+"' >"
				+ "<input type='hidden' name='startdate' value='" + startDate + "' >"
				+ "<input type='hidden' name='enddate' value='" + endDate + "' >";
		for(int i = 0; i < weeks; i++) {
			//HTML For Days
			if((i == weeks-1) && (mod !=0)) {
				html += "<div class='box grid_12'>";
				html += "<div class='box-head'>"
						+ "<h2>Training Plan - Week " + (i+1) + "</h2>"
						+ "</div>";
				html += "<div class='box-content no-pad'>"
						+ "<ul class='table-toolbar'>"
						+ "<li onClick='clickAddZoneLastTable("+(i+1) + "," + mod +")'>"
						+ "<a><img src='../image/icons/basic/plus.png' alt='' />"
						+ "Add Row" + "</a></li></ul>";
				html += "<table id='mytable"+ (i+1) +"'>" + "<thead>" + "<tr>";
				String tmp = "</tr><tr>";
				ArrayList<String> keys = new ArrayList<String>();
				for(int j = 0; j < mod; j++) {
					Date tempdate = new Date(startDate);
					tempdate.setDate(tempdate.getDate()+(7*(weeks-1)+j));
					html += "<th>" + weekday[tempdate.getDay()] + "</th>";
					String formatDay = tempdate.getDate() + "";
					String formatMonth = tempdate.getMonth() + 1 + "";
					if(formatDay.length() == 1) formatDay = "0" + formatDay;
					if(formatMonth.length() == 1) formatMonth = "0" + formatMonth;
					tmp += "<th>" + formatMonth + "/" + formatDay + "</th>";
					keys.add(""+ formatMonth + "/" + formatDay);
				}
				html += tmp;
				html += "</tr>"
						+ "</thead>"
						+ "<tbody>";
				//Fill table with JSON data
				JSONArray modArray = weekJson.getJSONArray(("week" + (i+1)));
				for(int j = 0; j < modArray.length(); j++) {
					html += "<tr>";
					JSONObject rowJson = modArray.getJSONObject(j);
					for(int m = 0; m < mod; m++) {
						html = html + "<td>";
						String row = rowJson.getString(keys.get(m)).toString();
						if(row.equals("") || row.equals("off")) {
							html = html + generateGrid(row, allOptions);
						} else {
							String[] tempRowArray = row.split(" ");
							html = html + generateGrid(tempRowArray[0],allOptions);
							String tempRest = "";
							for(int x = 1; x < tempRowArray.length; x++) {
								if(x == tempRowArray.length-1) {
									tempRest = tempRest + tempRowArray[x];
								} else {
									tempRest = tempRest + tempRowArray[x] + " ";
								}
							}
							html = html + "<input name='text' value='"+ tempRest +"'required>";
						}
						html = html + "</td>";
					}
					html += "</tr>";
				}
				//------------------------
				html += "</tbody>"
						+ "</table>"
						+ "</div>"
						+ "</div>";
				
			} 
			//HTML For Weeks
			else {
				html += "<div class='box grid_12'>";
				html += "<div class='box-head'>"
						+ "<h2>Training Plan - Week " + (i+1) + "</h2>"
						+ "</div>";
				html += "<div class='box-content no-pad'>"
						+ "<ul class='table-toolbar'>"
						+ "<li onClick='clickAddZone("+ (i+1) +")'>"
						+ "<a><img src='../image/icons/basic/plus.png' alt='' />"
						+ "Add Row" + "</a></li></ul>";
				html += "<table id='mytable"+(i+1)+"'>" + "<thead>" + "<tr>";
				String tmp = "</tr><tr>";
				ArrayList<String> keys = new ArrayList<String>();
				for(int j = 0; j < 7; j++) {
					Date tempdate = new Date(startDate);
					tempdate.setDate(tempdate.getDate()+(7*i+j));
					html += "<th>" + weekday[tempdate.getDay()] + "</th>";
					String formatDay = tempdate.getDate() + "";
					String formatMonth = tempdate.getMonth() + 1 + "";
					if(formatDay.length() == 1) formatDay = "0" + formatDay;
					if(formatMonth.length() == 1) formatMonth = "0" + formatMonth;
					tmp += "<th>" + formatMonth + "/" + formatDay + "</th>";
					keys.add(""+ formatMonth + "/" + formatDay);
				}
				html += tmp;
				html += "</tr>"
						+ "</thead>"
						+ "<tbody>";
				//Fill table with JSON data
				JSONArray weekArray = weekJson.getJSONArray(("week" + (i+1)));
				for(int j = 0; j < weekArray.length(); j++) {
					html += "<tr>";
					JSONObject rowJson = weekArray.getJSONObject(j);
					for(int m = 0; m < 7; m++) {
						if(i%4 == 0) {
							html = html + "<td class='copy'>";
						} else {
							html = html + "<td>";
						}
						String row = rowJson.getString(keys.get(m)).toString();
						if(row.equals("") || row.equals("off")) {
							html = html + generateGrid(row,allOptions);
						} else {
							String[] tempRowArray = row.split(" ");
							html = html + generateGrid(tempRowArray[0],allOptions);
							String tempRest = "";
							for(int x = 1; x < tempRowArray.length; x++) {
								if(x == tempRowArray.length-1) {
									tempRest = tempRest + tempRowArray[x];
								} else {
									tempRest = tempRest + tempRowArray[x] + " ";
								}
							}
							html = html + "<input name='text' value='"+ tempRest +"'required>";
						}
						html = html + "</td>";
					}
					html += "</tr>";
				}
				//------------------------
				html += "</tbody>"
						+ "</table>"
						+ "</div>"
						+ "</div>";
			}
		}
		//HTML For st1
		html += "<div class='box grid_12'>"
				+ "<div class='box-head'>"
				+ "<h2>Training Plan - ST1</h2>"
				+ "</div>"
				+ "<div class='box-content no-pad'>"
				+ "<ul class='table-toolbar'>"
				+ "<li onClick='clickAddRowST1()'>"
				+ "<a><img src='../image/icons/basic/plus.png' alt='' />"
				+ "Add Row" + "</a></li></ul>"
				+ "<table id='ST1Table'>" + "<thead>" + "<tr>"
				+ "<th>No.</th>"
				+ "<th>Exercise</th>"
				+ "<th>Sets</th>"
				+ "<th>Reps</th>"
				+ "<th>Tempo</th>"
				+ "<th>Rest</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>";
		JSONArray st1Json = new JSONArray(st1);
		for(int j = 0; j < st1Json.length(); j++) {
			JSONObject rowJson = st1Json.getJSONObject(j);
			html += "<tr>"
					+ "<td>" + rowJson.get("No.") + "</td>"
					+ "<td>" + rowJson.get("Exercise") + "</td>"
					+ "<td>" + rowJson.get("Sets") + "</td>"
					+ "<td>" + rowJson.get("Reps") + "</td>"
					+ "<td>" + rowJson.get("Tempo") + "</td>"
					+ "<td>" + rowJson.get("Rest") + "</td>"
					+ "</tr>";
		}
		html += "</tbody>" + "</table>" + "</div>" + "</div>";
		//HTML For st2
		html += "<div class='box grid_12'>"
				+ "<div class='box-head'>"
				+ "<h2>Training Plan - ST2</h2>"
				+ "</div>"
				+ "<div class='box-content no-pad'>"
				+ "<ul class='table-toolbar'>"
				+ "<li onClick='clickAddRowST2()'>"
				+ "<a><img src='../image/icons/basic/plus.png' alt='' />"
				+ "Add Row" + "</a></li></ul>"
				+ "<table id='ST2Table'>" + "<thead>" + "<tr>"
				+ "<th>No.</th>"
				+ "<th>Exercise</th>"
				+ "<th>Sets</th>"
				+ "<th>Reps</th>"
				+ "<th>Tempo</th>"
				+ "<th>Rest</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>";
		JSONArray st2Json = new JSONArray(st2);
		for(int j = 0; j < st2Json.length(); j++) {
			JSONObject rowJson = st2Json.getJSONObject(j);
			html += "<tr>"
					+ "<td>" + rowJson.get("No.") + "</td>"
					+ "<td>" + rowJson.get("Exercise") + "</td>"
					+ "<td>" + rowJson.get("Sets") + "</td>"
					+ "<td>" + rowJson.get("Reps") + "</td>"
					+ "<td>" + rowJson.get("Tempo") + "</td>"
					+ "<td>" + rowJson.get("Rest") + "</td>"
					+ "</tr>";
		}
		html += "</tbody>"+ "</table>" + "</div>" + "</div>";
		//HTML For ft
		html += "<div class='box grid_12'>"
				+ "<div class='box-head'>"
				+ "<h2>Training Plan Flexibility - Training</h2>"
				+ "</div>"
				+ "<div class='box-content no-pad'>"
				+ "<ul class='table-toolbar'>"
				+ "<li onClick='clickAddRowFT()'>"
				+ "<a><img src='../image/icons/basic/plus.png' alt='' />"
				+ "Add Row" + "</a></li></ul>"
				+ "<table id='FTTable'>" + "<thead>" + "<tr>"
				+ "<th>Stretching Exercise</th>"
				+ "<th>Sets</th>"
				+ "<th>Hold (in sec)</th>"
				+ "<th>Video</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>";
		JSONArray ftJson = new JSONArray(ft);
		for(int j = 0; j < ftJson.length(); j++) {
			JSONObject rowJson = ftJson.getJSONObject(j);
			html += "<tr>"
					+ "<td>" + generateFT(rowJson.get("Stretching Exercise").toString(), ftOptions)+ "</td>"
					+ "<td>" + rowJson.get("Sets") + "</td>"
					+ "<td>" + rowJson.get("Hold (in sec)") + "</td>"
					+ "<td>" + generateVideoPart(rowJson.get("Video").toString())+"</td>"
					+ "</tr>";
		}
		
		html += "</tbody>"+ "</table>" + "</div>" + "</div>" ;
		html += "<div class='box grid_12'>"
				+ "<div class='form-row' style='text-align:right;'>"
				+ "<input type='submit' class='button green' value='save' >"
				//+ "<button  display='none' type='button' class='button green' onclick='addJson("+weeks+")' >Add Json</button>"
				+ "</div>"
				+ "</div>"+ "</form>";

		/***********************|      Design HTML       |**********************************/
		String htmlJson = new Gson().toJson(html);
		String weeksJson = new Gson().toJson(weeks);
		String modJson = new Gson().toJson(mod);
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		String allJSON = "[" + htmlJson + "," + weeksJson + "," + modJson +"]";
		response.getWriter().write(allJSON);
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
