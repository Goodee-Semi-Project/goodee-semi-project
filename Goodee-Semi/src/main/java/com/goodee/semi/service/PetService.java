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
	private AttachDao attachDao = new AttachDao();
	
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
		System.out.println("updatePetWithAttach() Pet:" + pet);
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			// 1. 반려견 수정
			result = dao.updatePet(session, pet);
			System.out.println("반려견 정보 수정 결과: " + result);
			
			// 2. 파일 정보 등록
			if(result != 0) {
				if (attach != null) {
					System.out.println("attach 있음");
					result = dao.updateAttach(session, attach);
					System.out.println("반려견 이미지 수정 결과: " + result);
				} else {
					System.out.println("attach 없음");
					result = 1;
				}
			}
			System.out.println("반려견 정보&이미지 수정 결과: " + result);
			
			// 3. commit 또는 rollback 처리
			if(result > 0) {
				session.commit();
				System.out.println("반려견 정보&이미지 수정 사항 DB에 반영됨");
			} else {
				session.rollback();
				System.out.println("반려견 정보&이미지 수정 사항 DB에 반영되지 않음");
			}			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
			System.out.println("반려견 정보&이미지 수정 사항 DB에 반영되지 않음");
		} finally {
			session.close();
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
	
}
