package com.youth.market.admin.service;

import java.util.List;
import java.util.Map;

import com.youth.market.admin.dto.Notice;

public interface NoticeService {

   // 공지사항 작성 메서드
   int insert(Notice notice);
   // Notice 객체를 데이터베이스에 삽입하는 메서드입니다.

   // 공지사항 리스트를 불러오는 메서드 (페이징 처리)
   List<Notice> noticeList(int startRow, int endRow);
   // 지정된 범위(startRow에서 endRow) 내의 공지사항 목록을 반환하는 메서드입니다.

   // 공지사항 수 카운트
   int count();

   int boardDeleteMember(int noticeNo);

   int noticeDeleteMember(int noticeNo);

   Notice getNoticeByNo(int noticeNo);

    // 검색 조건에 따라 공지사항 리스트를 반환하는 메서드
    List<Notice> searchNotices(Map<String, Object> searchParams, int offset, int pageSize);

   int getTotalCount(Map<String, Object> searchParams);

   void increaseNoticeHit(int noticeNo);
   
    // 공지사항 수정
    int updateNotice(int noticeNo);
    // Notice 객체를 받아서 데이터베이스에서 해당 공지사항을 수정하는 메서드입니다.


   
}