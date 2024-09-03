package com.youth.market.report.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youth.market.member.dto.Member;
import com.youth.market.report.dto.Report;
import com.youth.market.report.service.ReportService;

@Controller
public class ReportController {
	@Autowired
	private ReportService rs;

	@PostMapping("/report/addReport")
	@ResponseBody
	public String addReport(HttpSession session,
			@RequestParam(value = "sellUserNo", required = false) Integer sellUserNo,
			@RequestParam(value = "purchaseUserNo", required = false) String purchaseUserNo,
			@RequestParam(value = "reportContent", required = false) String reportContent) {

		// 로그인 사용자 확인
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			return "로그인이 필요합니다.";
		}

		// sellUserNo가 null인 경우에 대한 기본 처리
		if (sellUserNo == null) {
			return "판매자 정보가 올바르지 않습니다.";
		}

		// purchaseUserNo가 빈 문자열인 경우 null로 처리
		if (purchaseUserNo == null || purchaseUserNo.trim().isEmpty()) {
			purchaseUserNo = null;
		}

		// 신고자 번호 설정
		int reporterNo = loginUser.getUserNo();

		// Report 객체 생성 및 필드 설정
		Report report = new Report();
		report.setReportContent(reportContent);
		report.setReporterNo(reporterNo);
		report.setReportedNo(sellUserNo); // sellUserNo를 reportedNo에 설정
		System.out.println("1" + reportContent);
		System.out.println("2" + reporterNo);
		System.out.println("3" + sellUserNo);
		// 신고 추가 처리
		int state = rs.addReport(report, sellUserNo, purchaseUserNo, reporterNo);
		System.out.println("Report: " + report);
		System.out.println("sellUserNo: " + sellUserNo);
		System.out.println("purchaseUserNo: " + purchaseUserNo);
		System.out.println("reporterNo: " + reporterNo);
		// 상태가 0이면 세션 정보를 제거
		if (state == 0) {
			session.removeAttribute("loginUser");
			if (session.getAttribute("access_Token") != null) {
				session.removeAttribute("access_Token");
			}
		}

		return String.valueOf(state);
	}

	// 사기조회 페이지
	@GetMapping("/report/reportSearch")
	public String reportSearch(Model model) {

		return "report/reportSearch";
	}

	// 사기조회 결과 페이지
	@GetMapping("/report/reportSearchResult")
	public String reportSearchResult(Model model,
			@RequestParam(value = "condition", required = false, defaultValue = "seller") String condition,
			@RequestParam(value = "search", required = false, defaultValue = "") String search) {

		List<Report> reList = rs.reportSearchResult(condition, search);
		int count = rs.selectListCount(condition, search);

		model.addAttribute("reportList", reList);
		model.addAttribute("search", search);
		model.addAttribute("condition", condition);
		model.addAttribute("count", count);

		return "report/reportSearchResult";
	}
}
