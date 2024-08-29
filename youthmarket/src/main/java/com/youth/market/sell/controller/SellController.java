package com.youth.market.sell.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

<<<<<<< HEAD
=======
import javax.mail.Session;
import javax.servlet.http.Cookie;
>>>>>>> branch 'main' of https://github.com/gunwoo94/youthmarket.git
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.youth.market.sell.dto.Category;
import com.youth.market.sell.dto.Sell;
import com.youth.market.sell.service.SellService;

@Controller

public class SellController {
	@Autowired
	private SellService ss;


	//상품 자세히보기에서 - 판매자 페이지로 이동 
	@GetMapping("sell/seller/{userNo}")
	public String sellerPage(
	        @PathVariable("userNo") int userNo, 
	        Model model, 
	        HttpSession session) {

	    // 로그인한 사용자 정보
	    Member member = (Member) session.getAttribute("loginUser");

	    // 판매자 정보 가져오기
	    Map<String, Integer> map = new HashMap<>();
	    map.put("sellerNo", userNo);
	    
	    
	    // 로그인한 사용자의 userNo를 추가 (로그인 했을 때)
	    if (member != null) {
	        map.put("userNo", member.getUserNo());
	    }

	    // 판매자 상세 정보
	    model.addAttribute("member", ss.sellerDetail(map));

	    // 판매 리스트
	    model.addAttribute("sellList", ss.sellList(userNo));

	    // 판매자 페이지 뷰 반환
	    return "sell/sellerPage";
	}

	//상품 검색
	@PostMapping("sell/search")
	public String searchList(
	    Model model, 
	    @RequestParam String search // POST 요청이므로 @RequestParam 사용
	) {
	    // 상품 검색일 경우
	    List<Sell> sList = ss.sellListsearch(search);

	    // 상품 생성 시간 처리
	    sList.forEach(sell -> sell.setTimeago(sell.getCreateDate()));

	    // 모델에 데이터 추가
	    model.addAttribute("sList", sList);
	    model.addAttribute("keyword", search);

	    // 반환할 뷰의 이름
	    return "sell/searchList";
	}

	@GetMapping("sell/Gocategory.do")
	public void Gocategory() {

	}
	// 카테고리 인기순,최근순,가격순 정렬
	@GetMapping("sell/category/{categoryCode}/{how}")
	public String orderHow(@PathVariable("categoryCode") int categoryCode, @PathVariable("how") String howOrder,
			Model model) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("howOrder", howOrder);
		map.put("categoryCode", categoryCode);

		List<Sell> sellList = ss.howOrderList(map);

		for (Sell sell : sellList) {
			sell.setTimeago(sell.getCreateDate());
		}

		model.addAttribute("sellList", sellList);
		model.addAttribute("map", map);

