package com.goodee.semi.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.NoticeDao;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Notice;

public class NoticeService {
	private NoticeDao dao = new NoticeDao();
			
	public List<Notice> selectList(Notice param){
		return dao.selectList(param);
	}
	
	public int selectListCount(Notice param) {
		return dao.selectListCount(param);
	}
	
	public int insertNotice(Notice notice, Attach inputAttach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
	        // 1. 게시글 등록
	        result = dao.insertNotice(session, notice);

	       

	        if (result > 0 && inputAttach != null) {
	            // 2. 파일 정보 등록
	            inputAttach.setTypeNo(Attach.NOTICE);
	            inputAttach.setPkNo(notice.getNoticeNo());

	        

	            result = dao.insertAttach(session, inputAttach);
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
	
	public Notice selectNoticeDetail(int noticeNo) {
		return dao.selectNoticeDetail(noticeNo);
	}
	public Attach selectAttachOne(Attach param) {
		
		return dao.selectAttachOne(param);
	}
}
