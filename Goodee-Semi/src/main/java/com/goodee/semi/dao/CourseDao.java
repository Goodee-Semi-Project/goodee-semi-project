package com.goodee.semi.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Enroll;
import com.goodee.semi.dto.Like;
import com.goodee.semi.dto.PetClass;
import com.goodee.semi.dto.Tag;

public class CourseDao {
	
	public Course selectCourseOne(String courseNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Course course = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectCourseOne", courseNo);
		session.close();
		
		return course;
	}
	
	public List<Course> selectCourse(Course course) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Course> list = session.selectList("com.goodee.semi.mapper.CourseMapper.selectCourse", course);
		session.close();
		
		return list;
	}
	
	public List<Course> selectMyCourse(AccountDetail account) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Course> list = session.selectList("com.goodee.semi.mapper.CourseMapper.selectMyCourse", account);
		session.close();
		
		return list;
	}
	
	public int updateCourse(SqlSession session, Course course) {
		int result = session.update("com.goodee.semi.mapper.CourseMapper.updateCourse", course);
		
		return result;
	}
	
	public Attach selectThumbAttach(Course course) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectThumbAttach", course);
		session.close();
		
		return attach;
	}
	
	public Attach selectInputAttach(Course course) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Attach attach = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectInputAttach", course);
		session.close();
		
		return attach;
	}

	public int insertCourse(SqlSession session, Course course) {
		int result = session.insert("com.goodee.semi.mapper.CourseMapper.insertCourse", course);
		
		return result;
	}
	
	public int insertThumbAttach(SqlSession session, Attach thumbAttach) {
		int result = session.insert("com.goodee.semi.mapper.CourseMapper.insertAttach", thumbAttach);
		
		return result;
	}
	
	public int insertInputAttach(SqlSession session, Attach inputAttach) {
		int result = session.insert("com.goodee.semi.mapper.CourseMapper.insertAttach", inputAttach);
		
		return result;
	}

	public int updateCourseThumb(SqlSession session, Course course) {
		int result = session.update("com.goodee.semi.mapper.CourseMapper.updateCourseThumb", course);
		
		return result;
	}
	
	public List<Like> selectMyLikeByAccountNo(int accountNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Like> likeList = session.selectList("com.goodee.semi.mapper.CourseMapper.selectMyLikeByAccountNo", accountNo);
		session.close();
		
		return likeList;
	}
	
	public Like selectLike(Like like) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Like result = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectLike", like);
		session.close();
		
		return result;
	}

	public int insertLike(Like like) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.insert("com.goodee.semi.mapper.CourseMapper.insertLike", like);
		session.close();
		
		return result;
	}

	public int deleteLike(Like like) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.goodee.semi.mapper.CourseMapper.deleteLike", like);
		session.close();
		
		return result;
	}
	
	public List<Enroll> selectMyEnroll(AccountDetail account) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Enroll> enrollList = session.selectList("com.goodee.semi.mapper.CourseMapper.selectMyEnroll", account);
		session.close();
		
		return enrollList;
	}

	public Enroll selectEnrollOne(int enrollNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Enroll enroll = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectEnrollOne", enrollNo);
		session.close();
		
		return enroll;
	}
	
	public Enroll selectEnrollByCourseNoAndPetNo(Enroll enroll) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Enroll result = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectEnrollByCourseNoAndPetNo", enroll);
		session.close();
		
		return result;
	}

	public int insertEnroll(Enroll enroll) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.insert("com.goodee.semi.mapper.CourseMapper.insertEnroll", enroll);
		session.close();
		
		return result;
	}

	public int updateEnroll(Enroll enroll) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.goodee.semi.mapper.CourseMapper.updateEnroll", enroll);
		session.close();
		
		return result;
	}

	public int deleteEnroll(Enroll enroll) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.goodee.semi.mapper.CourseMapper.deleteEnroll", enroll);
		session.close();
		
		return result;
	}

	public List<Course> selectList(int accountNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Course> list = session.selectList("com.goodee.semi.mapper.CourseMapper.selectList", accountNo);
		session.close();
		return list;
	}

	public int insertPetClass(PetClass petClass) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.insert("com.goodee.semi.mapper.CourseMapper.insertPetClass", petClass);
		session.close();
		
		return result;
	}

	public List<Course> selectAllCourseByAccountNo(int accountNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Course> result = session.selectList("com.goodee.semi.mapper.CourseMapper.selectAllCourseByAccountNo", accountNo);
		session.close();
		return result;
	}
	
	public List<Attach> selectAllAttachByAccountNo(int accountNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Attach> result = session.selectList("com.goodee.semi.mapper.CourseMapper.selectAllAttachByAccountNo", accountNo);
		session.close();
		return result;
	}

	public int insertTag(SqlSession session, Course course) {
		String[] tags = course.getTag().split(" ");
		int result = 0;
		
		for (String tag : tags) {
			result = 0;
			
			Tag myTag = new Tag();
			myTag.setTagText(tag);
			
			result = session.insert("com.goodee.semi.mapper.CourseMapper.insertTag", myTag);
			
			if (result == 0) {
				myTag = session.selectOne("com.goodee.semi.mapper.CourseMapper.selectTagByText", myTag);
				if (myTag != null) result = 1;
			}
			
			if (result > 0) {
				myTag.setCourseNo(course.getCourseNo());
				result = session.insert("com.goodee.semi.mapper.CourseMapper.insertCourseTag", myTag);
			}
			
			if (result <= 0) break;
		}
		
		return result;
	}

	public String selectCourseTag(Course course) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Tag> tags = session.selectList("com.goodee.semi.mapper.CourseMapper.selectCourseTag", course);
		session.close();
		
		StringBuilder stringBuilder = new StringBuilder();
		for (Tag tag : tags) {
			stringBuilder.append(tag.getTagText() + " ");
		}
		
		return stringBuilder.toString().trim();
	}

	public int deleteCourseTag(SqlSession session, Course course) {
		int result = session.delete("com.goodee.semi.mapper.CourseMapper.deleteCourseTag", course);
		
		return result;
	}

	public List<String> selectCourseNoByKey(Tag tag) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<String> courseNoList = session.selectList("com.goodee.semi.mapper.CourseMapper.selectCourseNoByKey", tag);
		session.close();
		
		return courseNoList;
	}

}
