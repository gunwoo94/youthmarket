package com.youth.market.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youth.market.admin.dao.NoticeDao;
import com.youth.market.admin.dto.Notice;
import com.youth.market.member.dto.Member;
@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDao nd;

	@Override
	public int insert(Notice notice) {

		return nd.insert(notice);
	}

	@Override
	public int count() {
		return nd.count();
	}

	@Override
	public List<Member> noticeList(int startRow, int endRow) {
		return nd.noticeList(startRow, endRow);
	}

	@Override
	public int boardDeleteMember(int noticeNo) {
		return nd.boardDelete(noticeNo);
	}

	@Override
	public int noticeDeleteMember(int noticeNo) {
		return nd.noticeDelete(noticeNo);
	}

	

	


}
