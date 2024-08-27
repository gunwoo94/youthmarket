package com.youth.market.sell.service;

import com.youth.market.sell.dto.Category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.youth.market.sell.dto.Sell;
import com.youth.market.sell.dto.SellImg;

public interface SellService {
	List<SellImg> selectSellImgList(Map<String, Integer> map);

	// 상품추가
	int insertSell(Sell s);

	// 메인페이지 , 상품 리스트
	List<Sell> sellListselect();

	// 상품 더 보기
	List<Sell> getSellList(int start, int limit);

	// 상품 상세 페이지
	List<Sell> selectSellDetail(Map<String, Integer> map);

	// 상품 삭제
	int sellDelete(Sell s);

	// 카테고리
	// 상품 등록순,인기순,가격순 정렬
	List<Sell> howOrderList(HashMap<String, Object> map);
	public List<Category> cateList();
	
	//상품 업데이트
	int updateSell(Sell s);
	Sell getSellDetail(int sellNo);

	int increaseCount(int sellNo);
	

}
