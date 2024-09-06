package com.youth.market.admin.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.youth.market.admin.dto.Admin;

@Repository
public class AdminDaoImpl implements AdminDao{
	@Autowired 
	private SqlSessionTemplate sst;

	@Override
	public Admin loginChk(String adminId) {
		System.out.println("adminId = "+adminId);
		return sst.selectOne("adminns.select",adminId);
	}
	
}
