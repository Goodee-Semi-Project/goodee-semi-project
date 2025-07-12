package com.goodee.semi.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.AttachmentDao;
import com.goodee.semi.dao.PetDao;
import com.goodee.semi.dto.Attachment;
import com.goodee.semi.dto.Pet;

public class PetService {
private PetDao petDao = new PetDao();
private AttachmentDao attachmentDao = new AttachmentDao();
	
	public List<Pet> selectPetList(Pet param) {
		return petDao.selectPetList(param);
	}

	public int selectPetCount(Pet param) {
		return petDao.selectPetCount(param);
	}

	public int updatePet(Pet pet, Attachment attachment) {
		System.out.println("updatePetWithAttach() Pet:" + pet);
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			// 1. 반려견 수정
			result = petDao.updatePet(session, pet);
			
			// 2. 파일 정보 등록
			if(attachment != null && result > 0) {
				result = attachmentDao.updateAttachment(session, attachment);
			}
			
			// 3. commit 또는 rollback 처리
			if(result > 0) {
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
	
}
