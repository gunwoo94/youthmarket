package com.youth.market.recent.service;

import java.util.List;

import com.youth.market.recent.dto.Recent;

public interface RecentService {

	int updateProduct(Recent recent);

	int deleteProducts(Recent recent);

	List<Recent> viewProduct(Recent recent);

	Integer deleteProduct(Recent recent);

}
