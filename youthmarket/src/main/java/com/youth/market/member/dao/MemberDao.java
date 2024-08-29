package com.youth.market.member.dao;

import java.util.List;

import com.youth.market.member.dto.Member;

public interface MemberDao {
	Member select(String userId);

	Member selectEmail(String email);

	Member selectRP(String userName);

	int insert(Member member);

	List<Member> memberList(int startRow, int endRow);

	int count();

	int update(Member member);

	int delete(String userId);

	int updatePassword(Member member);


}
