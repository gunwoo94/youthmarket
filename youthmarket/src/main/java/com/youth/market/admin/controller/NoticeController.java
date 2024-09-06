package com.youth.market.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youth.market.admin.dto.AdminNotice;
import com.youth.market.admin.dto.Notice;
import com.youth.market.admin.service.NoticeService;

@Controller
public class NoticeController {

	private final NoticeService noticeService;

	@Autowired
	public NoticeController(NoticeService noticeService) {
		this.noticeService = noticeService;
	}

	@GetMapping("/notice/getNoticeDetail")
	@ResponseBody
	public Map<String, Object> getNoticeDetail(@RequestParam("noticeNo") int noticeNo) {
		Map<String, Object> response = new HashMap<>();

		try {
			Notice notice = noticeService.getNoticeByNo(noticeNo);
			if (notice != null) {
				response.put("noticeContent", notice.getNoticeContent());
				response.put("noticeTitle", notice.getNoticeTitle());
			} else {
				response.put("error", "공지사항을 찾을 수 없습니다.");
			}
		} catch (Exception e) {
			response.put("error", "공지사항을 불러오는 도중 오류가 발생했습니다.");
		}
		return response;
	}

	/*
	 * @PostMapping("/admin/QaBoardForm") public String adminNoticeWrite(Notice
	 * notice, Model model) { int result = noticeService.insert(notice);
	 * 
	 * if (result > 0) { model.addAttribute("msg", "공지사항이 성공적으로 등록되었습니다."); } else {
	 * model.addAttribute("msg", "공지사항 등록에 실패했습니다."); }
	 * 
	 * return "redirect:/admin/QaBoard"; // 리다이렉트 URL 확인 필요 } }
	 */

	@GetMapping("/notice/noticeList")
	public String getNoticeList(
			@RequestParam(value = "searchCategory", required = false, defaultValue = "noticeTitle") String searchCategory,
			@RequestParam(value = "searchKeyword", required = false, defaultValue = "") String searchKeyword,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model) {

		Map<String, Object> searchParams = new HashMap<>();
		searchParams.put("searchCategory", searchCategory);
		searchParams.put("searchKeyword", searchKeyword);

		int pageSize = 10;
		int offset = (pageNum - 1) * pageSize;

		List<Notice> noticeList = noticeService.searchNotices(searchParams, offset, pageSize);
		int totalRecords = noticeService.getTotalCount(searchParams);

		int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("searchCategory", searchCategory);
		model.addAttribute("searchKeyword", searchKeyword);

		return "notice/noticeList";
	}

	@RequestMapping("/notice/increaseNoticeHit")
	@ResponseBody
	public Map<String, Object> increaseNoticeHit(@RequestParam("noticeNo") int noticeNo) {
		Map<String, Object> response = new HashMap<>();
		try {
			noticeService.increaseNoticeHit(noticeNo);
			response.put("success", true);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "조회수 증가에 실패했습니다.");
		}
		return response;
	}

	@GetMapping("/admin/adminNoticeEdit")
	public void adminNoticeEdit(AdminNotice adminNotice, int noticeNo, Model model) {
		model.addAttribute(adminNotice);
		System.out.println(noticeNo);
	}

	@PostMapping("/admin/adminNoticeAction")
	public void adminNoticeAction(@RequestParam("noticeNo") int noticeNo, Model model) {
		int result = 0;
		result = noticeService.updateNotice(noticeNo);
		System.out.println(noticeNo);
		model.addAttribute("result", result);

	}

}
