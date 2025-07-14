package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Attach;
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
	
	public int insertNotice(SqlSession session, Notice notice) {
		int result = session.insert("com.goodee.semi.mapper.NoticeMapper.insertNotice", notice);
		
		return result;
	}
	public int insertAttach(SqlSession session, Attach inputAttach) {
		int result = session.insert("com.goodee.semi.mapper.NoticeMapper.insertAttach", inputAttach);
		
		return result;
	}
	public Notice selectNoticeDetail(int noticeNo) {
		  SqlSession session = SqlSessionTemplate.getSqlSession(true);
		  Notice notice = session.selectOne("com.goodee.semi.mapper.NoticeMapper.selectNoticeDetail", noticeNo);
		  session.close();
		  return notice;
		}

		public Attach selectAttachOne(Attach param) {
		  SqlSession session = SqlSessionTemplate.getSqlSession(true);
		  Attach attach = session.selectOne("com.goodee.semi.mapper.NoticeMapper.selectAttachOne", param);
		  session.close();
		  return attach;
		}
}
