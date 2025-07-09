package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.Pet;

public interface PetMapper {
	 List<Pet> selectPetList(Pet param);
	 int selectPetCount(Pet param);
}
