package com.youth.market.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.youth.market.admin.dto.Notice;
import com.youth.market.member.dto.Member;

@Repository
public class NoticeDaoImpl implements NoticeDao {
	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public int insert(Notice notice) {

		return sst.insert("noticens.insert", notice);
	}

	@Override
	public int count() {
		return sst.selectOne("noticens.count");
	}

	@Override
	public List<Member> noticeList(int startRow, int endRow) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sst.selectList("noticens.noticeList", map);
	}

	@Override
	public int boardDelete(int noticeNo) {
		return sst.delete("noticens.adminBoardDelete", noticeNo);
	}

	@Override
	public int noticeDelete(int noticeNo) {
		return sst.delete("noticens.adminNoticeDelete", noticeNo);
	}
}
