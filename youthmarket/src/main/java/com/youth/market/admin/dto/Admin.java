package com.youth.market.admin.dto;

import lombok.Data;

@Data 

public class Admin {
	private int adminNo; // sql에서 varchar 되있는데 수정해야해요. 수정문 써놨어요 적용 하면 되요
	private String adminId;
	private String adminPassword;
	
}