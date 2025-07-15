package com.goodee.semi.common.filter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;

public class LoginWrapper extends HttpServletRequestWrapper {

	public LoginWrapper(HttpServletRequest request) {
		super(request);
	}
	
	@Override
	public String getParameter(String name) {
		return super.getParameter(name);
	}
}
