package com.youth.market.follow.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberFollow {
	
	private int userNo;
	private Date marketOpen;
	private int sellCount;
	private int followCount;
	private int repoterCount;

}
