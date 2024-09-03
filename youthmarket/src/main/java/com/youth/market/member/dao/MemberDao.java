package com.youth.market.member.dao;

import java.util.List;

import com.youth.market.heart.dto.Heart;
import com.youth.market.member.dto.Member;
import com.youth.market.sell.dto.Sell;

public interface MemberDao {
	Member select(String userId);

	Member selectEmail(String email);

	int insert(Member member);

	List<Member> memberList(int startRow, int endRow);

	int count();

	int update(Member member);

	int delete(String userId);

	int updatePassword(Member member);

	int adminBlockAccept(int userNo);

	int adminBlockCancel(int userNo);

	int adminDelete(int userNo);

	List<Member> blockList(int startRow, int endRow);

	int block_count();

	int sellCount(int userNo);

	int followCount(int userNo);

	int reportCount(int userNo);

	int marketOpen(int userNo);

	List<Sell> mypageSellList(int userNo);
	//신고 부분 멤버 
	Member selectUser(int reportedNo);
	//신고 부분 멤버 삭제 조건 
	int deleteMember(int reportedNo);
	//신고 부분 블랙리스트 추가.
	void insertBlackListUser(Member member);

	List<Heart> mypageHeartList(int userNo);
}
