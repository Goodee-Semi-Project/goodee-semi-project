package com.goodee.semi.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.service.PetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

// TODO 사진 안넣어도 등록되게 하는 기능 추가
// 내 반려견 정보 추가 servlet
@WebServlet("/myPet/insert")
@MultipartConfig
public class MyPetInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PetService service = new PetService();
       
    public MyPetInsertServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 요청값 인코딩
		request.setCharacterEncoding("UTF-8");
		
		// 2. 바인딩된 값 받아와서 Pet, Attachment 객체에 바인딩
		// 텍스트 데이터 받기
		String petName = request.getParameter("petName");
		int petAge = Integer.parseInt(request.getParameter("petAge"));
		char petGender = request.getParameter("petGender").charAt(0);
		String petBreed = request.getParameter("petBreed");
		int accountNo = Integer.parseInt(request.getParameter("accountNo"));
		
		// Pet 객체에 바인딩
		Pet pet = new Pet();
		pet.setPetName(petName);
		pet.setPetAge(petAge);
		pet.setPetGender(petGender);
		pet.setPetBreed(petBreed);
		pet.setAccountNo(accountNo);
		
		// 이미지 파일 받기
		Part petImgPart = request.getPart("petImg");
		System.out.println("petImgPart: " + petImgPart);
		
		String uploadPath = "C:/goodee/upload/pet";
		String oriFileName = petImgPart.getSubmittedFileName();
		String fileExtension;
		String uuid;
		String saveFileName;
		
		Attach attach = new Attach();;

		// 이미지 파일이 업로드된 경우에만 이미지 정보 수정
		if(oriFileName != null) {
			// 업로드된 경우
			// 1. 파일 경로, 이름 지정
			fileExtension = oriFileName.substring(oriFileName.lastIndexOf("."));
			uuid = UUID.randomUUID().toString().replace("-", "");
			saveFileName = uuid + fileExtension;
			
			// 2. 로컬에 파일 저장
			// 1) 폴더 없으면 생성
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
			    uploadDir.mkdirs(); // 폴더 없으면 생성
			}
			
			// 2) 파일 저장
			petImgPart.write(uploadPath + "/" + saveFileName);
			
			// Attachment 객체에 바인딩
			attach.setOriginName(oriFileName);
			attach.setSavedName(saveFileName);
			attach.setTypeNo(2);
		}
				
		// 4. service의 등록 로직 호출 -> 실패: 상태 코드 전달 | 성공: 상태 코드와 수정한 값 전달
		int result = service.insertPet(pet, attach);
		
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
		
		json.put("petName", petName);
		json.put("petAge", petAge);
		json.put("petGender", String.valueOf(petGender));
		// char 타입 값을 그대로 바인딩하면 값이 ''나 ""로 묶여서 바인딩되지 않아 AJAX에서 parserror를 발생시킴
		// => String 타입으로 값 전달
		json.put("petBreed", petBreed);
		json.put("petNo", pet.getPetNo());
		json.put("accountNo", accountNo);
		
		// 7. 응답 인코딩하고 보내기
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(json);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
