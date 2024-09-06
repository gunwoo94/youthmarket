package com.youth.market.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youth.market.admin.dao.NoticeDao;
import com.youth.market.admin.dto.Notice;
@Service
public class NoticeServiceImpl implements NoticeService {
   @Autowired
   private NoticeDao nd;
   // NoticeDao 주입

   @Override
   public int insert(Notice notice) {
      // NoticeDao의 insert 메서드를 호출하여 Notice 객체를 DB에 삽입합니다.
      return nd.insert(notice);
   }

   // 공지사항 리스트를 불러오는 메서드 구현 (페이징 처리)
   @Override
   public List<Notice> noticeList(int startRow, int endRow) {
      // NoticeDao의 noticeList 메서드를 호출하여
      // 지정된 범위 내의 공지사항 목록을 반환합니다.
      return nd.noticeList(startRow, endRow);
   }
   
   @Override
   public int count() {
      return nd.count();
   }


   @Override
   public int boardDeleteMember(int noticeNo) {
      return nd.boardDelete(noticeNo);
   }

   @Override
   public int noticeDeleteMember(int noticeNo) {
      return nd.noticeDelete(noticeNo);
   }

   @Override
   public Notice getNoticeByNo(int noticeNo) {
        return nd.selectNoticeByNo(noticeNo);
   }

   /*
    * @Override public List<Notice> searchNotices(Map<String, Object> searchParams)
    * { return nd.searchNotices(searchParams); }
    */
   @Override
   public List<Notice> searchNotices(Map<String, Object> searchParams, int offset, int pageSize) {
      // TODO Auto-generated method stub
      return nd.searchNotices(searchParams, offset, pageSize);
   }

   @Override
   public int getTotalCount(Map<String, Object> searchParams) {
      // TODO Auto-generated method stub
      return nd.getTotalCount(searchParams);
   }

   @Override
   public void increaseNoticeHit(int noticeNo) {
      nd.increaseNoticeHit(noticeNo);
      
   }

   @Override
    public int updateNotice(int noticeNo) {
        return nd.updateNotice(noticeNo);
    }



}
 

