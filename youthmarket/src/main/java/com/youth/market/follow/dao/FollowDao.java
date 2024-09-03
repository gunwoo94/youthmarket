package com.youth.market.follow.dao;

import java.util.List;
import java.util.Map;

import com.youth.market.follow.dto.Follow;

public interface FollowDao {
	//팔로우 리스트 조회
	List<Follow> selectFollowList(Follow follow);
	//팔로우 회원 조회
	Map<String, Object> selectMember(Follow follow);
	//팔로우 추가하는 부분 
	int selectFollow(Follow follow);

	int insertFollow(Follow follow);
	//팔로우 삭제 
	int deleteFollow(Follow follow); 

}
