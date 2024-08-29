package com.youth.market.sell.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youth.market.member.dto.Member;
import com.youth.market.sell.dao.SellDao;
import com.youth.market.sell.dto.Category;
import com.youth.market.sell.dto.Sell;
import com.youth.market.sell.dto.SellImg;

@Service
public class SellServiceImpl implements SellService {
	@Autowired
	private SellDao sd;

	    public List<SellImg> selectSellImgList(Map<String, Integer> map) {
	        return sd.selectSellImgList(map);
	    }
	    // 상품 추가 
		public int insertSell(Sell s) {
			return sd.insertSell(s);
		}
		//상품 목록 (메인페이지)
		@Override
		public List<Sell> sellListselect() {
			
			return sd.sellListselect();
		}
		//상품 목록 @ 더보기 
		@Override
		public List<Sell> getSellList(int start, int limit) {
			// TODO Auto-generated method stub
			return sd.getSellList(start,limit);
		}
		//상품 상세페이지
		@Override
		public List<Sell> selectSellDetail(Map<String, Integer> map) {
			// TODO Auto-generated method stub
			return sd.selectSellDetail(map);
		}
		//상품 삭제
		@Override
		public int sellDelete(Sell s) {
			// TODO Auto-generated method stub
			return sd.sellDelete(s);
		}
		@Override
		public List<Sell> howOrderList(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			return sd.howOrderList(map);
		}
		@Override
		public List<Category> cateList() {
			
			return sd.cateList();
		}
		@Override
		public int updateSell(Sell s) {
			
			return sd.updateSell(s);  
		}
		@Override
		public Sell getSellDetail(int sellNo) {
			// TODO Auto-generated method stub
			return sd.getSellDetail(sellNo);
		}
		//쿠키를 사용해 조회수 증가 
		@Override
		public int increaseCount(int sellNo) {
		
			return sd.increaseCount(sellNo);
		}
		//상품 검색 
		@Override
		public List<Sell> sellListsearch(String search) {

			return sd.sellListsearch(search);
		}
	
		@Override
		public List<Sell> sellList(int userNo) {
			// TODO Auto-generated method stub
			return sd.sellList(userNo);
		}
		@Override
		public Map<String, Object> sellerDetail(Map<String, Integer> map) {
			// TODO Auto-generated method stub
			return sd.sellerDetail(map);
		}
		
	 
	

}