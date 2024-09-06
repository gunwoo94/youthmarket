package com.youth.market.recent.dto;


import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Recent {

	private int recentNo;
	private int sellNo;
	private int userNo;
	private String createDate;
	private String imgSell;
	
}