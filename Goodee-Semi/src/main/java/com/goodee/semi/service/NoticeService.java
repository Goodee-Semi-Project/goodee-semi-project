package com.goodee.semi.service;

import java.util.List;

import com.goodee.semi.dao.NoticeDao;
import com.goodee.semi.dto.Notice;

public class NoticeService {
	private NoticeDao dao = new NoticeDao();
			
	public List<Notice> selectList(Notice param){
		return dao.selectList(param);
	}
	
	public int selectListCount(Notice param) {
		return dao.selectListCount(param);
	}
}
