package com.youth.market.sell.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.youth.market.sell.dto.Category;
import com.youth.market.sell.dto.Review;
import com.youth.market.sell.dto.Sell;
import com.youth.market.sell.dto.SellImg;

public interface SellDao {
	


	// 판매글 번호를 가져오기 위한 메서드
    int getSellNo();

    // 판매글을 등록하는 메서드
    int insertSell(Sell s);

    // 판매글 이미지를 등록하는 메서드
    int insertSellImgList(List<SellImg> sellImageList);

    // 판매글 이미지 리스트를 가져오는 메서드
    List<SellImg> selectSellImgList(Map<String, Integer> map);
    
    // 메인페이지 상품 보기 
	List<Sell> sellListselect();

	// 메인페이지 @ 상품 더 보기 
	List<Sell> getSellList(int start, int limit);
	
	// 상품 상세 보기 
	List<Sell> selectSellDetail(Map<String, Integer> map);
	
	// 상품 삭제
	int sellDelete(Sell s);
	
	//상품 조회 최신순,최저가,최고가,오래된순 
	List<Sell> howOrderList(HashMap<String, Object> map);

	List<Category> cateList();

	int updateSell(Sell s);

	Sell getSellDetail(int sellNo);

	



  
}
