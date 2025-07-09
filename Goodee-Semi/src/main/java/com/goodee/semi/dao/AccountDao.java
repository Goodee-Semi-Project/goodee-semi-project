package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;

public class AccountDao {
	
	public int insertAccount(SqlSession session, AccountDetail account) {
		int result = session.insert("com.goodee.semi.mapper.AccountMapper.insertAccount", account);
		
		return result;
	}

	public int insertAccountInfo(SqlSession session, AccountDetail account) {
		int result = session.insert("com.goodee.semi.mapper.AccountMapper.insertAccountInfo", account);
		
		return result;
	}
	
	public AccountDetail loginInfo(Account param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		AccountDetail result = session.selectOne("com.goodee.semi.mapper.AccountMapper.loginInfo", param);
		session.close();
		return result;
	}

	public Account selectAccountByNameAndEmail(AccountDetail account) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Account result = session.selectOne("com.goodee.semi.mapper.AccountMapper.selectAccountByNameAndEmail", account);
		session.close();
		
		return result;
	}
	
	public AccountDetail selectAccountDetail(String accountId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		AccountDetail accountDetail = session.selectOne("com.goodee.semi.mapper.AccountMapper.selectAccountDetail", accountId);
		session.close();
		return accountDetail;
	}

	public int updateAccountDetail(AccountDetail param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.AccountMapper.updateAccountDetail", param);
		session.close();
		return result;
	}

	public int checkIdPw(Account account) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.selectOne("com.goodee.semi.mapper.AccountMapper.checkIdPw", account);
		session.close();
		return result;
	}

	public int deactivateAccount(Account account) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.AccountMapper.deactivateAccount", account);
		session.close();
		return result;
	}
}
