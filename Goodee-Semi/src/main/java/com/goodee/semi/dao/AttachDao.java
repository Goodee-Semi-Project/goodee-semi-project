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
	
	public int updateAttach(SqlSession session, Attach attach) {
		return session.update("com.goodee.semi.mapper.AttachMapper.updateAttach", attach);
	}
	public int deleteAttachByNoticeNo(SqlSession session, int noticeNo) {
		return session.delete("com.goodee.semi.mapper.AttachMapper.deleteAttachByNoticeNo", noticeNo);
		
	}
	public Attach selectAttachOne(SqlSession session, Attach param) {
		return session.selectOne("com.goodee.semi.mapper.AttachMapper.selectAttachOne", param);
	}
	public int insertAttach(SqlSession session, Attach inputAttach) {
		return session.insert("com.goodee.semi.mapper.AttachMapper.insertAttach", inputAttach);
	}


	public Attach selectAttachOne(Attach param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.goodee.semi.mapper.AttachMapper.selectAttachOne", param);
		session.close();
		return attach;
	}
}
