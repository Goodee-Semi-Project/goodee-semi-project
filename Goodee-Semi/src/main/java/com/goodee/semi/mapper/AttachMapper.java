package com.goodee.semi.mapper;

import com.goodee.semi.dto.Attach;

public interface AttachMapper {
	Attach selectAttachNo(int attachNo);
	int updateAttach(Attach attach);
	int deleteAttachByNoticeNo(int noticeNo);
	Attach selectAttachOne(Attach param);
	int insertAttach(Attach attach);
}
