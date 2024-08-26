package com.youth.market.member.service;
import com.youth.market.member.dto.Member;
public interface MemberService {
	Member select(String userId);
	int insert(Member member);

}
