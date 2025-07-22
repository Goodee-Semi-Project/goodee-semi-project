package com.goodee.semi.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.AttachDao;
import com.goodee.semi.dao.PetDao;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Pet;

public class PetService {
	private PetDao dao = new PetDao();
	
	public List<Pet> selectPetList(Pet param) {
		return dao.selectPetList(param);
	}
	
	public List<Pet> selectAllPetByCourseNo(String courseNo) {
		return dao.selectAllPetByCourseNo(courseNo);
	}

	public int selectPetCount(Pet param) {
		return dao.selectPetCount(param);
	}

	public int updatePet(Pet pet, Attach attach) {
		SqlSession session = null;
		int result = 0;
		
		try {
			session = SqlSessionTemplate.getSqlSession(false);
			
			// 1. 반려견 정보 수정
			int petResult = dao.updatePet(session, pet);
			
			// 2. 반려견 이미지 수정
			int attachResult = 1; // 기본값: 성공
			if(petResult != 0 && attach != null) {
				if (dao.selectAttach(session, attach) != null) {
					// 기존에 반려견 이미지가 있었다면 -> attachment 테이블의 정보 수정
					attachResult = dao.updateAttach(session, attach);
				} else {
					// 기존에 반려견 이미지가 없었다면 -> attachment 테이블에 정보 추가
					attachResult = dao.insertAttach(session, attach);
				}
			}
			
			// 3. commit 또는 rollback 처리
			if(petResult != 0 && attachResult != 0) {
				session.commit();
				result = 1;
				System.out.println("[PetService] 반려견 정보 수정 성공 - petNo: " + pet.getPetNo()
									+ ", 이미지 포함: " + (attach == null ? "N" : "Y"));
			} else {
				session.rollback();
				System.out.println("[PetService] 반려견 정보 수정 실패 - petNo: " + pet.getPetNo()
									+ ", petResult: " + petResult + ",  attachResult: " + attachResult);
			}			
		} catch (Exception e) {
			if (session != null) session.rollback();
			System.out.println("[PetService] 반려견 정보 수정 중 예기치못한 문제 발생: " + e.getMessage());
			e.printStackTrace();
		} finally {
			if (session != null) session.close();
		}
		
		return result;
	}

	public int deletePet(int petNo) {
		System.out.println("DeletePetWithAttach() petNo:" + petNo);
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			// 1. 반려견 삭제
			result = dao.deletePet(session, petNo);
			
			// 2. 파일 정보 삭제
			result = dao.deleteAttach(session, petNo);
			
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

	public int insertPet(Pet pet, Attach attach) {
		System.out.println("insertPetWithAttach() Pet:" + pet);
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			// 1. 반려견 등록
			result = dao.insertPet(session, pet);
			
			// 2. 파일 정보 등록
			if(attach != null && result > 0) {
				attach.setPkNo(pet.getPetNo());
				result = dao.insertAttach(session, attach);
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

	public List<Pet> selectMyPetInCourse(Course course, AccountDetail account) {
		Course key = new Course();
		key.setCourseNo(course.getCourseNo());
		key.setAccountNo(account.getAccountNo());
		
		List<Pet> petList = dao.selectMyPetInCourse(key);
		
		return petList;
	}
	
	public int countTotalPetNo() {
		return dao.countTotalPetNo();
	}

	public String selectPetImgSavedName(Attach attach) {
		return dao.selectPetImgSavedName(attach);
	}
	
	public Attach selectAttachByPetNo(int petNo) {
		return dao.selectAttachByPetNo(petNo);
		
	}
}
