package com.youth.market.follow.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youth.market.follow.dao.FollowDao;
import com.youth.market.follow.dto.Follow;

@Service
public class FollowServiceImpl implements FollowService {
	@Autowired
	private FollowDao fd;

	@Override
	public List<Follow> selectFollowList(Follow follow) {

		return fd.selectFollowList(follow);
	}

	@Override
	public Map<String, Object> selectMember(Follow follow) {
		// TODO Auto-generated method stub
		return fd.selectMember(follow);
	}

	@Override
	public int selectFollow(Follow follow) {
		// TODO Auto-generated method stub
		return fd.selectFollow(follow);
	}

	@Override
	public int insertFollow(Follow follow) {
		// TODO Auto-generated method stub
		return fd.insertFollow(follow);
	}

	@Override
	public int deleteFollow(Follow follow) {
		// TODO Auto-generated method stub
		return fd.deleteFollow(follow);
	}

}  
