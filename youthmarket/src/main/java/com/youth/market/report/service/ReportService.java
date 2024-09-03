package com.youth.market.report.service;

import java.util.List;

import com.youth.market.report.dto.Report;

public interface ReportService {
	
	
	/* 신고 검색 결과 */
	List<Report> reportSearchResult(String condition, String search);
	// 신고 카운트 
	int selectListCount(String condition, String search);
	// 신고 추가 
	int addReport(Report report, int sellUserNo, String purchaseUserNo, int reporterNo);

}
