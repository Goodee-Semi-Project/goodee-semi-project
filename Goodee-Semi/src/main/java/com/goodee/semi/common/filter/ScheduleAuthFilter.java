package com.goodee.semi.common.filter;

import java.io.IOException;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;

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

@WebFilter({"/schedule/create", "/schedule/delete", "/schedule/input", "/schedule/update"})
public class ScheduleAuthFilter extends HttpFilter implements Filter {
	private static final long serialVersionUID = 1L;

	public ScheduleAuthFilter() {
        super();
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		
		AccountDetail accountDetail = (AccountDetail) httpRequest.getSession(false).getAttribute("loginAccount");
		
		if(accountDetail.getAuthor() == Account.MEMBER_AUTHOR) {
			httpResponse.sendRedirect(httpRequest.getContextPath() + "/invalidAccess");
			return;
		};
		
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
