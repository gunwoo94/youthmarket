package com.youth.market.recent.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.youth.market.member.dto.Member;
import com.youth.market.recent.dto.Recent;
import com.youth.market.recent.service.RecentService;

@Controller
public class RecentController {
	@Autowired
	private RecentService rs;
	//최근 본 상품 
	@PostMapping("/recent/update")
	@ResponseBody
	public List<Recent> updateProducts(@RequestBody List<Recent> recentList,
	                                    @SessionAttribute("loginUser") Member member) {
	    int mergeCnt = 0;
	    Recent recent = new Recent();
	    recent.setUserNo(member.getUserNo()); 
	    try {
	        for (Recent recentObj : recentList) {
	            recentObj.setUserNo(member.getUserNo());
	            mergeCnt += rs.updateProduct(recentObj);
	        }

	        recent.setUserNo(member.getUserNo());
	        int deleteCnt = rs.deleteProducts(recent);
	        System.out.println("Merged count: " + mergeCnt + ", Deleted count: " + deleteCnt);
	        
	        // 최근 본 상품 조회
	        List<Recent> products = rs.viewProduct(recent);
	        System.out.println("Retrieved products after update: " + products);  // 수정한 로그 추가

	        if (products == null || products.isEmpty()) {
	            System.out.println("Retrieved products is null or empty");
	        } else {
	            System.out.println("Retrieved products: " + products);
	        }
	        return products;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return Collections.emptyList();  // 예외 발생 시 빈 리스트 반환
	    }
	}

	//최근 본상품 불러오기 
	@PostMapping("/recent/products")
	@ResponseBody
	public List<Recent> viewProducts(@SessionAttribute("loginUser") Member member) {
		Recent recent = new Recent();
		recent.setUserNo(member.getUserNo());
		List<Recent> products = rs.viewProduct(recent);
		System.out.println("Products retrieved: " + (products != null ? products.size() : 0));
		if (products == null) {
		    System.out.println("Products is null");
		} else if (products.isEmpty()) {
		    System.out.println("Products is empty");
		} else {
		    System.out.println("Products size: " + products.size());
		    for (Recent product : products) {
		        System.out.println("Product: " + product);
		        if (product == null) {
		            System.out.println("One of the products is null.");
		        } else {
		            System.out.println("Product details: recentNo=" + product.getRecentNo() + ", sellNo=" + product.getSellNo() + ", imgSell=" + product.getImgSell());
		        }
		    }
		}


		return products;
	}

	@PostMapping("/recent/delete")
	@ResponseBody
	public Map<String, Integer> deleteProducts(Recent recent) {
		Map<String, Integer> result = new HashMap<>();
		result.put("result", rs.deleteProduct(recent));
		return result;
	}
}
