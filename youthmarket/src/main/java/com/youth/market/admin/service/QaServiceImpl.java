package com.youth.market.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youth.market.admin.dto.Qa;
import com.youth.market.admin.dao.QaDao; // 또는 Mapper

@Service
public class QaServiceImpl implements QaService {

    @Autowired
    private QaDao qaDao; // QaDao를 Autowired로 주입 (또는 매퍼)

    @Override
    public List<Qa> selectQaList(int startRow, int endRow) {
    	return qaDao.selectQaList(startRow, endRow); // QA 리스트 가져오기
    }

    @Override
    public int count() {
        return qaDao.count(); // QA 게시글 총 갯수 가져오기
    }

    @Override
    public Qa getQaById(int qaNo) {
        return qaDao.selectQaById(qaNo); // 특정 QA 게시글 가져오기
    }

    @Override
    public int insert(Qa qa) {
        return qaDao.insertQa(qa); // 새로운 QA 게시글 작성
    }

    @Override
    public int update(Qa qa) {
        return qaDao.updateQa(qa); // QA 게시글 수정
    }

    @Override
    public int qaDeleteMember(int qaNo) {
        return qaDao.deleteQa(qaNo); // QA 게시글 삭제
    }

}
