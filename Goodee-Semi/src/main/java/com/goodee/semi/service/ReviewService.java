package com.goodee.semi.service;

import java.util.List;

import com.goodee.semi.dao.ReviewDao;
import com.goodee.semi.dto.Review;

public class ReviewService {
	ReviewDao dao = new ReviewDao();

	public int selectReviewCount(Review param) {
		return dao.selectReviewCount(param);
	}

	public List<Review> selectReviewList(Review param) {
		List<Review> list = dao.selectReviewList(param);
		return list;
	}

}
