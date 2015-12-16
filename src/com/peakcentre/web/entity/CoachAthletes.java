package com.peakcentre.web.entity;

public class CoachAthletes {
	private String coachName;
	private String athName;
	private String coachId;
	private String athId;
	
	public CoachAthletes(String coachId, String athId) {
		super();
		this.coachId = coachId;
		this.athId = athId;
	}
	
	public CoachAthletes(String coachName, String athName, String coachId, String athId) {
		super();
		this.coachName = coachName;
		this.athName = athName;
		this.coachId = coachId;
		this.athId = athId;
	}
	public String getCoachName() {
		return coachName;
	}
	public void setCoachName(String coachName) {
		this.coachName = coachName;
	}
	public String getAthName() {
		return athName;
	}
	public void setAthName(String athName) {
		this.athName = athName;
	}
	public String getCoachId() {
		return coachId;
	}
	public void setCoachId(String coachId) {
		this.coachId = coachId;
	}
	public String getAthId() {
		return athId;
	}
	public void setAthId(String athId) {
		this.athId = athId;
	}

}
