package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.service.PetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// 내 반려견 정보 수정 servlet
@WebServlet("/myPet/update")
public class MyPetUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PetService service = new PetService();
       
    public MyPetUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 요청값 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. 바인딩된 값 받아와서 Pet 객체에 바인딩
		String petName = request.getParameter("petName");
		int petAge = Integer.parseInt(request.getParameter("petAge"));
		char petGender = (request.getParameter("petGender").equals("남")) ? 'M' : 'F';
		String petBreed = request.getParameter("petBreed");
		int petNo = Integer.parseInt(request.getParameter("petNo"));
		int accountNo = Integer.parseInt(request.getParameter("accountNo"));
		
		Pet pet = new Pet();
		pet.setPetName(petName);
		pet.setPetAge(petAge);
		pet.setPetGender(petGender);
		pet.setPetBreed(petBreed);
		pet.setPetNo(petNo);
		pet.setAccountNo(accountNo);
		
		// 4. service의 수정 로직 호출 -> 실패: 상태 코드 전달 | 성공: 상태 코드와 수정한 값 전달
		int result = service.updatePet(pet);
		
		String resCode = "";
		String resMsg = "";
		if (result == 0) {
			resCode = "500";
			resMsg = "반려견 정보 수정 중 오류 발생";
		} else {
			resCode = "200";
			resMsg = "반려견 정보 수정 성공";
		}
		
		// 5. json에 정보 바인딩
		JSONObject json = new JSONObject();
		
		json.put("resCode", resCode);
		json.put("resMsg", resMsg);
		
		json.put("petName", petName);
		json.put("petAge", petAge);
		json.put("petGender", String.valueOf(petGender));
		// char 타입 값을 그대로 바인딩하면 값이 ''나 ""로 묶여서 바인딩되지 않아 AJAX에서 parserror를 발생시킴
		// => String 타입으로 값 전달
		json.put("petBreed", petBreed);
		json.put("petNo", petNo);
		json.put("accountNo", accountNo);
		
		// 6. 응답 인코딩하고 보내기
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(json);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
