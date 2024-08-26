package com.youth.market.sell.controller;

import com.youth.market.common.Image;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.youth.market.member.dto.Member;
import com.youth.market.sell.dto.Category;
import com.youth.market.sell.dto.Sell;
import com.youth.market.sell.service.SellService;

@Controller

public class SellController {
	@Autowired
	private SellService ss;

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
	    // userNo를 세션에서 가져오기 (여기서도 세션이 없을 경우 기본값 1 설정)
	    s.setUserNo(1);

	    // 이미지 경로 설정
	    String webPath = "/resources/images/sell/";
	    String serverFolderPath = session.getServletContext().getRealPath(webPath);

	    // 업로드된 파일이 있는지 확인
	    if (s.getUpfile() != null && !s.getUpfile().isEmpty()) {
	        // 기존 파일 삭제 (필요 시)
	        File oldFile = new File(serverFolderPath + s.getImgSell());
	        if (oldFile.exists()) {
	            oldFile.delete(); // 기존 파일 삭제
	        }

	        // 새 파일 처리
	        String upfile1 = s.getUpfile().getOriginalFilename();
	        UUID uuid = UUID.randomUUID(); // UUID를 생성하여 중복 방지
	        String upfile = uuid + upfile1.substring(upfile1.lastIndexOf(".")); // 파일 이름 생성
	        try (FileOutputStream fos = new FileOutputStream(new File(serverFolderPath + upfile))) {
	            fos.write(s.getUpfile().getBytes()); // 파일 저장
	        }
	        s.setImgSell(upfile); // 새 이미지 파일 이름 설정
	    } else {
	        // 업로드된 파일이 없으면 기존 이미지 유지
	        // s.setImgSell(s.getImgSell()); // 이 라인은 생략해도 됨
	    }

	    // 데이터베이스에 업데이트 처리
	    int result = ss.updateSell(s); // updateSell 메서드는 DAO에서 구현되어야 함
	    model.addAttribute("result", result);

	    // 수정이 완료된 후에 리다이렉트 또는 뷰 페이지로 이동
	    return "redirect:/sell/sellDetail/" + s.getSellNo(); // 수정된 상품의 상세 페이지로 이동
	}

	// 상품삭제
	@ResponseBody
	@PostMapping("sell/sellDelete.do")
	public int deleteSell(HttpSession session, @RequestParam("sellNo") int sellNo) {
		int result = 0;

		try {
			Sell s = new Sell();
			s.setSellNo(sellNo);

			ss.sellDelete(s);

			result = 1; // 삭제 성공 시 1 반환
		} catch (Exception e) {
			e.printStackTrace();
			result = 0; // 예외 발생 시 0 반환
		}

		return result;
	}

	@GetMapping("sell/sellDetail/{sellNo}")
	public String sellDetail(@PathVariable("sellNo") int sellNo, HttpSession session, HttpServletRequest req,
			HttpServletResponse res, Model model) throws Exception {

		Map<String, Integer> map = new HashMap<>();
		map.put("sellNo", sellNo);
		map.put("userNo", 0); // 0 또는 다른 적절한 기본값
		List<Sell> sellList = ss.selectSellDetail(map);
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
		// userNo의 세션이 없어서 임의로 1넣었음.
		s.setUserNo(1);
		String webPath = "/resources/images/sell/";
		String serverFolderPath = session.getServletContext().getRealPath(webPath);

		String upfile1 = s.getUpfile().getOriginalFilename();
		UUID uuid = UUID.randomUUID();
		String upfile = uuid + upfile1.substring(upfile1.lastIndexOf("."));
		FileOutputStream fos = new FileOutputStream(new File(serverFolderPath + upfile));
		fos.write(s.getUpfile().getBytes());
		fos.close();
		s.setImgSell(upfile);
		int result = ss.insertSell(s);
		model.addAttribute("result", result);
	}

}
