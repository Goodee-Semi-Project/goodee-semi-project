package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;

import com.goodee.semi.dto.Notice;

public class NoticeDao {

	public List<Notice> selectList(Notice param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Notice> result = session.selectList("com.goodee.semi.mapper.NoticeMapper.selectList", param);
		session.close();
		return result;
	}

	public int selectListCount(Notice param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.selectOne("com.goodee.semi.mapper.NoticeMapper.selectListCount", param);
		session.close();
		return result;
	}

	public int insertNotice(SqlSession session, Notice notice) {
		return session.insert("com.goodee.semi.mapper.NoticeMapper.insertNotice", notice);
	}


	public Notice selectNoticeDetail(int noticeNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Notice notice = session.selectOne("com.goodee.semi.mapper.NoticeMapper.selectNoticeDetail", noticeNo);
		session.close();
		return notice;
	}


	public int updateNotice(SqlSession session, Notice notice) {
		return session.update("com.goodee.semi.mapper.NoticeMapper.updateNotice", notice);
	}

	public int deleteNotice(SqlSession session, int noticeNo) {
		return session.delete("com.goodee.semi.mapper.NoticeMapper.deleteNotice", noticeNo);
		
	}

	
}
