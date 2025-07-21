package com.goodee.semi.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.PreTest;

public interface PreTestMapper {
	int insertPreTest(SqlSession session, PreTest pt);
	List<PreTest> selectList(String preNo);
	int update(PreTest preTest);
}
