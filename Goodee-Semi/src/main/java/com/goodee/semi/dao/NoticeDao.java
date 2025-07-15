package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Attach;
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

	public int insertAttach(SqlSession session, Attach inputAttach) {
		return session.insert("com.goodee.semi.mapper.NoticeMapper.insertAttach", inputAttach);
	}

	public Notice selectNoticeDetail(int noticeNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Notice notice = session.selectOne("com.goodee.semi.mapper.NoticeMapper.selectNoticeDetail", noticeNo);
		session.close();
		return notice;
	}

	// 조회 전용 (세션 내부에서 안 쓸 때 사용)
	public Attach selectAttachOne(Attach param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.goodee.semi.mapper.NoticeMapper.selectAttachOne", param);
		session.close();
		return attach;
	}

	// 트랜잭션 중 사용되는 select (세션 재사용용)
	public Attach selectAttachOne(SqlSession session, Attach param) {
		return session.selectOne("com.goodee.semi.mapper.NoticeMapper.selectAttachOne", param);
	}

	public int updateNotice(SqlSession session, Notice notice) {
		return session.update("com.goodee.semi.mapper.NoticeMapper.updateNotice", notice);
	}

	public int updateAttach(SqlSession session, Attach attach) {
		return session.update("com.goodee.semi.mapper.NoticeMapper.updateAttach", attach);
	}
	public int deleteAttachByNoticeNo(SqlSession session, int noticeNo) {
		return session.delete("com.goodee.semi.mapper.NoticeMapper.deleteAttachByNoticeNo", noticeNo);
		
	}
	public int deleteNotice(SqlSession session, int noticeNo) {
		return session.delete("com.goodee.semi.mapper.NoticeMapper.deleteNotice", noticeNo);
		
	}
}
