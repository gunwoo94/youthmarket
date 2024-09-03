package com.youth.market.heart.dao;

import java.util.HashMap;

import com.youth.market.heart.dto.Heart;
import com.youth.market.member.dto.Member;

public interface HeartDao {

	void addHeart(Heart heart);

	void minusListCount(HashMap<String, Object> map);

	void deleteHeart(Heart heart);

	Member selectMem(Member m);

	int mypageDeleteHeart(HashMap<String, Object> map);


}
