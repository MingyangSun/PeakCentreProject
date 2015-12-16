package com.peakcentre.web.entity;

import java.util.*;

public class ComparisonGraph {
	String graphName;
	int tableName;
	String x;
	String y;
	public Map<String, List> xValues = new HashMap<String, List>();
	public Map<String, List> yValues = new HashMap<String, List>();
	
	public int getTableName() {
		return this.tableName;
	}
	
	public String getX() {
		return this.x;
	}
	
	public String getY() {
		return this.y;
	}
	
	public void setGraphName(String graphName) {
		this.graphName = graphName;
	}
	
	public void setTableName(int tableName) {
		this.tableName = tableName;
	}
	
	public void setX(String x) {
		this.x = x;
	}
	
	public void setY(String y) {
		this.y = y;
	}
	
	public void setXValue(String d, List v) {
		this.xValues.put(d, v);
	}
	
	public void setYValue(String d, List v) {
		this.yValues.put(d, v);
	}
	
	public List getXValue(String d) {
		return this.xValues.get(d);
	}
	
	public List getYValue(String d) {
		return this.yValues.get(d);
	}
}
