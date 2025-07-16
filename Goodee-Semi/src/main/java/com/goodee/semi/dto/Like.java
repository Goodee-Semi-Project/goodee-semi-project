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
public class Like {
	private int pickNo;
	private int courseNo;
	private int accountNo;
	
	private Course courseData;
}
