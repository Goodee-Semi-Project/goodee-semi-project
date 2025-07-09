package com.goodee.semi.service;

import com.goodee.semi.dao.AccountDao;
import com.goodee.semi.dto.AccountDetail;

public class AccountService {
	AccountDao dao = new AccountDao();
	
	public AccountDetail selectAccountDetail(int userNo) {
		AccountDetail accountDetail = dao.selectAcountDetail(userNo);
		
		return accountDetail;
	}
	
	public int updateAccountDetail(AccountDetail param) {
		int result = dao.updateAccountDetail(param);
		
		return result;
	}

}
