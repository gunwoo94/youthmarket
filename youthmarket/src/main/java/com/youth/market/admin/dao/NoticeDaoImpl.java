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
   // MyBatis와의 통신을 위한 SqlSessionTemplate 객체 주입
   private SqlSessionTemplate sst;

   @Override
   public int insert(Notice notice) {
      // MyBatis 매퍼 파일의 "noticens.insert" 쿼리를 실행하여
      // Notice 객체를 DB에 삽입하고, 삽입된 행의 수를 반환합니다
      return sst.insert("noticens.insert", notice);
   }

   @Override
   public int count() {
      return sst.selectOne("noticens.count");
   }

   @Override
   public List<Notice> noticeList(int startRow, int endRow) {
      // 공지사항 목록을 페이징 처리하여 불러오기 위해 매퍼로 전달할 파라미터를 설정합니다.
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("startRow", startRow);
      map.put("endRow", endRow);
      // MyBatis 매퍼 파일의 "noticens.noticeList" 쿼리를 실행하여
      // 해당 범위의 공지사항 목록을 반환합니다.
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

   @Override
   public Notice selectNoticeByNo(int noticeNo) {
      // 공지사항을 noticeNo로 조회하여 반환하는 메서드
      return sst.selectOne("noticens.selectNoticeByNo", noticeNo);
   }

   /*
    * @Override public List<Notice> searchNotices(Map<String, Object> searchParams)
    * { return sst.selectList("noticens.searchNotices", searchParams); }
    */
   @Override
   public List<Notice> searchNotices(Map<String, Object> searchParams, int offset, int pageSize) {
        Map<String, Object> params = new HashMap<>(searchParams);
          params.put("offset", offset);
          params.put("pageSize", pageSize);
          return sst.selectList("noticens.searchNotices", params);
   }

   @Override
   public int getTotalCount(Map<String, Object> searchParams) {
       return sst.selectOne("noticens.getTotalCount", searchParams);
   }

   public void increaseNoticeHit(int noticeNo) {
       // MyBatis 매퍼 파일의 "noticens.increaseNoticeHit" 쿼리를 실행하여
       // 해당 공지사항의 조회수를 1 증가시킵니다.
       sst.update("noticens.increaseNoticeHit", noticeNo);
   }

   // 공지사항 수정 메소드 추가
    @Override
    public int updateNotice(int noticeNo) {
        // 공지사항을 수정합니다.
        return sst.update("noticens.updateNotice", noticeNo);
    }
}
