package com.goodee.semi.dto;

import java.time.LocalDate;
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
    private int accountNo;
    private String accountName;

    private int petNo;
    private String petName;

    private int classNo;

    private int schedNo;
    private int schedStep;
    private LocalDate schedDate;
    private LocalDateTime schedStart;
    private LocalDateTime schedEnd;
    private char schedAttend;
    
    private int courseNo;
    private String courseTitle;
    private int courseTotalStep;
}
