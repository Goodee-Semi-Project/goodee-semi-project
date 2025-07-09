package com.goodee.semi.service;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;

public class MemberService {
	
	public Member getLoginInfo() {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Member result = session.selectOne("com.goodee.")
	}
}
