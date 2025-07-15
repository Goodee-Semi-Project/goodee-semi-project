package com.goodee.semi.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.NoticeDao;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Notice;

public class NoticeService {
	private NoticeDao dao = new NoticeDao();

	public int updateNotice(Notice notice, Attach newAttach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;

		try {
			// 1. 공지사항 수정
			result = dao.updateNotice(session, notice);

			// 2. 첨부파일 처리 (있으면)
			if (newAttach != null) {
				Attach param = new Attach();
				param.setPkNo(notice.getNoticeNo());
				param.setTypeNo(Attach.NOTICE);

				Attach existing = dao.selectAttachOne(session, param);

				if (existing != null) {
					newAttach.setAttachNo(existing.getAttachNo());
					result += dao.updateAttach(session, newAttach);
				} else {
					newAttach.setPkNo(notice.getNoticeNo());
					newAttach.setTypeNo(Attach.NOTICE);
					result += dao.insertAttach(session, newAttach);
				}
			}

			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}

		return result;
	}

	public int insertNotice(Notice notice, Attach inputAttach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;

		try {
			result = dao.insertNotice(session, notice);

			if (result > 0 && inputAttach != null) {
				inputAttach.setTypeNo(Attach.NOTICE);
				inputAttach.setPkNo(notice.getNoticeNo());
				result = dao.insertAttach(session, inputAttach);
			}

			if (result > 0) session.commit();
			else session.rollback();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}

		return result;
	}

	public List<Notice> selectList(Notice param) {
		return dao.selectList(param);
	}

	public int selectListCount(Notice param) {
		return dao.selectListCount(param);
	}

	public Notice selectNoticeDetail(int noticeNo) {
		return dao.selectNoticeDetail(noticeNo);
	}

	public Attach selectAttachOne(Attach param) {
		return dao.selectAttachOne(param);
	}
}
