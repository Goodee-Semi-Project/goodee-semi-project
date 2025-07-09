package com.goodee.semi.service;

import com.goodee.semi.dao.AccountDao;
import com.goodee.semi.dto.Account;

public class AccountService {
	AccountDao dao = new AccountDao();
	
	public Account getLoginInfo(String accountId, String accountPw) {
		Account param = new Account();
		param.setAccountId(accountId);
		param.setAccountPw(accountPw);
		
		return dao.loginInfo(param);
	}
}
