package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Account;

public class AccountDao {

	public Account loginInfo(Account param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Account result = session.selectOne("com.goodee.semi.mapper.AccountMapper.loginInfo", param);
		session.close();
		return result;
		
	}
}
