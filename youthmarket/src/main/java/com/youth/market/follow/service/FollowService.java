package com.youth.market.follow.service;

import java.util.List;
import java.util.Map;

import com.youth.market.follow.dto.Follow;

public interface FollowService {
	//팔로우 리스트 조회
	List<Follow> selectFollowList(Follow follow);
	//팔로우 멤버 조회
	public Map<String, Object> selectMember(Follow follow);
	//팔로우 추가하는부분 
	int selectFollow(Follow follow);
	int insertFollow(Follow follow);
	//팔로우 삭제 
	int deleteFollow(Follow follow);

}
