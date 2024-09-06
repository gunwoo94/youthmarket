package com.youth.market.recent.dao;

import java.util.List;

import com.youth.market.recent.dto.Recent;

public interface RecentDao {

	int updateProduct(Recent recent);

	int deleteProducts(Recent recent);

	List<Recent> viewProduct(Recent recent);

	Integer deleteProduct(Recent recent);

}
 