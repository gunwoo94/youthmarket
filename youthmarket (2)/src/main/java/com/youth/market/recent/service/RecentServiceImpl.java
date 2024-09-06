package com.youth.market.recent.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youth.market.recent.dao.RecentDao;
import com.youth.market.recent.dto.Recent;

@Service
public class RecentServiceImpl implements RecentService {
	@Autowired
	private RecentDao rd;

	@Override
	public int updateProduct(Recent recent) {
		// TODO Auto-generated method stub
		return rd.updateProduct(recent);
	}

	@Override
	public int deleteProducts(Recent recent) {
		// TODO Auto-generated method stub
		return rd.deleteProducts(recent);
	}

	@Override
	public List<Recent> viewProduct(Recent recent) {
		// TODO Auto-generated method stub
		return rd.viewProduct(recent);
	} 

	@Override
	public Integer deleteProduct(Recent recent) {
		// TODO Auto-generated method stub
		return rd.deleteProduct(recent);
	}


}
