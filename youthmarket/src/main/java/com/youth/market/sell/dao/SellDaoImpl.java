package com.youth.market.sell.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.youth.market.sell.dto.Category;
import com.youth.market.sell.dto.Review;
import com.youth.market.sell.dto.Sell;
import com.youth.market.sell.dto.SellImg;
@Repository
public class SellDaoImpl implements SellDao {

    @Autowired
    private SqlSessionTemplate sst;
    @Override
    public int getSellNo() {
    	return sst.selectOne("sellns.getSellNo");
    }  
    @Override
    public int insertSell(Sell s) {
    	return sst.insert("sellns.insert", s);
    }

    @Override
    public int insertSellImgList(List<SellImg> sellImageList) {
        return sst.insert("sellns.insertSellImgList", sellImageList);
    }


    @Override
    public List<SellImg> selectSellImgList(Map<String, Integer> map) {
        return sst.selectList("sellns.selectSellImgList", map);
    }
    //메인 페이지 상품 리스트 
	@Override
	public List<Sell> sellListselect() {
		
		return sst.selectList("sellns.sellListselect");
	}
	//메인페이지 @상품 더 보기 
	@Override
	 public List<Sell> getSellList(int start, int limit) {
        HashMap<String, Integer> params = new HashMap<>();
        params.put("start", start);
        params.put("limit", limit);
        return sst.selectList("sellns.getSellList", params);
    }
	// 상품 상세 조회 
	@Override
	public List<Sell> selectSellDetail(Map<String, Integer> map) {
		
		return  sst.selectList("sellns.selectSellDetail",map);
	}
	// 상품 삭제 
	@Override
	public int sellDelete(Sell s) {
		
		return sst.delete("sellns.sellDelete",s);
	}
	//상품 조건 조회
	@Override
	public List<Sell> howOrderList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return sst.selectList("sellns.howOrderList",map);
	}
	//카테고리
	@Override
	public List<Category> cateList() {
		// TODO Auto-generated method stub
		return sst.selectList("sellns.cateList");
	}
	//상품 업데이트
	@Override
	public int updateSell(Sell s) {
		// TODO Auto-generated method stub
		return sst.update("sellns.updateSell",s);
	}
	@Override
	public Sell getSellDetail(int sellNo) {
		// TODO Auto-generated method stub
		return sst.selectOne("sellns.getSellDetail",sellNo);
	}
	
	//조회수 증가 
	@Override
	public int increaseCount(int sellNo) {
		// TODO Auto-generated method stub
		return sst.update("sellns.increaseCount",sellNo);
	}
	
	


   

}

