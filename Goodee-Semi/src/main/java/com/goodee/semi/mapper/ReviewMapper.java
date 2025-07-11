package com.goodee.semi.mapper;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.dto.Review;

public interface ReviewMapper {
	int selectReviewCount(Review param);
	List<Review> selectReviewList(Review param);
	int insertReview(SqlSession session, Review review);
	Review selectReivewOne(int reviewNo);
	int deleteReview(int reviewNo);
}
