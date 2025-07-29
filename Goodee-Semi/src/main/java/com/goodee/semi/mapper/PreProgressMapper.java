package com.goodee.semi.mapper;

import com.goodee.semi.dto.PreProgress;

public interface PreProgressMapper {
	int insertOneWithAccountNo(PreProgress preProgress);
	int countOne(PreProgress preProgress);
	int update(PreProgress preProgress);
	PreProgress selectOne(PreProgress param);
	PreProgress selectProg(PreProgress param);
}
