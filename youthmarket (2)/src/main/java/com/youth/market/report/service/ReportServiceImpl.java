package com.youth.market.report.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youth.market.member.dao.MemberDao;
import com.youth.market.member.dto.Member;
import com.youth.market.report.dao.ReportDao;
import com.youth.market.report.dto.Report;

@Service
public class ReportServiceImpl implements ReportService {
	@Autowired
	private ReportDao rd;
	private MemberDao md;

	// 신고 카운트 조회
	@Override
	public int selectListCount(String condition, String search) {
 
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("search", search);

		return rd.selectListCount(map);
	}

	// 신고 리스트 조회
	@Override
	public List<Report> reportSearchResult(String condition, String search) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("condition", condition);
		map.put("search", search);

		return rd.reportSearchResult(map);
	}

	@Override
	public int addReport(Report report, int sellUserNo, String purchaseUserNo, int reporterNo) {
	
		// 신고자 번호를 설정
		report.setReporterNo(reporterNo);
		int state = 1;

		// 신고자와 판매자가 같은 경우
		if (reporterNo == sellUserNo) {
			report.setReportedNo(Integer.parseInt(purchaseUserNo));
		} else {
			// 신고자와 구매자가 같은 경우
			report.setReportedNo(sellUserNo);
		}

		// 신고 추가
		int result = rd.addReport(report);

		// 성공적으로 신고된 경우
		if (result > 0) {
			// 신고 횟수 조회
			int reportCount = rd.selectReportCount(report);

			// 신고 횟수가 5번 이상인 경우
			if (reportCount >= 5) {
				// 신고당한 사용자 정보를 가져옴
				Member member = md.selectUser(report.getReportedNo());
				System.out.println(report.getReportContent()); 
				// 사용자 삭제 처리
				int deleteSuccess = md.deleteMember(report.getReportedNo());

				// 삭제 성공 시 블랙리스트에 추가
				if (deleteSuccess > 0) {
					md.insertBlackListUser(member);
					state = 0; // 블랙리스트에 추가된 경우
				}
			}
		}  
	
		// state가 1이면 신고만 된 상태, 0이면 블랙리스트에 추가된 상태
		return state;
	}

}