		return "sell/Gocategory"; // 뷰의 이름을 반환
	}

	// 카테고리 이동
	@GetMapping("sell/category/{categoryCode}")
	public String GoCategory(@PathVariable("categoryCode") int categoryCode, Model model) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("categoryCode", categoryCode);

		List<Sell> sellList = ss.howOrderList(map);

		for (Sell sell : sellList) {
			sell.setTimeago(sell.getCreateDate());
		}

		model.addAttribute("sellList", sellList);
		model.addAttribute("categoryCode", categoryCode);
		System.out.println("sellList: " + sellList);
		System.out.println(categoryCode);

		return "sell/Gocategory"; // 뷰의 이름을 반환
	}

	// 상품 수정 페이지로 이동
	@GetMapping("/sell/sellUpdateForm/{sellNo}")
	public String sellUpdateForm(@PathVariable("sellNo") int sellNo, Model model) {
		// sellNo를 사용하여 상품 상세 정보 조회
		Sell s = ss.getSellDetail(sellNo);
		List<Category> cateList = ss.cateList(); // 카테고리 리스트를 가져오는 메서드
		// 상품 정보가 없을 경우 예외 처리
		if (s == null) {
			model.addAttribute("errorMessage", "상품을 찾을 수 없습니다.");
			return "errorPage"; // 에러 페이지로 리다이렉트 또는 적절한 뷰를 반환
		}

		// 모델에 상품 정보 추가
		model.addAttribute("s", s);
		model.addAttribute("cateList", cateList);

		return "sell/sellUpdateForm"; // 상품 수정 페이지로 이동
	}



	// 상품 수정
	@PostMapping("sell/sellUpdate.do")
	public String updateSell(Sell s, Model model, HttpSession session) throws IOException {
	    Integer userNo = (Integer) session.getAttribute("userNo");
	    s.setUserNo(userNo);

	    String webPath = "/resources/images/sell/";
	    String serverFolderPath = session.getServletContext().getRealPath(webPath);
	  
	    if (s.getUpfile() != null && !s.getUpfile().isEmpty()) {
	    	  // 기존 파일 삭제 (필요 시)
	        File oldFile = new File(serverFolderPath + s.getImgSell());
	        if (oldFile.exists()) {
	            oldFile.delete(); // 기존 파일 삭제
	        }

	        String upfile1 = s.getUpfile().getOriginalFilename();
	        UUID uuid = UUID.randomUUID(); // UUID를 생성하여 중복 방지
	        String upfile = uuid + upfile1.substring(upfile1.lastIndexOf("."));
	        try (FileOutputStream fos = new FileOutputStream(new File(serverFolderPath + upfile))) {
	            fos.write(s.getUpfile().getBytes()); // 파일 저장
	        }
	        s.setImgSell(upfile);
	    } else {
	        // Map을 사용하여 sellNo 값을 전달
	    	// 업로드된 파일이 없으면 기존 이미지를 그대로 사용
	        // 여기서 기존의 이미지 경로를 다시 설정
	        Map<String, Integer> paramMap = new HashMap<>();
	        paramMap.put("sellNo", s.getSellNo());
	        s.setImgSell(ss.selectSellDetail(paramMap).get(0).getImgSell());
	    }
	    // 데이터베이스에 업데이트 처리
	    int result = ss.updateSell(s);
	    model.addAttribute("result", result);
	 // 수정이 완료된 후에 리다이렉트 또는 뷰 페이지로 이동
	    return "redirect:/sell/sellDetail/" + s.getSellNo();
	}


	// 상품삭제
	@ResponseBody
	@PostMapping("sell/sellDelete.do")
	public int deleteSell(HttpSession session, @RequestParam("sellNo") int sellNo) {
		int result = 0;

		try {
			// 세션에서 userNo 가져오기
			Integer userNo = (Integer) session.getAttribute("userNo");
			Sell s = new Sell();
			s.setSellNo(sellNo);
			s.setUserNo(userNo); // userNo를 셋팅하여 삭제 요청이 해당 사용자의 것임을 확인

			ss.sellDelete(s);

			result = 1; // 삭제 성공 시 1 반환
		} catch (Exception e) {
			e.printStackTrace();
			result = 0; // 예외 발생 시 0 반환
		}

		return result;
	}

	// 상품 자세히 보기
	@GetMapping("sell/sellDetail/{sellNo}")
	public String sellDetail(@PathVariable("sellNo") int sellNo, HttpSession session, HttpServletRequest req,
			HttpServletResponse res, Model model) throws Exception {

		// 세션에서 userNo 가져오기
		Integer userNo = (Integer) session.getAttribute("userNo");
		Map<String, Integer> map = new HashMap<>();
		map.put("sellNo", sellNo);
		map.put("userNo", userNo); // 세션에서 가져온 userNo를 map에 추가
		List<Sell> sellList = ss.selectSellDetail(map);
		
		 // 조회수 증가 로직을 추가하기 위해 쿠키 검사
	    Cookie[] cookies = req.getCookies();
	    Cookie viewCookie = null;

	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("cookie" + sellNo)) {
	                viewCookie = cookie;
	                break;
	            }
	        }
	    }
	    
	    // viewCookie가 null일 경우 쿠키를 생성하고 조회수 증가 로직을 처리함
	    if (viewCookie == null) {
	        // 쿠키 생성(이름, 값)
	        Cookie newCookie = new Cookie("cookie" + sellNo, "|" + sellNo + "|");
	        newCookie.setMaxAge(60 * 60 * 24); // 쿠키 유효기간을 1일로 설정
	        newCookie.setPath("/"); // 모든 경로에서 쿠키가 유효하도록 설정

	        // 쿠키 추가
	        res.addCookie(newCookie);

	        // 조회수 증가 처리
	        int result = ss.increaseCount(sellNo);
	        if (result > 0) {
	            System.out.println("조회수 증가 성공");
	        } else {
	            System.out.println("조회수 증가 실패");
	        }
	    } else {
	        // 이미 쿠키가 존재할 경우 조회수 증가 로직을 처리하지 않음
	        System.out.println("조회수 증가 로직 생략 - 쿠키가 이미 존재함");
	    }
		// 리스트의 첫 번째 요소 가져오기
		if (!sellList.isEmpty()) {
			Sell s = sellList.get(0); // 첫 번째 Sell 객체
			model.addAttribute("s", s);
		} else {
			// Handle the case where there are no results
			model.addAttribute("errorMessage", "상품을 찾을 수 없습니다.");
		} 
		model.addAttribute("sellList", sellList);

		return "sell/sellDetailForm";
	}

	// 메인페이지 @상품 더보기
	@PostMapping("sell/theBogi")
	@ResponseBody
	public HashMap<String, Object> loadMoreItems(@RequestParam("start") int start) {

		int limit = 10; // 한 번에 불러올 데이터 수

		List<Sell> sellList = ss.getSellList(start, limit);

		HashMap<String, Object> response = new HashMap<>();
		response.put("sellList", sellList);

		return response;
	}

	// 메인페이지
	@GetMapping("sell/home.do")
	public void home(Locale locale, Model model, HttpSession session) {

		List<Sell> sList = ss.sellListselect();
		model.addAttribute("sellList", sList);

		// 추가 로그로 데이터 확인
		System.out.println("Sell List Size: " + sList.size());
	}

	// 상품 등록
	@GetMapping("sell/sellInsertForm.do")
	public void sellInsertForm() {

		/*
		 * Member loginUser = (Member) model.addAttribute("loginUser"); if (loginUser ==
		 * null) { model.addAttribute("errorMsg", "로그인 후 이용 가능합니다."); return
		 * "redirect:/"; } else { return "sell/sellInsertForm"; } }
		 */
	}

	// 상품등록
	@PostMapping("sell/sellInsert.do")
	public void insertSell(Sell s, Model model, HttpSession session) throws IOException {
		// userNo 세션
		Integer userNo = (Integer) session.getAttribute("userNo");
		System.out.println("userNo = " + userNo);
		String webPath = "/resources/images/sell/";
		String serverFolderPath = session.getServletContext().getRealPath(webPath);
		s.setUserNo(userNo);
		String upfile1 = s.getUpfile().getOriginalFilename();
		UUID uuid = UUID.randomUUID();
		String upfile = uuid + upfile1.substring(upfile1.lastIndexOf("."));
		FileOutputStream fos = new FileOutputStream(new File(serverFolderPath + upfile));
		fos.write(s.getUpfile().getBytes());
		fos.close();
		s.setImgSell(upfile);
		int result = ss.insertSell(s);

		model.addAttribute("result", result);
		model.addAttribute("userNo", userNo);
	}

}
