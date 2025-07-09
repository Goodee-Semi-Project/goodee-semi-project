package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.MyInfo;

public class MyInfoDAO {

	public MyInfo selectMyInfo(int userNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		MyInfo myInfo = session.selectOne("com.goodee.semi.mapper.MyInfoMapper.selectMyInfo", userNo);
		session.close();
		return myInfo;
	}
	
	public int updateMyInfo(MyInfo param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.MyInfoMapper.updateMyInfo", param);
		session.close();
		return result;
	}

}
