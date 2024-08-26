package com.youth.market.member.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Member {
	private int userNo;
	private String userId;
	private String userPassword;
	private String userName;
	private String phone;
	private String birth;
	private String email;
	private int count;
	private Date createDate;
	private String status; //가입 여부 
	private int heartCount;
	private String blackList; //블랙리스트 유무 
	private String account;
	private int reportCount; //신고 당한 횟수 

}
