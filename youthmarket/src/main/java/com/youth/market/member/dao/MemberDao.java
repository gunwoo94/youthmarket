package com.youth.market.member.dao;
import com.youth.market.member.dto.Member;
public interface MemberDao {
	Member select(String userId);
	int insert(Member member);

}
