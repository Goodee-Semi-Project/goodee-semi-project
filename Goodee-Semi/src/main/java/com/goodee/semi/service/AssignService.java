package com.goodee.semi.service;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.goodee.semi.common.sql.SqlSessionTemplate;
import com.goodee.semi.dao.AssignDao;
import com.goodee.semi.dao.AssignSubmitDao;
import com.goodee.semi.dao.AttachDao;
import com.goodee.semi.dao.ClassDao;
import com.goodee.semi.dao.CourseDao;
import com.goodee.semi.dao.PetDao;
import com.goodee.semi.dao.ScheduleDao;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Assign;
import com.goodee.semi.dto.AssignSubmit;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Course;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.dto.PetClass;
import com.goodee.semi.dto.Schedule;

import jakarta.servlet.http.Part;

public class AssignService {
	private CourseDao courseDao = new CourseDao();
	private PetDao petDao = new PetDao();
	private ClassDao classDao = new ClassDao();
	private ScheduleDao scheduleDao = new ScheduleDao();
	private AssignDao assignDao = new AssignDao();
	private AttachDao attachDao = new AttachDao();
	private AssignSubmitDao assignSubmitDao = new AssignSubmitDao();

	public List<Course> selectCourseListByAccountDetail(AccountDetail account) {
		return courseDao.selectMyCourse(account);
	}

	public List<Pet> selectPetListByCourseNo(String courseNo) {
		return petDao.selectAllPetByCourseNo(courseNo);
	}

	public List<Schedule> selectScheduleListByCourseNoAndPetNo(String courseNo, String petNo) {
		PetClass petClass = selectClassByCourseNoAndPetNo(courseNo, petNo);
		
		List<Schedule> scheduleList = scheduleDao.selectScheduleListByClassNo(petClass);
		
		return scheduleList;
	}

	public PetClass selectClassByCourseNoAndPetNo(String courseNo, String petNo) {
		PetClass keyObj = new PetClass();
		keyObj.setCourseNo(Integer.parseInt(courseNo));
		keyObj.setPetNo(Integer.parseInt(petNo));
		
		PetClass petClass = classDao.selectClassByCourseNoAndPetNo(keyObj);
		return petClass;
	}

	public int insertAssignWithAttach(Assign assign, Part assignPart) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			
			result = assignDao.insertAssign(session, assign);
			
			if (result > 0) {
				File uploadDir = AttachService.getUploadDirectory(Attach.ASSIGN);
				Attach attach = AttachService.handleUploadFile(assignPart, uploadDir);
				attach.setTypeNo(Attach.ASSIGN);
				attach.setPkNo(assign.getAssignNo());
				
				result = attachDao.insertAttach(session, attach);
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

	public List<PetClass> selectClassListByAccountDetail(AccountDetail account) {
		List<PetClass> classList = classDao.selectClassListByAccountDetail(account);
		
		if (classList != null) {
			for (PetClass petClass : classList) {
				petClass.setCourseThumbAttach(courseDao.selectThumbAttach(courseDao.selectCourseOne(String.valueOf(petClass.getCourseNo()))));
				petClass.setPetAttach(petDao.selectAttachByPetNo(petClass.getPetNo()));
				petClass.setAssignList(assignDao.selectAssignListByClassNo(petClass.getClassNo()));
				
				for (Assign assign : petClass.getAssignList()) {
					assign.setAssignStart(LocalDateTime.parse(assign.getAssignStart(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).format(DateTimeFormatter.ofPattern("MM월 dd일 HH시 mm분")));
					assign.setAssignEnd(LocalDateTime.parse(assign.getAssignEnd(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")).format(DateTimeFormatter.ofPattern("MM월 dd일 HH시 mm분")));
				}
			}
		}
		
		return classList;
	}

	public Attach selectThumbAttach(Course course) {
		return courseDao.selectThumbAttach(course);
	}

	public Attach selectPetAttach(Pet pet) {
		return petDao.selectAttachByPetNo(pet.getPetNo());
	}

	public List<Assign> selectAssignListByClassNo(String classNo) {
		return assignDao.selectAssignListByClassNo(Integer.parseInt(classNo));
	}

	public PetClass selectClass(String classNo) {
		return classDao.selectClass(Integer.parseInt(classNo));
	}

	public Course selectCourse(int courseNo) {
		Course course = courseDao.selectCourseOne(String.valueOf(courseNo));
		course.setThumbAttach(courseDao.selectThumbAttach(course));
		
		return course;
	}

	public Pet selectPet(int petNo) {
		Pet pet = petDao.selectPetOne(petNo);
		pet.setPetAttach(petDao.selectAttachByPetNo(petNo));
		
		return pet;
	}

	public Assign selectAssign(String assignNo) {
		Assign assign = assignDao.selectAssign(Integer.parseInt(assignNo));
		
		if (assign != null) {
			Attach attach = new Attach();
			attach.setTypeNo(Attach.ASSIGN);
			attach.setPkNo(assign.getAssignNo());
			assign.setAssignAttach(attachDao.selectAttachOne(attach));
			
			assign.setAssignSubmit(assignSubmitDao.selectAssignSubmitByAssignNo(Integer.parseInt(assignNo)));
			if (assign.getAssignSubmit() != null) {
				attach.setTypeNo(Attach.SUBMIT);
				attach.setPkNo(assign.getAssignSubmit().getSubmitNo());
				assign.getAssignSubmit().setSubmitAttach(attachDao.selectAttachOne(attach));
			}
		}
		
		return assign;
	}

	public int insertAssignSubmitWithAttach(AssignSubmit assignSubmit, Part submitPart) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			
			result = assignSubmitDao.insertAssignSubmit(session, assignSubmit);
			
			if (result > 0) {
				File uploadDir = AttachService.getUploadDirectory(Attach.SUBMIT);
				Attach attach = AttachService.handleUploadFile(submitPart, uploadDir);
				attach.setTypeNo(Attach.SUBMIT);
				attach.setPkNo(assignSubmit.getSubmitNo());
				
				result = attachDao.insertAttach(session, attach);
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

	public int updateAssignSubmitWithAttach(AssignSubmit assignSubmit, Part submitPart) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			
			result = assignSubmitDao.updateAssignSubmit(session, assignSubmit);
			
			if (result > 0 && submitPart.getSize() > 0) {
				File uploadDir = AttachService.getUploadDirectory(Attach.SUBMIT);
				Attach attach = AttachService.handleUploadFile(submitPart, uploadDir);
				attach.setTypeNo(Attach.SUBMIT);
				attach.setPkNo(assignSubmit.getSubmitNo());
				
				result = attachDao.insertAttach(session, attach);
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

	public int deleteAssignSubmit(String submitNo) {
		return assignSubmitDao.deleteAssignSubmit(Integer.parseInt(submitNo));
	}

	public int updateAssignWithAttach(Assign assign, Part assignPart) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			
			result = assignDao.updateAssign(session, assign);
			
			if (result > 0 && assignPart.getSize() > 0) {
				File uploadDir = AttachService.getUploadDirectory(Attach.ASSIGN);
				Attach attach = AttachService.handleUploadFile(assignPart, uploadDir);
				attach.setTypeNo(Attach.ASSIGN);
				attach.setPkNo(assign.getAssignNo());
				
				result = attachDao.insertAttach(session, attach);
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

	public int deleteAssign(String assignNo) {
		return assignDao.deleteAssign(Integer.parseInt(assignNo));
	}

}
