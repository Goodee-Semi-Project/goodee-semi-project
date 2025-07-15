package com.goodee.semi.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Schedule {
	private int schedNo;
	private int classNo;
	private int schedStep;
	private LocalDateTime schedDate;
	private LocalDateTime schedStart;
	private LocalDateTime schedEnd;
	private char schedAttend;
}
