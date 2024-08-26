package com.youth.market.admin.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Notice {
	private int noticeNo;
	private String noticeType;
	private String noticeTitle;
	private String noticeWriter;
	private String noticeImg;
	private String noticeHit;
	private Date createDate;
	private int adminNo;
	
}
