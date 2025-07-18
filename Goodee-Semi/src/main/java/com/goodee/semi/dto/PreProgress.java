package com.goodee.semi.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PreProgress {
	private String progNo;
	private String preNo;
	private String classNo;
	private String watchLen;
	private String preProg;
	
	private int accountNo;
	private int petNo;
}
