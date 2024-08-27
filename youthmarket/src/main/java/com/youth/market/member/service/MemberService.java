package com.youth.market.member.service;

import java.util.List;

import com.youth.market.member.dto.Member;

public interface MemberService {
	Member select(String userId);

	Member selectEmail(String email);

	int insert(Member member);

	List<Member> memberList(int startRow, int endRow);

	int count();

	int update(Member member);

	int delete(String userId);

	int updatePassword(Member member);

}
