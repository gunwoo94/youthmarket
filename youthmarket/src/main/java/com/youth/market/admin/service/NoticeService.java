package com.youth.market.admin.service;

import java.util.List;

import com.youth.market.admin.dto.Notice;
import com.youth.market.member.dto.Member;

public interface NoticeService {

	int insert(Notice notice);

	int count();

	List<Member> noticeList(int startRow, int endRow);

	int boardDeleteMember(int noticeNo);

	int noticeDeleteMember(int noticeNo);
	

}
