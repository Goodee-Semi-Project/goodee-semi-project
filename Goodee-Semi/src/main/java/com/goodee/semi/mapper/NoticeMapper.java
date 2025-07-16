package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Notice;

public interface NoticeMapper {
	
	public List<Notice> selectList(Notice param);
	public int selectListCount(Notice param);
	int insertNotice(Notice notice);
	
	Notice selectNoticeDetail(int noticeNo);
	int updateNotice(Notice notice);     
	int deleteNotice(int noticeNo);
}
