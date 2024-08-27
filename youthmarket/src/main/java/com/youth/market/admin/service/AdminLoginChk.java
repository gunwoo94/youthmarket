package com.youth.market.admin.service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
public class AdminLoginChk extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {		
		HttpSession session = request.getSession();
		if (session.getAttribute("adminId") == null) {
			response.sendRedirect("/youthmarket/admin/adminLoginForm.do");
			return false;
		}
		return true;
	}
}