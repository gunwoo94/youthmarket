package com.youth.market.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youth.market.admin.dao.AdminDao;
import com.youth.market.admin.dto.Admin;

@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminDao ad;

	@Override
	public Admin loginChk(String adminId) {
		System.out.println("ad = "+ad);
		return ad.loginChk(adminId);
	}
}
