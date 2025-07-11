package com.goodee.semi.service;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.AccountDao;
import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;

public class AccountService {
	private AccountDao accountDao = new AccountDao();
	
	public AccountDetail getLoginInfo(String accountId, String accountPw) {
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

	public Account selectAccountByNameAndEmail(AccountDetail account) {
		return accountDao.selectAccountByNameAndEmail(account);
	}
  
	public AccountDetail selectAccountDetail(String accountId) {
		AccountDetail accountDetail = accountDao.selectAccountDetail(accountId);
		
		return accountDetail;
	}
	
	public int updateAccountDetail(AccountDetail param) {
		int result = accountDao.updateAccountDetail(param);
		
		return result;
	}
	
	public int checkIdPw(Account account) {
		int result = accountDao.checkIdPw(account);
		return result;
	}

	public int deactivateAccount(Account account) {
		int result = accountDao.deactivateAccount(account);
		return result;
	}

	public int updateAccountPw(Account account, String newPw) {
		int result = accountDao.checkIdPw(account);
		if (result > 0) {
			account.setAccountPw(newPw);
			result = accountDao.updateAccountPw(account);
		}
		return result;
	}
  
  public Account selectAccountByIdNameEmail(AccountDetail account) {
		return accountDao.selectAccountByIdNameEmail(account);
	}

	public int updateNewPassword(AccountDetail account) {
		return accountDao.updateNewPassword(account);
  }
}
