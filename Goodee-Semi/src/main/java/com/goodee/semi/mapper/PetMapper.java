package com.goodee.semi.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.Pet;

public interface PetMapper {
	 List<Pet> selectPetList(Pet param);
	 int selectPetCount(Pet param);
	 int updatePet(SqlSession session, Pet param);
	 int deletePet(SqlSession session, int petNo);
	 int insertPet(int accountNo);
}
