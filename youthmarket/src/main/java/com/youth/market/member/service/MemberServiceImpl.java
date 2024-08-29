package com.youth.market.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youth.market.member.dao.MemberDao;
import com.youth.market.member.dto.Member;

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

	@Override
	public Member selectRP(String userName) {
		return md.selectRP(userName);
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

}
