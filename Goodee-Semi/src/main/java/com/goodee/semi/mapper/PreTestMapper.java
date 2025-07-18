package com.goodee.semi.mapper;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.PreTest;

public interface PreTestMapper {
	int insertPreTest(SqlSession session, PreTest pt);
}
