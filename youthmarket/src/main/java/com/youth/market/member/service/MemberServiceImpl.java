package com.youth.market.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youth.market.heart.dto.Heart;
import com.youth.market.member.dao.MemberDao;
import com.youth.market.member.dto.Member;
import com.youth.market.sell.dto.Sell;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao md;

	public Member select(String userId) {
		return md.select(userId);
	}

	@Override
	public Member selectEmail(String email) {
		return md.selectEmail(email);
	}

	public int insert(Member member) {
		return md.insert(member);
	}

	@Override
	public List<Member> memberList(int startRow, int endRow) {
		return md.memberList(startRow, endRow);
	}

	@Override
	public int count() {
		return md.count();
	}

	@Override
	public int update(Member member) {
		return md.update(member);
	}

	@Override
	public int delete(String userId) {
		return md.delete(userId);
	}

	@Override
	public int updatePassword(Member member) {
		return md.updatePassword(member);
	}

	@Override
	public int adminBlockAccept(int userNo) {

		return md.adminBlockAccept(userNo);
	}

	@Override
	public int adminBlockCancel(int userNo) {
		return md.adminBlockCancel(userNo);
	}

	@Override
	public int deleteMember(int userNo) {
		return md.adminDelete(userNo);
	}

	@Override
	public List<Member> blockList(int startRow, int endRow) {

		return md.blockList(startRow, endRow);
	}

	@Override
	public int block_count() {
		return md.block_count();
	}

	@Override
	public int sellCount(int userNo) {
		return md.sellCount(userNo);
	}

	@Override
	public int followCount(int userNo) {
		return md.followCount(userNo);
	}

	@Override
	public int reportCount(int userNo) {
		return md.reportCount(userNo);
	}

	@Override
	public int marketOpen(int userNo) {
		return md.marketOpen(userNo);
	}

	@Override
	public List<Sell> mypageSellList(int userNo) {
		return md.mypageSellList(userNo);
	}

	@Override
	public List<Sell> mypageSellList2(int userNo) {
		return md.mypageSellList2(userNo);
	}

	@Override
	public List<Sell> mypageSellList3(int userNo) {
		return md.mypageSellList3(userNo);
	}

	@Override
	public List<Heart> mypageHeartList(int userNo) {
		// TODO Auto-generated method stub
		return md.mypageHeartList(userNo);
	}
}
