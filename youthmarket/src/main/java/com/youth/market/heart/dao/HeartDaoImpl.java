package com.youth.market.heart.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.youth.market.heart.dto.Heart;
import com.youth.market.member.dto.Member;

@Repository
public class HeartDaoImpl implements HeartDao {
	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public void addHeart(Heart heart) {
		sst.insert("heartns.addHeart",heart);
	}

	@Override
	public void minusListCount(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		sst.update("heartns.minusListCount",map);
	}

	@Override
	public void deleteHeart(Heart heart) {
		// TODO Auto-generated method stub
		sst.delete("heartns.deleteHeart",heart);
	}

	@Override
	public Member selectMem(Member m) {
		return sst.selectOne("memberns.selectMem",m);
		
	}

	@Override
	public int mypageDeleteHeart(HashMap<String, Object> map) {
		return sst.delete("heartns.mypageDeleteHeart",map);
		
	}
	
}
