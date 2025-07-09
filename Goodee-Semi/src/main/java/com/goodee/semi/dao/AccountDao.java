package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.AccountDetail;

public class AccountDao {

	public AccountDetail selectAcountDetail(int userNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		AccountDetail accountDetail = session.selectOne("com.goodee.semi.mapper.AccountMapper.selectAcountDetail", userNo);
		session.close();
		return accountDetail;
	}

	public int updateAccountDetail(AccountDetail param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.AccountMapper.updateAccountDetail", param);
		session.close();
		return result;
	}

}
