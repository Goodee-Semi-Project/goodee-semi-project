package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.Review;

public class ReviewDao {

	public int selectReviewCount(Review param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int count = session.selectOne("com.goodee.semi.mapper.ReviewMapper.selectReviewCount", param);
		session.close();
		return count;
	}

	public List<Review> selectReviewList(Review param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Review> list = session.selectList("com.goodee.semi.mapper.ReviewMapper.selectReviewList", param);
		session.close();
		return list;
	}

	public int insertReview(SqlSession session, Review review) {
		int result = session.insert("com.goodee.semi.mapper.ReviewMapper.insertReview", review);
		return result;
	}

	public Review selectReivewOne(int reviewNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Review review = session.selectOne("com.goodee.semi.mapper.ReviewMapper.selectReivewOne", reviewNo);
		session.close();
		return review;
	}

	public int deleteReview(int reviewNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.goodee.semi.mapper.ReviewMapper.deleteReview", reviewNo);
		session.close();
		return result;
	}

}
