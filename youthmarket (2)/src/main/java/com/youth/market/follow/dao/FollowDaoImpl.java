package com.youth.market.follow.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.youth.market.follow.dto.Follow;

@Repository
public class FollowDaoImpl implements FollowDao {
	@Autowired
	private SqlSessionTemplate sst;
	
	
	//팔로우  리스트 조회
	@Override
	public List<Follow> selectFollowList(Follow follow) {
		
		return sst.selectList("followns.selectFollowList",follow);
	}
	//멤버 조회 
	@Override
	public Map<String, Object> selectMember(Follow follow) {
		
		return sst.selectOne("followns.selectMember",follow);
	}
	
	//팔로우 조회
	@Override
	public int selectFollow(Follow follow) {
		return sst.selectOne("followns.selectFollow",follow);
	}
	
	//팔로우 insert
	@Override
	public int insertFollow(Follow follow) {
		return sst.insert("followns.insertFollow",follow);
	}
	@Override
	public int deleteFollow(Follow follow) {
		// TODO Auto-generated method stub
		return sst.delete("followns.deleteFollow",follow);
	}
}
