package com.goodee.semi.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.json.simple.JSONObject;

import com.goodee.semi.common.constant.HttpConstants;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.service.AttachService;
import com.goodee.semi.service.PetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/myPet/update")
@MultipartConfig
public class MyPetUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PetService petService = new PetService();

    public MyPetUpdateServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resMsg = "반려견 정보 수정에 실패했습니다";
        String resCode = "500";
        JSONObject json = new JSONObject();
    	
    	// 1. request에 바인딩된 값 받아오기
        String petName = null;
        Integer petAge = null;
        Character petGender = null;
        String petBreed = null;
        Integer petNo = null;
        Integer accountNo = null;
        Part petImgPart = null;
        
        try {
    		// NullPointerException, NumberFormatException, StringIndexOutOfBoundsExceiption 발생 가능 코드
    		petName = request.getParameter("petName");
    		petAge = Integer.parseInt(request.getParameter("petAge"));
    		petGender = request.getParameter("petGender").charAt(0);
    		petBreed = request.getParameter("petBreed");
    		petNo = Integer.parseInt(request.getParameter("petNo"));
    		accountNo = Integer.parseInt(request.getParameter("accountNo"));
    		petImgPart = request.getPart("petImg");
    		// request.getPart() == null 인 경우: 키값에 해당하는 데이터 자체가 전송되지 않은 경우 (ex. input 태그가 없거나, 있어도 disabled 상태라 전송이 안되거나 등)
    	} catch (Exception e) {
    		resMsg = "잘못된 입력 데이터입니다: " + e.getMessage();
            resCode = "400";
            json.put("resMsg", resMsg);
            json.put("resCode", resCode);
            e.printStackTrace();
            
            response.setContentType(HttpConstants.CONTENT_TYPE_JSON);
            response.getWriter().print(json);
            
            return;
		}

        // 2. dto에 바인딩 및 반려견 이미지가 수정된 경우 기존 이미지파일 삭제 후 수정된 이미지파일 저장
        Pet pet = new Pet();
        pet.setPetName(petName);
        pet.setPetAge(petAge);
        pet.setPetGender(petGender);
        pet.setPetBreed(petBreed);
        pet.setPetNo(petNo);
        pet.setAccountNo(accountNo);
        
        // Part를 받아왔고, Part에 실제 파일이 있는 경우
        Attach attach = null;
        if (petImgPart != null && petImgPart.getSize() > 0) {
        	attach = AttachService.handleUploadFile(petImgPart, AttachService.getUploadDirectory(Attach.PET));
        	// 파일이 업로드되지 않았다면 attach == null | 업로드됐다면 oriName, sevedName이 바인딩되어 있음
        	attach.setTypeNo(Attach.PET);
        	attach.setPkNo(pet.getPetNo());        	
        }
        
        // 3. service 호출
        int result = petService.updatePet(pet, attach);
        if (result != 0) {
        	// 4. json에 바인딩하여 응답
        	resMsg = "반려견 정보 수정에 성공했습니다";
        	resCode = "200";
        	
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
        }

        // 4. 응답 인코딩하고 보내기
        response.setContentType(HttpConstants.CONTENT_TYPE_JSON);
        response.getWriter().print(json);
    }
}