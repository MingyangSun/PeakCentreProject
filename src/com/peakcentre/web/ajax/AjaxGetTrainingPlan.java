package com.peakcentre.web.ajax;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.peakcentre.web.dao.TrainingPlanDao;
import com.peakcentre.web.entity.TrainingPlan;
import com.peakcentre.web.dao.TestResultTemplateDao;

/**
 * Servlet implementation class AjaxGetTrainingPlan
 */
@WebServlet("/jsp/AjaxGetTrainingPlan")
public class AjaxGetTrainingPlan extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxGetTrainingPlan() {
        super();
        // TODO Auto-generated constructor stub
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
		
		
		TrainingPlanDao tpd = new TrainingPlanDao();
		TrainingPlan plan = tpd.getTrainingPlan(username, startDate, endDate);
		Map<String, String> allData = plan.getData();
		String weekData = allData.get("weekData");
		String st1 = allData.get("st1");
		String st2 = allData.get("st2");
		String ft = allData.get("ft");
		
		TestResultTemplateDao trpd = new TestResultTemplateDao();
		
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
		for(int i = 0; i < weeks; i++) {
			//HTML For Days
			if((i == weeks-1) && (mod !=0)) {
				html += "<div class='box grid_12'>";
				html += "<div class='box-head'>"
						+ "<h2>Training Plan - Week " + (i+1) + "</h2>"
						+ "</div>";
				html += "<div class='box-content no-pad'>";
				html += "<table id='mytable'>" + "<thead>" + "<tr>";
				String tmp = "</tr><tr>";
				ArrayList<String> keys = new ArrayList<String>();
				ArrayList<String> year = new ArrayList<String>();
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
					year.add(tempdate.getYear()+1900+"");
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
						if(!rowJson.get(keys.get(m)).toString().equals("") && !rowJson.get(keys.get(m)).toString().equals("off")) {
							String[] tempArray = rowJson.get(keys.get(m)).toString().split(" ");
							html += "<td onclick='showTR(\"" + keys.get(m) +"/" +  year.get(m) + "\",\""
								 +  trpd.getTempNameByAlias(tempArray[0]) +"\")'>" 
								 + rowJson.get(keys.get(m)).toString()+ "</td>";	
						} else {
							html += "<td>" + rowJson.get(keys.get(m)).toString()+ "</td>";
						}
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
				html += "<div class='box-content no-pad'>";
				html += "<table>" + "<thead>" + "<tr>";
				String tmp = "</tr><tr>";
				ArrayList<String> keys = new ArrayList<String>();
				ArrayList<String> year = new ArrayList<String>();
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
					year.add(tempdate.getYear()+1900+"");
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
						if(!rowJson.get(keys.get(m)).toString().equals("") && !rowJson.get(keys.get(m)).toString().equals("off")) {
							String[] tempArray = rowJson.get(keys.get(m)).toString().split(" ");
							html += "<td onclick='showTR(\"" + keys.get(m) +"/" +  year.get(m) + "\",\""
								 +  trpd.getTempNameByAlias(tempArray[0]) +"\")'>" 
								 + rowJson.get(keys.get(m)).toString()+ "</td>";	
						} else {
							html += "<td>" + rowJson.get(keys.get(m)).toString()+ "</td>";
						}
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
				+ "<table>" + "<thead>" + "<tr>"
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
				+ "<table>" + "<thead>" + "<tr>"
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
				+ "<table>" + "<thead>" + "<tr>"
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
			System.out.println("hh:"+rowJson.get("Stretching Exercise"));
			String s = rowJson.get("Stretching Exercise").toString();
			s = s.replaceAll(" ", "");
			System.out.println("s: " + s);
			String videoContent = rowJson.get("Video").toString();
			if(!videoContent.equals("No")) {
				String tempvideoname = videoContent.substring(4);
				String videoName = tempvideoname.replaceAll(" ", "-");
				videoContent = "<img src='../image/icons/basic/play.png' height='17px' weight='17px' onclick=showVideo('"+ videoName +"') />";
			}
			html += "<tr>"
					+ "<td onclick=showFTGraph('"+ s +"')>" + rowJson.get("Stretching Exercise") + "</td>"
					+ "<td>" + rowJson.get("Sets") + "</td>"
					+ "<td>" + rowJson.get("Hold (in sec)") + "</td>"
					+ "<td>" + videoContent + "</td>"
					+ "</tr>";
		}
		html += "</tbody>"+ "</table>" + "</div>" + "</div>";
		
		/***********************|      Design HTML       |**********************************/
		String htmlJson = new Gson().toJson(html);
		String weeksJson = new Gson().toJson(weeks);
		String modJson = new Gson().toJson(mod);
		String usernameJson = new Gson().toJson(username);
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
