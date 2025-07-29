package com.goodee.semi.dto;

import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Enroll {
	private int enrollNo;
	private int courseNo;
	private int petNo;
	private char enrollStatus;
	
	private Course courseData;
	private Pet petData;
	private Account accountData;
}
