package com.goodee.semi.mapper;

import com.goodee.semi.dto.PreProgress;

public interface PreProgressMapper {
	int insertOneWithAccountNo(PreProgress preProgress);
	int selectOne(PreProgress preProgress);
	int update(PreProgress preProgress);
}
