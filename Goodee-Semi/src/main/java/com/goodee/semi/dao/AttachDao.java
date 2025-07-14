package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Attach;

public class AttachDao {
	public Attach selectAttachNo(int attachNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.goodee.semi.mapper.AttachMapper.selectAttachNo", attachNo);
		session.close();
		return attach;
	}
}
