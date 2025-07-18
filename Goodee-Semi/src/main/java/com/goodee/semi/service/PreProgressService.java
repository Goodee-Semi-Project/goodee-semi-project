package com.goodee.semi.service;

import com.goodee.semi.dao.PreProgressDao;
import com.goodee.semi.dto.PreProgress;

public class PreProgressService {
	PreProgressDao dao = new PreProgressDao();

	public int insertOneWithAccountNo(PreProgress preProgress) {
		int result = -1;
		
		result = dao.selectOne(preProgress);
		
		if (result > 0) {
			result = -1;
			result = dao.update(preProgress);
		} else {
			result = -1;
			result = dao.insertOneWithAccountNo(preProgress);
		}
		
		return result;
	}

}
