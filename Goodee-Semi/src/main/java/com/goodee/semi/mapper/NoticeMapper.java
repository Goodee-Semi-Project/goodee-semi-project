package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.Notice;

public interface NoticeMapper {
	
	public List<Notice> selectList(Notice param);
	public int selectListCount(Notice param);
}
