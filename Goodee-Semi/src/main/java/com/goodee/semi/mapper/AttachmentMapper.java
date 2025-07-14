package com.goodee.semi.mapper;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.Attachment;

public interface AttachmentMapper {
	int updateAttachment(SqlSession session, Attachment attach);
	int deleteAttachment(SqlSession session, int petNo);
	int insertAttachment(SqlSession session, Attachment param);
}
