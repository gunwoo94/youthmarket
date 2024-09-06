package com.youth.market.report.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.youth.market.report.dto.Report;

@Repository
public class ReportDaoImpl implements ReportDao {
	@Autowired
	private SqlSessionTemplate sst;
	//신고 횟수 
	@Override
	public int selectListCount(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return sst.selectOne("reportns.selectListCount", map);
	}
	//신고페이지 검색 결과 
	@Override
	public List<Report> reportSearchResult(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return sst.selectList("reportns.reportSearchResult",map);
	}
	//신고 하기 추가 
	@Override
	public int addReport(Report report) {
		// TODO Auto-generated method stub
		return sst.insert("reportns.addReport",report);
	}
	//신고 횟수 카운트 = 
	@Override
	public int selectReportCount(Report report) {
		// TODO Auto-generated method stub
		return sst.selectOne("reportns.selectReportCount",report);
	}

}
