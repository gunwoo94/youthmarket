package com.youth.market.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youth.market.member.dto.Member;
import com.youth.market.member.service.MemberService;
@Controller
public class MemberController {
	@Autowired
	private MemberService ms;
	@Autowired
	private BCryptPasswordEncoder bpe;
	@PostMapping("member/join.do")
	public void join(Member member, Model model) {
		int result = 0;
		String encPass = bpe.encode(member.getUserPassword());
		member.setUserPassword(encPass);
		Member member2 = ms.select(member.getUserId());
		if (member2 == null)  result = ms.insert(member);
		else result = -1; // 중복된 데이터
		model.addAttribute("result", result);
	}
	@GetMapping("member/loginForm")	
	public void loginForm() {	}
	@GetMapping("member/joinForm")
	public void joinForm() {	}
	@PostMapping(value = "member/idChk", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String idChk(String userId) {
		Member member = ms.select(userId);
		String data = "";
		if (member != null) {
			data = "이미 사용하는 아이디입니다";
		} else data = "사용 가능한 아이디입니다";
		return data;
	}
	
}
