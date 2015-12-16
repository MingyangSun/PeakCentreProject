package com.peakcentre.web.ajax;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.google.gson.Gson;
import com.peakcentre.web.config.GetFilePath;
import com.peakcentre.web.dao.TestResultDao;
import com.peakcentre.web.dao.TestResultTemplateDao;
import com.peakcentre.web.entity.ComparisonGraph;
import com.peakcentre.web.entity.TestResult;

/**
 * Servlet implementation class TestMultipleSelection
 */
@WebServlet("/jsp/TestMultipleSelection")
public class TestMultipleSelection extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestMultipleSelection() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//System.out.println("Date:" + request.getParameter("date1"));

		String date1 = request.getParameter("date1");
		System.out.println("Date: " + date1);
		String[] dates = date1.split("-");
		String templateName = request.getParameter("templateName");
		String username = request.getParameter("username");
		
		TestResultTemplateDao tdao = new TestResultTemplateDao();
		String html = "";
		String tempPath = tdao.getTempPathByName(templateName);
		File f = new File(GetFilePath.getBaseTemplatePath() + tempPath);

		Element element = null;
		int tableSequence = 1;
		DocumentBuilder db = null;
		DocumentBuilderFactory dbf = null;
		
		List<ComparisonGraph> l = new ArrayList<ComparisonGraph>();
		
		
		dbf = DocumentBuilderFactory.newInstance();
		try {
			db = dbf.newDocumentBuilder();

			Document dt = db.parse(f);
			element = dt.getDocumentElement();
			NodeList childNodes = element.getChildNodes();	
		
			//Get The Graph Part From the Template
			for (int n = 0; n < childNodes.getLength(); n++) {
				Node node1 = childNodes.item(n);
				if("img".equals(node1.getNodeName())) {
					//This is the graph part
					
					ComparisonGraph temp = new ComparisonGraph();
					
					int tableNumber = 1;
					String graphName = "graphName";
		
					NodeList nodeDetail = node1.getChildNodes();
		
					for (int j = 0; j < nodeDetail.getLength(); j++) {
						Node detail = nodeDetail.item(j);
						if ("col1".equals(detail.getNodeName())) {
							temp.setX(detail.getTextContent());
						} else if ("col2".equals(detail.getNodeName())) {
							temp.setY(detail.getTextContent());
						} else if ("tableNumber".equals(detail
								.getNodeName())) {
							tableNumber = Integer.parseInt(detail
									.getTextContent());
							temp.setTableName(tableNumber);
						} else if ("graphName".equals(detail.getNodeName())) {
							graphName = detail.getTextContent();
							temp.setGraphName(graphName);
						}
					}
					
					html += "<p><h3>" + graphName + "</h3></p><br>";
					html += "<div id='flot-lines" + tableNumber + "'>";
					html += "</div>";
					
					l.add(temp);
				}
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
				
		//Add Data
		TestResultDao trd = new TestResultDao();
		int tempId = tdao.getTempIdByName(templateName);
		
		/////////////////////////////
		for(ComparisonGraph cg : l) {
			String tableName = "" + cg.getTableName();
			String X = cg.getX();
			String Y = cg.getY();
			
			for(int i = 0; i < dates.length; i++) {
				if(dates[i].equals("average")) {
					//parse the average data
					List<List<Object>> r = trd.getAverage(username, tableName, tempId,X, Y);
					List<Object> index = r.get(0);
					List<Object> value = r.get(1);
					List tempX = new ArrayList();
					List tempY = new ArrayList();
					for(int j = 0; j < index.size(); j++) {
						tempX.add(index.get(j));
						tempY.add(value.get(j));
					}
					cg.setXValue("Average", tempX);
					cg.setYValue("Average", tempY);
				} else {
					Map<String, String> tempHM = trd.getTestResult(username, tempId, dates[i]).getData();
					String tempData = tempHM.get(tableName);
					List tempX = new ArrayList();
					List tempY = new ArrayList();
					try {
						JSONArray dataArray = new JSONArray(tempData);
						//Add data in specific date
						for(int j = 0; j < dataArray.length(); j++) {
							JSONObject json = dataArray.getJSONObject(j);
							tempX.add(json.get(X));
							tempY.add(json.get(Y));
						}
					}catch(Exception e) {
						e.printStackTrace();
					}
					cg.setXValue(dates[i], tempX);
					cg.setYValue(dates[i], tempY);
				}
			}
			
		}
		
		System.out.println("Html: " + html);
		String htmlJSON = new Gson().toJson(html);
		String allcgJSON = new Gson().toJson(l);
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		String bothJson = "[" + htmlJSON + "," + allcgJSON + "]";
		response.getWriter().write(bothJson);
		
	}

}
