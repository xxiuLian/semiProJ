package com.uni.event.model.dto;
import java.sql.Date;

public class EventDto {

	private int eventNo;
	private String eventTitle;
	private String eventContent;
	private String eventWriter;		
	private int count;
	private Date createDate;
	private String status;
	
	public EventDto() {
		
	}
	
	public EventDto(String eventTitle, String eventWriter, String eventContent) {
		this.eventTitle = eventTitle;
		this.eventWriter = eventWriter;
		this.eventContent = eventContent;
	}

	public EventDto(int eventNo, String eventTitle, String eventWriter, int count, Date createDate) {
		super();
		this.eventNo = eventNo;
		this.eventTitle = eventTitle;
		this.eventWriter = eventWriter;
		this.count = count;
		this.createDate = createDate;
	}

	public EventDto(int eventNo, String eventTitle, String eventContent, String eventWriter, int count, Date createDate) {
		super();
		this.eventNo = eventNo;
		this.eventTitle = eventTitle;
		this.eventContent = eventContent;
		this.eventWriter = eventWriter;
		this.count = count;
		this.createDate = createDate;
	}

	public int getEventNo() {
		return eventNo;
	}

	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}

	public String getEventTitle() {
		return eventTitle;
	}

	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}

	public String getEventContent() {
		return eventContent;
	}

	public void setEventContent(String eventContent) {
		this.eventContent = eventContent;
	}

	public String getEventWriter() {
		return eventWriter;
	}

	public void setEventWriter(String eventWriter) {
		this.eventWriter = eventWriter;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	

}

