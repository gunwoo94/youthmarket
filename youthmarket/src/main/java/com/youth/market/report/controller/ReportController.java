package com.youth.market.report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.youth.market.member.dto.Member;
import com.youth.market.member.service.MemberService;

@Controller
public class ReportController {
	@Autowired
	private MemberService ms;

	@GetMapping("/report/reportSearchForm")
	public void reportSearchForm() {

	}

	@PostMapping(value = "/report/reportSearch")
	public void reportSearch(Model model, String userName, Member member) {
		int result = 0;
		Member member2 = ms.selectRP(member.getUserName());
		if (member2 == null) {
			result = -1;
		} else {
			result = 1;
		}
		System.out.println(result);
		model.addAttribute("result", result);
		model.addAttribute("member", member);
	}

	@GetMapping("/report/reportSearchResult")
	public void reportSearchResult(Model model, String userName) {
		Member member = ms.selectRP(userName);
		model.addAttribute("member", member);
	}
}
