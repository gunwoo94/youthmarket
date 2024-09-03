package com.youth.market.member.service;

import java.util.List;

import com.youth.market.member.dto.Member;

public interface MemberService {
	Member select(String userId);

	Member selectEmail(String email);

	int insert(Member member);

	Member selectRP(String userName);

	List<Member> memberList(int startRow, int endRow);

	int count();

	int update(Member member);

	int delete(String userId);

	int updatePassword(Member member);

	int adminBlockAccept(int userNo);

	int adminBlockCancel(int userNo);

	int deleteMember(int userNo);

	List<Member> blockList(int startRow, int endRow);

	int block_count();
<<<<<<< HEAD
=======

	int sellCount(int userNo);

	int followCount(int userNo);

	int reportCount(int userNo);

	int marketOpen(int userNo);

	List<Sell> mypageSellList(int userNo);

	List<Sell> mypageSellList2(int userNo);

	List<Sell> mypageSellList3(int userNo);
>>>>>>> stash
}
