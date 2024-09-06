package com.youth.market.admin.service;

import java.util.List;
import com.youth.market.admin.dto.Qa;

public interface QaService {
    // QA 리스트를 가져오는 메서드
    List<Qa> selectQaList(int startRow, int endRow);

    // QA 게시글 총 갯수를 가져오는 메서드
    int count();
    
    // 특정 QA 게시글을 가져오는 메서드
    Qa getQaById(int qaNo);
    
    // 새로운 QA 게시글을 작성하는 메서드
    int insert(Qa qs);
    
    // QA 게시글을 수정하는 메서드
    int update(Qa qa);
    
    // QA 게시글을 삭제하는 메서드
    int qaDeleteMember(int qaNo);




}
