package com.goodee.semi.service;

import java.util.List;

import com.goodee.semi.dao.PetDao;
import com.goodee.semi.dto.Pet;

public class PetService {
private PetDao dao = new PetDao();
	
	public List<Pet> selectPetList(Pet param) {
		return dao.selectPetList(param);
	}

	public int selectPetCount(Pet param) {
		return dao.selectPetCount(param);
	}
	
}
