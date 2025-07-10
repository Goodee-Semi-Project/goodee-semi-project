package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.Review;

public interface ReviewMapper {
	int selectReviewCount(Review param);
	List<Review> selectReviewList(Review param);
}
