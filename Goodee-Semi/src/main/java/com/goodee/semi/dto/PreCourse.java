package com.goodee.semi.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PreCourse {
	private int preNo;
	private int courseNo;
	private String preTitle;
	private String videoLen;
	
	private String courseTitle;
	private int accountNo;
}
