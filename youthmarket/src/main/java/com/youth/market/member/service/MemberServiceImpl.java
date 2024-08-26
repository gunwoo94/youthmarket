package com.youth.market.member.service;

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
	public int insert(Member member) {
		return md.insert(member);
	}
}
