package com.goodee.semi.common.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

@WebFilter("/account/*")
public class PasswordEncryptFilter extends HttpFilter implements Filter {
       
  public PasswordEncryptFilter() {
    super();
  }

  public void init(FilterConfig fConfig) throws ServletException {}

  public void destroy() {}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		PasswordEncryptWrapper wrapper = new PasswordEncryptWrapper((HttpServletRequest) request);
		
		chain.doFilter(wrapper, response);
	}

}
