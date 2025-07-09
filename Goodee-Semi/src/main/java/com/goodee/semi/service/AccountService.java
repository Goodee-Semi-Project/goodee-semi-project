package com.goodee.semi.service;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Account;
import com.goodee.semi.dao.AccountDao;
import com.goodee.semi.dto.AccountDetail;

public class AccountService {
	private AccountDao accountDao = new AccountDao();
	
	public Account getLoginInfo(String accountId, String accountPw) {
		Account param = new Account();
		param.setAccountId(accountId);
		param.setAccountPw(accountPw);
		
		return accountDao.loginInfo(param);
	}

	public int insertAccount(AccountDetail account) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			result = accountDao.insertAccount(session, account);
			
			if (result > 0) {
				result = accountDao.insertAccountInfo(session, account);
			}
			
			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}
}
