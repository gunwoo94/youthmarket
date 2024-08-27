package com.youth.market.admin.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youth.market.admin.dto.Admin;
import com.youth.market.admin.service.AdminService;
import com.youth.market.admin.service.NoticeService;
import com.youth.market.admin.service.PageBean;
import com.youth.market.member.dto.Member;
import com.youth.market.member.service.MemberService;

@Controller
public class AdminController {
	@Autowired
	private AdminService as;
	@Autowired
	private MemberService ms;
	@Autowired 
	private NoticeService ns;
	
	@GetMapping("admin/adminLogout")
	public void adminLogout(HttpSession session) {
		session.invalidate();
	}
	@PostMapping ("admin/adminLogin")
	public void adminLogin(String adminId, String adminPassword, Model model, HttpSession session) {
		int result = 0;
		Admin admin = as.loginChk(adminId);
		System.out.println("admin = "+admin);
		if (admin != null && adminPassword.equals(admin.getAdminPassword())) {
			session.setAttribute("adminId", adminId);
			result = 1;
			
		}
		model.addAttribute("result", result);
	}
	
	/*
	 * ajax 기능 사용
	 * 
	 * @PostMapping , @ResponseBody, public int, model.addAttribute, return ~;
	 */
	@PostMapping("admin/adminBlockAccept") 
	@ResponseBody
	public int adminBlockAccept(@RequestParam("userNo") int userNo, Model model) {
		
		int result = 0;
		result = ms.adminBlockAccept(userNo);
		model.addAttribute("result", result);
		return result;
		
	}
	@PostMapping("admin/adminBlockCancel")
	@ResponseBody
	public int adminBlockCancel(@RequestParam("userNo") int userNo, Model model) {
		int result = 0;
		result = ms.adminBlockCancel(userNo);
		model.addAttribute("result", result);
		return result;
	}
	@PostMapping("admin/adminDelete")
	@ResponseBody
	public int adminDelete(@RequestParam("userNo") int userNo, Model model) {
		int result = 0;
		result = ms.deleteMember(userNo);
		model.addAttribute("result", result);
		return result;
	}
		
	@GetMapping("admin/adminUser")
	public void adminUser(String pageNum, Model model) {
		int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1)* rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		List<Member> memberList = ms.memberList(startRow, endRow);
		int total = ms.count();
		int count = total - startRow + 1;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);

		model.addAttribute("count", count);
		model.addAttribute("memberList", memberList);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("memberList", memberList);
		model.addAttribute("pb", pb);

	}
	@GetMapping("admin/adminLoginForm")
	public void adminLoginForm() {
		
	}
	@GetMapping("admin/adminNoticeWriteForm")
	public void adminNoticeWriteFrom() {
		
	}
	
	@GetMapping("admin/adminBoard")	
		public void adminBoard(String pageNum, Model model) {
			int rowPerPage = 10;
			if (pageNum == null || pageNum.equals("")) pageNum = "1";
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1)* rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			List<Member> noticeList = ns.noticeList(startRow, endRow);
			int total = ns.count();
			int count = total - startRow + 1;
			PageBean pb = new PageBean(currentPage, rowPerPage, total);
			
			model.addAttribute("count", count);
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("noticeList", noticeList);
			model.addAttribute("pb", pb);
	}
	
	@GetMapping("admin/adminNotice")
	public void adminNotice(String pageNum, Model model) {
		int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1)* rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		List<Member> noticeList = ns.noticeList(startRow, endRow);
		int total = ns.count();
		int count = total - startRow + 1;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		
		model.addAttribute("count", count);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pb", pb);
}
	@PostMapping("admin/adminBoardDelete")
	@ResponseBody
		public int adminBoardDelete(@RequestParam("noticeNo") int noticeNo, Model model) {
			int result = 0;
			result = ns.boardDeleteMember(noticeNo);
			model.addAttribute("result", result);
			return result;
}
	@PostMapping("admin/adminNoticeDelete")
	@ResponseBody
		public int adminNoticeDelete(@RequestParam("noticeNo") int noticeNo, Model model) {
			int result = 0;
			result = ns.noticeDeleteMember(noticeNo);
			model.addAttribute("result", result);
			return result;
}
	@GetMapping("admin/adminBlockList")
		public void adminBlockList(String pageNum, Model model) {
		
		int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1)* rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		List<Member> blocklist = ms.blockList(startRow, endRow); 
		int total = ms.block_count();
		int count = total - startRow + 1;
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		
		model.addAttribute("count", count);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("blocklist", blocklist);
		model.addAttribute("pb", pb);
	}
}