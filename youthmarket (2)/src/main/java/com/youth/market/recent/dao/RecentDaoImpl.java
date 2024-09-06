package com.youth.market.recent.dao;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.youth.market.recent.dto.Recent;

@Repository
public class RecentDaoImpl implements RecentDao {
	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public int updateProduct(Recent recent) {
		// TODO Auto-generated method stub
		return sst.update("recentns.updateProduct",recent);
	}

	@Override
	public int deleteProducts(Recent recent) {
		// TODO Auto-generated method stub
		return sst.delete("recentns.deleteProducts",recent) ;
	}

	@Override
	public List<Recent> viewProduct(Recent recent) {
		// TODO Auto-generated method stub
		System.out.println("Fetching products for userNo: " + recent.getUserNo());
		return sst.selectList("recentns.viewProduct",recent);
		
	}

	@Override
	public Integer deleteProduct(Recent recent) {
		// TODO Auto-generated method stub
		return sst.update("recentns.deleteProduct",recent);
	}
	
}
