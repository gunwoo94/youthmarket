package com.youth.market.chat.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Block {

	private int blockNo;
	private int blockerNo;	// 차단한 사람
	private int blockedNo;	// 차단당한 사람
	
	
	
	private int userNo;
	private int chatRoomNo;
	/*
	 * private int avg; //전체 거래 평점의 평균값
	 */}
