package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Notice;

public interface NoticeMapper {
	
	public List<Notice> selectList(Notice param);
	public int selectListCount(Notice param);
	int insertNotice(Notice notice);
	int insertAttach(Attach attach);
	Notice selectNoticeDetail(int noticeNo);
	Attach selectAttachOne(Attach param); // ✅ Attach 타입으로 수정
	int updateNotice(Notice notice);     // ✅ 공지사항 수정용
	int updateAttach(Attach attach);     // ✅ 첨부파일 수정용
}
