package com.goodee.semi.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Course {
	private int courseNo;
	private int accountNo;
	private String title;
	private String subTitle;
	private String object;
	private int totalStep;
	private int capacity;
	private int thumb;
	
	private String tag;
	
	private Attach thumbAttach;
	private Attach inputAttach;
	
	private String name;
	private Attach profileAttach;
	
	private Pet myPetInCourse;
	private PetClass classData;
	
	private int currentEnrollment;
	private List<Pet> petList;
	private int petInCourseCount;
	private int petNo;

}