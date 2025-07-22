package com.goodee.semi.dto;

import java.time.LocalDateTime;

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
	private LocalDateTime assignStart;
	private LocalDateTime assignEnd;
	private char assignReceipt;
	
	private Attach assignAttach;
}
