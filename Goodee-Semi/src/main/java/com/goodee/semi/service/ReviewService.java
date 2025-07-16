package com.goodee.semi.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.ReviewDao;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Review;

public class ReviewService {
	ReviewDao reviewDao = new ReviewDao();

	public int selectReviewCount(Review param) {
		return reviewDao.selectReviewCount(param);
	}

	public List<Review> selectReviewList(Review param) {
		List<Review> list = reviewDao.selectReviewList(param);
		return list;
	}

	public int insertReview(Review review) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = -1;
		
		// 첨부파일 클래스, DAO가 정해지면 트랜잭션으로 처리
		try {
			result = reviewDao.insertReview(session, review);
			
			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}

	public Review selectReivewOne(int reviewNo) {
		Review review = reviewDao.selectReivewOne(reviewNo);
		return review;
	}

	public int deleteReview(int reviewNo) {
		int result = reviewDao.deleteReview(reviewNo);
		
		Attach attach = new Attach();
		attach.setTypeNo(Attach.REVIEW);
		attach.setPkNo(reviewNo);
		reviewDao.deleteAttach(attach);
		
		return result;
	}

	public int updateReview(Review review) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = -1;
		
		// 첨부파일 클래스, DAO가 정해지면 트랜잭션으로 처리
		try {
			result = reviewDao.updateReview(session, review);
			
			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}

	public int insertReviewWithAttach(Review review, Attach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = -1;
		
		// 첨부파일 클래스, DAO가 정해지면 트랜잭션으로 처리
		try {
			result = reviewDao.insertReview(session, review);
			
			if (attach != null && result > 0) {
				attach.setTypeNo(Attach.REVIEW);
				attach.setPkNo(review.getReviewNo());
				result = reviewDao.insertAttach(session, attach);
			}
			
			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}

	public Attach selectAttachByReviewNo(int reviewNo) {
		return reviewDao.selectAttachByReviewNo(reviewNo);
	}

	public int updateReviewWithAttach(Review review, Attach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = -1;
		
		// 첨부파일 클래스, DAO가 정해지면 트랜잭션으로 처리
		try {
			result = reviewDao.updateReview(session, review);
			
			if (attach != null && result > 0) {
				attach.setTypeNo(Attach.REVIEW);
				attach.setPkNo(review.getReviewNo());
				reviewDao.deleteAttach(attach);
				result = reviewDao.insertAttach(session, attach);
			}
			
			if (result > 0) {
				session.commit();
			} else {
				session.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}

}
