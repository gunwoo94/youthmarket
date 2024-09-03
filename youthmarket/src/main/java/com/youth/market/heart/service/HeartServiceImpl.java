package com.youth.market.heart.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youth.market.heart.dao.HeartDao;
import com.youth.market.heart.dto.Heart;
import com.youth.market.member.dto.Member;

@Service
public class HeartServiceImpl implements HeartService {
	@Autowired
	private HeartDao hd;


    @Override
    public void addHeart(Heart heart) {
        hd.addHeart(heart);
    }

    @Override
    public Member selectMem(Member m) {
        return hd.selectMem(m);
    }

    @Override
    public void minusListCount(HashMap<String, Object> map) {
        hd.minusListCount(map);
    }

    @Override
    public void deleteHeart(Heart heart) {
        hd.deleteHeart(heart);
    }
    
    
   
    public int mypageDeleteHeart(HashMap<String, Object> map) {
        return hd.mypageDeleteHeart(map);
    }

	

	
}
