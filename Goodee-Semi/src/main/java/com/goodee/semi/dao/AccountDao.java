package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

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

}
