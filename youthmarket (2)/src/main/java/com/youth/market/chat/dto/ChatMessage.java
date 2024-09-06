package com.youth.market.chat.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ChatMessage {

	private int chatNo;
	private int chatRoomNo;
	private int userNo;
	private String messegeContent;
	private Date createDate;
	private String readStatus;
	
	// 채팅 보낼때 객체	
	private String userName;
	
}
