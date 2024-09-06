package com.youth.market.member.dto;

import java.sql.Date;

import com.youth.market.sell.dto.Sell;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Mypage {
	
	private int sellNo;	
	private int reportNo;
	private int fwId;
	private int userNo;	
	private Date createDate;
	private String status;
	private String sellTitle;
	private String sellStatus;

}