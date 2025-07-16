package com.goodee.semi.common.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class MyInfoLoginFilter
 */
// TODO: 비회원 접근 제한 경로 추가
@WebFilter({"/myInfo/*", "/review/write", "/preCourse/*", "/myCourse/*", "/preCourse/*"})
public class LoginAccountFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public LoginAccountFilter() {
        super();
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// place your code here
		HttpSession session = ((HttpServletRequest) request).getSession();
		if (session == null || session.getAttribute("loginAccount") == null) {
			((HttpServletResponse) response).sendRedirect(((HttpServletRequest) request).getContextPath() + "/account/login");
			return;
		}

		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}

}
