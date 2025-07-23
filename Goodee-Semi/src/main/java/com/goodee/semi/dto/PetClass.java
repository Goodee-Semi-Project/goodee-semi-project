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
public class PetClass {
	private int classNo;
	private int courseNo;
	private int petNo;
	private int classProg;
	
	private String courseTitle;
	private int accountNo;
	private String petName;
	
	private Attach courseThumbAttach;
	private Attach petAttach;
	
	private List<Assign> assignList;
}
