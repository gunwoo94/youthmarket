package com.youth.market.admin.dao;

import java.util.List;
import java.util.Map;

import com.youth.market.admin.dto.Notice;
import com.youth.market.member.dto.Member;

public interface NoticeDao {
   // 공지사항 작성
   int insert(Notice notice);
   // Notice 객체를 데이터베이스에 삽입하는 메서드입니다.
   // 입력된 공지사항 데이터를 DB에 저장합니다.

   // 공지사항 리스트 불러오기 (페이징 처리)
   List<Notice> noticeList(int startRow, int endRow);
   // 지정된 범위(startRow에서 endRow) 내의 공지사항 목록을 반환하는 메서드입니다.
   // 페이징 처리를 위해 startRow와 endRow를 파라미터로 받습니다.

   // 공지사항 수 카운트
   int count();

   // 공지사항 삭제
   int noticeDelete(int noticeNo);

   public int boardDelete(int noticeNo);

   Notice selectNoticeByNo(int noticeNo);

    // 검색 조건에 따라 공지사항 리스트를 반환하는 메서드
    List<Notice> searchNotices(Map<String, Object> searchParams, int offset, int pageSize);

   int getTotalCount(Map<String, Object> searchParams);

   void increaseNoticeHit(int noticeNo);
    
   // 공지사항 수정
    int updateNotice(int noticeNo); 
    
    // Notice 객체를 데이터베이스에서 수정하는 메서드입니다.
    // 전달된 Notice 객체의 정보를 바탕으로 DB에서 해당 공지사항을 수정합니다.
}