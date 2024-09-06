package com.youth.market.sell.dto;

import java.sql.Date;
import java.util.ArrayList;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.youth.market.common.Time;

/*import com.kh.tresure.common.Time;*/

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Sell {

	private int sellNo;
	private String sellTitle;
	private String sellContent;
	private String imgSell;
	private int count;
	private int price;
	private String sellStatus;
	private Date createDate;
	private Date updateDate;
	private String status;
	private int heartNum;
	private int userNo;
	private int categoryNo;
	// upload용
	private MultipartFile upfile;

	// 채팅방 상세보기
	private int chatRoomNo;
	private String categoryName;
	private double avg;
	private int negoPrice;
	private String negoStatus;
	private String account;
	private String bank;

	// 상품 상세조회 추가사항
	private int report_Num;
	private int follower_Num;
	private int sell_Num;
	private int follow_Is;
	private int heart_Is;

	private String rev_is;

	private String timeago;

	/*
//	 * private List<SellImg> imgList;
	 * 
	 * 
	 */
	public String getTimeago() {
		return timeago;
	}

	public void setTimeago(Date createDate) {
		this.timeago = Time.calculateTime(createDate);
	}

}
