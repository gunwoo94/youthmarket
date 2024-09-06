package com.youth.market.follow.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youth.market.follow.dto.Follow;
import com.youth.market.follow.service.FollowService;
import com.youth.market.member.dto.Member;

@Controller
public class FollowController {
	@Autowired
	private FollowService fs;
	// 팔로우 삭제
	@PostMapping("/follow/delFollow")
	@ResponseBody
	public Map<String, Integer> delFollow(@RequestParam("fwId") int fwId, HttpSession session) {

	    Map<String, Integer> map = new HashMap<>();

	    try {
	        // 로그인한 사용자 정보 가져오기
	        Member member = (Member) session.getAttribute("loginUser");

	        // Follow 객체 생성 및 값 설정
	        Follow follow = new Follow();
	        follow.setFlId(member.getUserNo());
	        follow.setFwId(fwId);

	        // 팔로우 삭제 서비스 호출
	        int result = fs.deleteFollow(follow);
	        map.put("result", result);

	    } catch (Exception e) {
	        e.printStackTrace();
	        map.put("result", -1); // 오류 시 -1로 설정
	    }

	    return map;
	}


	//팔로우 추가 하기 
	@PostMapping("/follow/addFollow")
	@ResponseBody
	public Map<String, Integer> addFollow(@RequestParam("fwId") int fwId, HttpSession session) {
	    Map<String, Integer> resultMap = new HashMap<>();

	    try {
	        Member member = (Member) session.getAttribute("loginUser");
	        
	        // Follow 객체를 새로 생성하고 필요한 값을 설정
	        System.out.println("/***************************************************/");
	        System.out.println(member);
	        System.out.println("/***************************************************/");
	        Follow follow = new Follow();
	        follow.setFlId(member.getUserNo());
	        follow.setFwId(fwId);
	        
	        int count = fs.selectFollow(follow);

	        if (count == 0) {
	            int result = fs.insertFollow(follow);
	            resultMap.put("result", result);
	        } else {
	            resultMap.put("result", 2); // 이미 존재함
	        }

	    } catch (Exception e) {
//	    	e.printStackTrace();
	        resultMap.put("result", -1); // 오류 발생 시 -1 반환
	    }

	    return resultMap;
	}


	// 팔로잉 목록
	@GetMapping("follow/followList")
	public String followList(Model model, HttpSession session) {
		Member member = (Member) session.getAttribute("loginUser");

		if (member != null) {
			Follow follow = new Follow();
			follow.setFlId(member.getUserNo());

			List<Follow> followList = fs.selectFollowList(follow); 
			model.addAttribute("followList", followList);
			model.addAttribute("member", fs.selectMember(follow));
			
			
		}
		
	
		return "follow/followingDetailForm";
	}
}
