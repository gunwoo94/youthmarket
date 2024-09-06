package com.youth.market.heart.service;

import java.util.HashMap;

import com.youth.market.heart.dto.Heart;
import com.youth.market.member.dto.Member;

public interface HeartService {
	//찜하기 추가	
	public void addHeart(Heart heart);
	
	public Member selectMem(Member m);

	public void minusListCount(HashMap<String, Object> map);

	public void deleteHeart(Heart heart);

	public int mypageDeleteHeart(HashMap<String, Object> map);

}
