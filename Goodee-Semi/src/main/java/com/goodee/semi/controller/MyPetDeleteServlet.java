package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.service.PetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// 내 반려견 정보 삭제 servlet
@WebServlet("/myPet/delete")
@MultipartConfig
public class MyPetDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PetService service = new PetService();
       
    public MyPetDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 요청값 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. 바인딩된 값 받아오기
		int petNo = Integer.parseInt(request.getParameter("petNo"));
		
		// 4. service의 삭제 로직 호출 -> 실패: 상태 코드 전달 | 성공: 상태 코드와 수정한 값 전달
		int result = service.deletePet(petNo);
		
		// 6. json에 정보 바인딩
		String resCode = "";
		String resMsg = "";
		if (result == 0) {
			resCode = "500";
			resMsg = "반려견 정보 수정 중 오류 발생";
		} else {
			resCode = "200";
			resMsg = "반려견 정보 수정 성공";
		}

		JSONObject json = new JSONObject();
		
		json.put("resCode", resCode);
		json.put("resMsg", resMsg);
		
		// 7. 응답 인코딩하고 보내기
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(json);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
