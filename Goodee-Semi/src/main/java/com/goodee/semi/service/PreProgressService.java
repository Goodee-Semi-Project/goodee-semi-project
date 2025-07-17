package com.goodee.semi.service;

import com.goodee.semi.dao.PreProgressDao;
import com.goodee.semi.dto.PreProgress;

public class PreProgressService {
	PreProgressDao dao = new PreProgressDao();

	public int insertOneWithAccountNo(PreProgress preProgress) {
		return dao.insertOneWithAccountNo(preProgress);
	}

}
