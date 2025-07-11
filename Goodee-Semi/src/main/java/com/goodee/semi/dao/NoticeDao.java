package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Notice;

public class NoticeDao {
	
	public List<Notice> selectList(Notice param){
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Notice> result = session.selectList("com.goodee.semi.mapper.NoticeMapper.selectList", param);
		session.close();
		return result;
	}
	
	public int selectListCount(Notice param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Integer result = session.selectOne("com.goodee.semi.mapper.NoticeMapper.selectListCount", param);
		session.close();
		return result;
	}
}
