package com.goodee.semi.dto;

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
public class Assign {
	private int assignNo;
	private int classNo;
	private int schedNo;
	private String assignTitle;
	private String assignContent;
	private String assignStart;
	private String assignEnd;
	private char assignReceipt;
	
	private Attach assignAttach;
	private int schedStep;
}
