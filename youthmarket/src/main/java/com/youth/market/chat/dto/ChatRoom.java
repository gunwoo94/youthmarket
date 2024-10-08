package com.youth.market.chat.dto;

import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ChatRoom {

   @DateTimeFormat(pattern = "yyyy/MM/dd HH:mm")
   private int chatRoomNo; //채팅방 번호
   private int userNo; // 채팅신청한 유저번호(구매자 유저번호)
   private int sellNo; // 판매상품 번호
   private String status; //채팅방 상태유무
   private Date createDate; //채팅방 만든 시간
   
   
   
   
   
	/*
	 * private int sellUserNo; // 판매한 유저번호 private Timestamp chatDate; //대화한 시간
	 * private double avg; // 판매자의평점 private String sellTitle; //상품제목 private double
	 * purchaseUserAvg; // 구매자의 평점
	 */}

