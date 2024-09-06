package com.youth.market.report.dao;

import java.util.HashMap;
import java.util.List;

import com.youth.market.report.dto.Report;

public interface ReportDao {

	int selectListCount(HashMap<String, Object> map);

	List<Report> reportSearchResult(HashMap<String, Object> map);

	int addReport(Report report);

	int selectReportCount(Report report);



}
