package com.youth.market.admin.dao;

import java.util.List;
import com.youth.market.admin.dto.Qa;
import com.youth.market.admin.service.QaService;

public interface QaDao {
    // QA 리스트를 가져오는 메서드
    List<Qa> selectQaList(int startRow, int endRow);

    // QA 게시글 총 갯수를 가져오는 메서드
    int count();

    // 특정 QA 게시글을 가져오는 메서드
    Qa selectQaById(int qaNo);

    // 새로운 QA 게시글을 작성하는 메서드
    int insertQa(Qa qa);

    // QA 게시글을 수정하는 메서드
    int updateQa(Qa qa);

    // QA 게시글을 삭제하는 메서드

	int deleteQa(int qaNo);

}
