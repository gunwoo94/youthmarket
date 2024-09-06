package com.youth.market.heart.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youth.market.heart.dto.Heart;
import com.youth.market.member.dto.Member;
import com.youth.market.heart.service.HeartService;

@Controller
public class HeartController {

	private final HeartService heartService;

	@Autowired
	public HeartController(HeartService heartService) {
		this.heartService = heartService;
	}

	@ResponseBody
	@PostMapping("deleteHeart")
	public int deleteHeart(HttpSession session, @RequestParam(value = "chbox[]") List<String> chArr, Heart heart) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			// 로그인하지 않은 사용자가 접근했을 때 예외 처리
			return -1;
		}
		System.out.println("Before deleteHeart - loginUser: " + loginUser);
		System.out.println("Before deleteHeart - loginUser.userNo: " + loginUser.getUserNo());

		int result = 0;

		if (heart != null && heartService != null) {
			heart.setUserNo(loginUser.getUserNo());

			for (String i : chArr) {
				int heartNum = Integer.parseInt(i);
				heart.setHeartNo(heartNum);
				heartService.deleteHeart(heart);
			}

			int sysHeartNum = chArr.size();
			HashMap<String, Object> map = new HashMap<>();
			map.put("userNo", loginUser.getUserNo());
			map.put("sysHeartNum", sysHeartNum);

			heartService.minusListCount(map);

			result = 1;

			Member updateMem = heartService.selectMem(loginUser);
			System.out.println("After selectMem - updateMem: " + updateMem);
			if (updateMem != null) {
				session.setAttribute("loginUser", updateMem);
			}
			System.out.println("After deleteHeart - session loginUser: " + session.getAttribute("loginUser"));
		}

		return result;
	}

	@ResponseBody
	@PostMapping("addHeart")
	public String addHeart(Member m, Heart heart, HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "로그인이 필요합니다.";
		}
		System.out.println("Before addHeart - loginUser: " + loginUser);
		System.out.println("Before addHeart - loginUser.userNo: " + loginUser.getUserNo());

		String result = "";

		if (heart != null && heartService != null) {
			heart.setUserNo(loginUser.getUserNo());
			heartService.addHeart(heart);
			result = "c";

			if ("c".equals(result)) {
				Member updateMem = heartService.selectMem(loginUser);
				System.out.println("After selectMem - updateMem: " + updateMem);
				if (updateMem != null) {
					session.setAttribute("loginUser", updateMem);
				}
				System.out.println("After addHeart - session loginUser: " + session.getAttribute("loginUser"));
			}
		} else {
			return "잘못된 요청입니다.";
		}

		return result;
	}

	@ResponseBody
	@PostMapping("mypageDeleteHeart")
	public String mypageDeleteHeart(HttpSession session, @RequestParam("sellNo") int sellNo) {
		Member loginUser = (Member) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "로그인이 필요합니다.";
		}

		String result = "";

		if (sellNo > 0 && heartService != null) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("sellNo", sellNo);
			map.put("userNo", loginUser.getUserNo());

			int deleteResult = heartService.mypageDeleteHeart(map);
			if (deleteResult > 0) {
				result = "f";
				Member updateMem = heartService.selectMem(loginUser);
				
				if (updateMem != null) {
					session.setAttribute("loginUser", updateMem);
				}
			
			} else {
				result = "error";
			}
		} else {
			result = "잘못된 요청입니다.";
		}

		return result;
	}
}
