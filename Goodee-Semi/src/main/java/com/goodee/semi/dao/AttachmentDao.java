package com.goodee.semi.dao;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.Attachment;
import com.goodee.semi.mapper.AttachmentMapper;

public class AttachmentDao implements AttachmentMapper {
	@Override
	public int updateAttachment(SqlSession session, Attachment param) {
		return session.update("com.goodee.semi.mapper.AttachmentMapper.updateAttachment", param);
	}
	
}
