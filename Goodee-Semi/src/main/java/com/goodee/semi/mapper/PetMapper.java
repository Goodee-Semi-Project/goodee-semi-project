package com.goodee.semi.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Pet;

public interface PetMapper {
	 List<Pet> selectPetList(Pet param);
	 Pet selectPetOne(int petNo);
	 int selectPetCount(Pet param);
	 List<Pet> selectAllPetByCourseNo(String courseNo);
	 List<Pet> selectMyPetInCourse(Course key);
	 int updatePet(SqlSession session, Pet param);
	 int updateAttach(SqlSession session, Attach param);
	 int deletePet(SqlSession session, int petNo);
	 int deleteAttach(SqlSession session, int petNo);
	 int insertPet(SqlSession session, Pet param);
	 int insertAttach(SqlSession session, Attach param);
	 int countTotalPetNo();
}
