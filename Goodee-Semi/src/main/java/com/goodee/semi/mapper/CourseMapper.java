package com.goodee.semi.mapper;

import java.util.List;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Enroll;
import com.goodee.semi.dto.Like;
import com.goodee.semi.dto.PetClass;
import com.goodee.semi.dto.Tag;

public interface CourseMapper {
	Course selectCourseOne(String courseNo);
	List<Course> selectCourse(Course course);
	List<Course> selectMyCourse(AccountDetail account);
	List<String> selectCourseNoByKey(Tag tag);
	int updateCourse(Course course);
	Attach selectThumbAttach(Course course);
	Attach selectInputAttach(Course course);
	int insertCourse(Course course);
	int insertAttach(Attach attach);
	int updateCourseThumb(Course course);
	List<Course> selectList(int accountNo);
	List<Course> selectAllCourseByAccountNo(int accountNo);
	List<Attach> selectAllAttachByAccountNo(int accountNo);
	List<Like> selectMyLikeByAccountNo(int accountNo);
	int insertLike(Like like);
	int deleteLike(Like like);
	Enroll selectEnrollOne(int enrollNo);
	List<Enroll> selectMyEnroll(AccountDetail account);
	int insertEnroll(Enroll enroll);
	int updateEnroll(Enroll enroll);
	int deleteEnroll(Enroll enroll);
	int insertPetClass(PetClass petClass);
	
	Tag selectTagByText(Tag tag);
	List<Tag> selectCourseTag(Course course);
	int insertTag(Tag tag);
	int insertCourseTag(Tag tag);
	int deleteCourseTag(Course course);
	List<Course> selectListByPetAccount(int accountNo);
}
