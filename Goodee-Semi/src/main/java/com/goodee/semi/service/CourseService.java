package com.goodee.semi.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.AccountDao;
import com.goodee.semi.dao.CourseDao;
import com.goodee.semi.dao.PetDao;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Enroll;
import com.goodee.semi.dto.Like;
import com.goodee.semi.dto.PetClass;
import com.goodee.semi.dto.Tag;

public class CourseService {
	private CourseDao courseDao = new CourseDao();
	private PetDao petDao = new PetDao();
	private AccountDao accountDao = new AccountDao();
	
	public Course selectCourseOne(String courseNo) {
		Course course = courseDao.selectCourseOne(courseNo);
		
		course.setThumbAttach(courseDao.selectThumbAttach(course));
		course.setInputAttach(courseDao.selectInputAttach(course));
		course.setTag(courseDao.selectCourseTag(course));
		course.setPetInCourseCount(petDao.selectAllPetByCourseNo(String.valueOf(course.getCourseNo())).size());
		
		return course;
	}
	
	public List<Course> selectCourse(Course course) {
		List<Course> courseList = courseDao.selectCourse(course);
		
		for (Course cs : courseList) {
			cs.setThumbAttach(courseDao.selectThumbAttach(cs));
			cs.setInputAttach(courseDao.selectInputAttach(cs));
			cs.setTag(courseDao.selectCourseTag(cs));
			cs.setPetInCourseCount(petDao.selectAllPetByCourseNo(String.valueOf(cs.getCourseNo())).size());
		}
		
		return courseList;
	}
	
	public List<Course> selectMyCourse(AccountDetail account) {
		List<Course> courseList = courseDao.selectMyCourse(account);
		
		for (Course cs : courseList) {
			cs.setThumbAttach(courseDao.selectThumbAttach(cs));
			cs.setInputAttach(courseDao.selectInputAttach(cs));
			cs.setTag(courseDao.selectCourseTag(cs));
		}
		
		return courseList;
	}

	public int insertCourse(Course course, Attach thumbAttach, Attach inputAttach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			result = courseDao.insertCourse(session, course);
			
			if (result > 0) result = courseDao.insertTag(session, course);
			
			if (result > 0) {
				thumbAttach.setTypeNo(Attach.COURSE);
				inputAttach.setTypeNo(Attach.COURSE);
				
				thumbAttach.setPkNo(course.getCourseNo());
				inputAttach.setPkNo(course.getCourseNo());
				
				result = courseDao.insertThumbAttach(session, thumbAttach);
				
				if (result > 0) result = courseDao.insertInputAttach(session, inputAttach);
			}
			
			if (result > 0) {
				course.setThumb(thumbAttach.getAttachNo());
				result = courseDao.updateCourseThumb(session, course);
			}
			
			if (result > 0) session.commit();
			else session.rollback();
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}

	public List<Course> selectList(int accountNo) {
		List<Course> list = courseDao.selectList(accountNo);
		return list;
	}
 
  public List<Course> selectAllCourseByAccountNo(int accountNo) {
		List<Course> courseList = courseDao.selectAllCourseByAccountNo(accountNo);
		List<Attach> attachList = courseDao.selectAllAttachByAccountNo(accountNo);
		
		if(courseList != null && attachList != null) {
			for(int i = 0; i < courseList.size(); i++) {
				courseList.get(i).setThumbAttach(attachList.get(i));
			}
		}
		return courseList;
  }
  
  public int updateCourse(Course course, Attach thumbAttach, Attach inputAttach) {
  	SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			
			result = courseDao.updateCourse(session, course);
			
			if (result > 0) {
				result = courseDao.deleteCourseTag(session, course);
				result = courseDao.insertTag(session, course);
			}
			
			if (result > 0 && thumbAttach != null) {
				thumbAttach.setTypeNo(Attach.COURSE);
				thumbAttach.setPkNo(course.getCourseNo());
				
				result = courseDao.insertThumbAttach(session, thumbAttach);
				
				if (result > 0) {
					course.setThumb(thumbAttach.getAttachNo());
					result = courseDao.updateCourseThumb(session, course);
				}
			}
			
			if (result > 0 && inputAttach != null) {
				inputAttach.setTypeNo(Attach.COURSE);
				inputAttach.setPkNo(course.getCourseNo());
				
				result = courseDao.insertInputAttach(session, inputAttach);
			}
			
			if (result > 0) session.commit();
			else session.rollback();
			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		
		return result;
	}
	
	public List<Like> selectMyLikeByAccountNo(int accountNo) {
		List<Like> likeList = courseDao.selectMyLikeByAccountNo(accountNo);
		
		if (likeList.size() > 0) {
			for (Like like : likeList) {
				like.setCourseData(courseDao.selectCourseOne(String.valueOf(like.getCourseNo())));
			}
		}
		
		return likeList;
	}
	
	public Like selectLike(Like like) {
		return courseDao.selectLike(like);
	}

	public int insertLike(Like like) {
		return courseDao.insertLike(like);
	}

	public int deleteLike(Like like) {
		return courseDao.deleteLike(like);
	}
	
	public List<Enroll> selectMyEnroll(AccountDetail account) {
		List<Enroll> enrollList = courseDao.selectMyEnroll(account);
		
		if (enrollList.size() > 0) {
			for (Enroll enroll : enrollList) {
				Course course = courseDao.selectCourseOne(String.valueOf(enroll.getCourseNo()));
				course.setPetInCourseCount(petDao.selectAllPetByCourseNo(String.valueOf(course.getCourseNo())).size());
				
				enroll.setCourseData(course);
				enroll.setPetData(petDao.selectPetOne(enroll.getPetNo()));
				enroll.setAccountData(accountDao.selectAccountByPetNo(enroll.getPetNo()));
			}
		}
		
		return enrollList;
	}

	public Enroll selectEnrollOne(int enrollNo) {
		return courseDao.selectEnrollOne(enrollNo);
	}
	
	public Enroll selectEnrollByCourseNoAndPetNo(Enroll enroll) {
		return courseDao.selectEnrollByCourseNoAndPetNo(enroll);
	}

	public int insertEnroll(Enroll enroll) {
		return courseDao.insertEnroll(enroll);
	}

	public int updateEnroll(Enroll enroll) {
		return courseDao.updateEnroll(enroll);
	}

	public int deleteEnroll(Enroll enroll) {
		return courseDao.deleteEnroll(enroll);
	}

	public int insertPetClass(PetClass petClass) {
		return courseDao.insertPetClass(petClass);
	}

	public List<Course> selectCourseByTag(String keyTag) {
		List<String> keyTags = Arrays.asList(keyTag.split(" "));
		
		Tag tag = new Tag();
		tag.setKeyTag(keyTags);
		tag.setTotalTags(keyTags.size());
		
		List<String> courseNoList = courseDao.selectCourseNoByKey(tag);
		
		List<Course> courseList = new ArrayList<Course>();
		if (courseNoList.size() > 0) {
			for (String courseNo : courseNoList) {
				courseList.add(courseDao.selectCourseOne(courseNo));
			}
			
			for (Course cs : courseList) {
				cs.setThumbAttach(courseDao.selectThumbAttach(cs));
				cs.setInputAttach(courseDao.selectInputAttach(cs));
				cs.setTag(courseDao.selectCourseTag(cs));
				cs.setPetInCourseCount(petDao.selectAllPetByCourseNo(String.valueOf(cs.getCourseNo())).size());
			}
		}
		
		return courseList;
	}
	
}
