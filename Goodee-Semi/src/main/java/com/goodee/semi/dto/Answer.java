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
public class Answer {
	private int answerNo;
	private int questNo;
	private int userNo;
	private String answerContent;
	private String answerReg;
	private String answerMod;
}
