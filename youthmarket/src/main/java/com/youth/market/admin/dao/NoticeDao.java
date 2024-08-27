package com.youth.market.admin.dao;

import java.util.List;

import com.youth.market.admin.dto.Notice;
import com.youth.market.member.dto.Member;

public interface NoticeDao {

	public int insert(Notice notice);

	public int count();

	public List<Member> noticeList(int startRow, int endRow);

	public int boardDelete(int noticeNo);

	public int noticeDelete(int noticeNo);

}
