package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Attach;

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

	public Account selectAccountByIdNameEmail(AccountDetail account) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Account result = session.selectOne("com.goodee.semi.mapper.AccountMapper.selectAccountByIdNameEmail", account);
		session.close();
		
		return result;
	}
	
	public Account selectAccountByPetNo(int petNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Account result = session.selectOne("com.goodee.semi.mapper.AccountMapper.selectAccountByPetNo", petNo);
		session.close();
		
		return result;
	}

	public int updateNewPassword(AccountDetail account) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.insert("com.goodee.semi.mapper.AccountMapper.updateNewPassword", account);
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

	public int updateAccountPw(Account account) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		// TODO: Account dto에 매개변수를 담을 필드가 필요함 - 다른 방식으로 하면 테이블을 두 번 조회하게 됨
		int result = session.update("com.goodee.semi.mapper.AccountMapper.updateAccountPw", account);
		session.close();
		return result;
	}

	public Attach selectAttachByAccountNo(int accountNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.goodee.semi.mapper.AccountMapper.selectAttachByAccountNo", accountNo);
		session.close();
		
		return attach;
	}

	public int deleteAttach(SqlSession session, Attach attach) {
		int result = session.delete("com.goodee.semi.mapper.AccountMapper.deleteAttach", attach);
		return result;
	}

	public int insertAttach(SqlSession session, Attach attach) {
		int result = session.insert("com.goodee.semi.mapper.AccountMapper.insertAttach", attach);
		return result;
	}

	
}
