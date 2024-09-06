package com.youth.market.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.youth.market.admin.dto.Qa;
import com.youth.market.admin.service.QaService;

@Repository
public class QaDaoImpl implements QaDao {

    @Autowired
    private SqlSessionTemplate sst;  // MyBatis와의 통신을 위한 SqlSessionTemplate 객체 주입

    @Override
    public List<Qa> selectQaList(int startRow, int endRow) {
        // QA 목록을 페이징 처리하여 불러오기 위해 매퍼로 전달할 파라미터를 설정합니다.
        Map<String, Object> map = new HashMap<>();
        map.put("startRow", startRow);
        map.put("endRow", endRow);
        // MyBatis 매퍼 파일의 "qans.selectQaList" 쿼리를 실행하여
        // 해당 범위의 QA 목록을 반환합니다.
        return sst.selectList("qans.selectQaList", map);
    }

    @Override
    public int count() {
        // 총 QA 게시글 수를 반환하는 메서드
        return sst.selectOne("qans.count");
    }

    @Override
    public Qa selectQaById(int qaNo) {
        // 특정 QA 게시글을 qaNo로 조회하여 반환하는 메서드
        return sst.selectOne("qans.selectQaById", qaNo);
    }

    @Override
    public int insertQa(Qa qa) {
        // 새로운 QA 게시글을 삽입하는 메서드
        return sst.insert("qans.insertQa", qa);
    }

    @Override
    public int updateQa(Qa qa) {
        // 기존 QA 게시글을 수정하는 메서드
        return sst.update("qans.updateQa", qa);
    }

    @Override
    public int deleteQa(int qaNo) {
        // 특정 QA 게시글을 삭제하는 메서드
        return sst.delete("qans.deleteQa", qaNo);
    }

}
