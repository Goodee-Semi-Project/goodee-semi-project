package com.goodee.semi.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Pet;

public interface PetMapper {
	 List<Pet> selectPetList(Pet param);
	 Pet selectPetOne(int petNo);
	 int selectPetCount(Pet param);
	 List<Pet> selectAllPetByCourseNo(String courseNo);
	 int updatePet(Pet param);
	 int updateAttach(Attach param);
	 int deletePet(int petNo);
	 int deleteAttach(int petNo);
	 int insertPet(Pet param);
	 int insertAttach(Attach param);
}
