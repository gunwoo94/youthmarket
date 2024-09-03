package com.youth.market.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.youth.market.member.dto.Member;
import com.youth.market.sell.dto.Sell;

@Repository
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private SqlSessionTemplate sst;

	public Member select(String userId) {
		return sst.selectOne("memberns.select", userId);
	}

	@Override
	public Member selectEmail(String email) {
		return sst.selectOne("memberns.selectEmail", email);
	}

	@Override
	public Member selectRP(String userName) {
		return sst.selectOne("memberns.selectRP", userName);
	}

	public int insert(Member member) {
		return sst.insert("memberns.insert", member);
	}

	@Override
	public List<Member> memberList(int startRow, int endRow) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sst.selectList("memberns.memberList", map);
	}

	@Override
	public int count() {
		return sst.selectOne("memberns.count");
	}

	@Override
	public int update(Member member) {
		return sst.update("memberns.update", member);
	}

	@Override
	public int delete(String userId) {
		return sst.delete("memberns.delete", userId);
	}

	@Override
	public int updatePassword(Member member) {
		return sst.update("memberns.updatePassword", member);
	}

	@Override
	public int adminBlockAccept(int userNo) {

		return sst.update("memberns.adminBlockAccept", userNo);
	}

	@Override
	public int adminBlockCancel(int userNo) {
		return sst.update("memberns.adminBlockCancel", userNo);
	}

	@Override
	public int adminDelete(int userNo) {
		return sst.delete("memberns.adminUserDelete", userNo);
	}

	@Override
	public List<Member> blockList(int startRow, int endRow) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sst.selectList("memberns.blockList", map);
	}

	public int block_count() {
		return sst.selectOne("memberns.block_count");
	}

	@Override
	public int sellCount(int userNo) {
		return sst.selectOne("memberns.sellCount", userNo);
	}

	@Override
	public int followCount(int userNo) {
		return sst.selectOne("memberns.followCount", userNo);
	}

	@Override
	public int reportCount(int userNo) {
		return sst.selectOne("memberns.reportCount", userNo);
	}

	@Override
	public int marketOpen(int userNo) {
		return sst.selectOne("memberns.marketOpen", userNo);
	}

	@Override
	public List<Sell> mypageSellList(int userNo) {
		return sst.selectList("sellns.mypageSellList", userNo);
	}

	@Override
	public List<Sell> mypageSellList2(int userNo) {
		return sst.selectList("sellns.mypageSellList2", userNo);
	}

	@Override
	public List<Sell> mypageSellList3(int userNo) {
		return sst.selectList("sellns.mypageSellList3", userNo);
	}

}
