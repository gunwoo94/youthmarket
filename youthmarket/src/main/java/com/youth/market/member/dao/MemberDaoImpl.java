package com.youth.market.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.youth.market.member.dto.Member;

@Repository
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private SqlSessionTemplate sst;
	public Member select(String userId) {
		return sst.selectOne("memberns.select", userId);
	}
	public int insert(Member member) {
		return sst.insert("memberns.insert", member);
	}
}
