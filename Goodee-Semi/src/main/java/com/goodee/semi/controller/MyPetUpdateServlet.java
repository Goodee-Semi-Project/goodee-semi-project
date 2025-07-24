package com.goodee.semi.controller;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.common.constant.HttpConstants;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.service.AttachService;
import com.goodee.semi.service.PetService;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

// TODO 나이 입력란 유효성 검증 로직 추가
@WebServlet("/myPet/update")
@MultipartConfig(
	maxFileSize = 5 * 1024 * 1024, // 개별 파일 최대 크기: 5MB
	maxRequestSize = 10 * 1024 * 1024, // 전체 요청 최대 크기: 10MB
	fileSizeThreshold = 1024 * 1024 // 메모리에 저장할 임계값: 1MB
)
public class MyPetUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PetService service = new PetService();

    public MyPetUpdateServlet() {
        super();
    }
    
    private void sendErrorResponse(String resCode, String resMsg, Exception e, ServletResponse res) throws IOException {
        JSONObject json = new JSONObject();
        json.put("resCode", resCode);
        json.put("resMsg", resMsg);
        
        if(e != null) {        	
        	e.printStackTrace();
        }
        
        res.setContentType(HttpConstants.CONTENT_TYPE_JSON);
        res.getWriter().print(json);
    }
    
    private void sendSuccessResponse(String resCode, String resMsg, Pet pet, ServletResponse res) throws IOException {
    	JSONObject json = new JSONObject();
    	json.put("resCode", resCode);
    	json.put("resMsg", resMsg);
    	
    	// Gson을 사용하여 pet 객체 바인딩
    	Gson gson = new Gson();
    	json.put("pet", gson.toJson(pet));
    	
    	res.setContentType(HttpConstants.CONTENT_TYPE_JSON);
    	res.getWriter().print(json);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       	// 1. request에 바인딩된 값 받아와서 dto에 바인딩
        Pet pet = new Pet();
        Attach attach = null;
        try {
    		// NullPointerException, NumberFormatException, StringIndexOutOfBoundsExceiption 발생 가능 코드
    		String petName = request.getParameter("petName");
    		int petAge = Integer.parseInt(request.getParameter("petAge"));
    		char petGender = request.getParameter("petGender").charAt(0);
    		String petBreed = request.getParameter("petBreed");
    		int petNo = Integer.parseInt(request.getParameter("petNo"));
    		int accountNo = Integer.parseInt(request.getParameter("accountNo"));
    		Part petImgPart = request.getPart("petImg");
    		
    		pet.setPetName(petName);
    		pet.setPetAge(petAge);
    		pet.setPetGender(petGender);
    		pet.setPetBreed(petBreed);
    		pet.setPetNo(petNo);
    		pet.setAccountNo(accountNo);
    		
    		// 2. 반려견 이미지가 수정된 경우 기존 이미지파일 삭제 후 수정된 이미지파일 저장
    		// Part를 받아왔고, Part에 실제 파일이 있는 경우
    		if (petImgPart != null && petImgPart.getSize() > 0) {
    			try { 
    				String fileName = petImgPart.getSubmittedFileName();
    				String fileExt = fileName.substring(fileName.lastIndexOf('.'));
    				String contentType = petImgPart.getContentType();

    				// 파일 MIME 타입 검증
    				if (!(contentType.equals(HttpConstants.CONTENT_TYPE_PNG) || contentType.equals(HttpConstants.CONTENT_TYPE_JPEG))) {
    					sendErrorResponse("400", "PNG, JPG, JPEG 파일만 업로드 가능합니다", null, response);
    			        return;
    				}
    				
    				// 파일 확장자 검증
    				if (!(fileExt.equals(".png") || fileExt.equals(".jpg") || fileExt.equals(".jpeg"))) {
    			        sendErrorResponse("400", "PNG, JPG, JPEG 파일만 업로드 가능합니다", null, response);
    			        return;
    				}
    				
    				// 파일 저장
    				attach = AttachService.handleUploadFile(petImgPart, AttachService.getUploadDirectory(Attach.PET));
    				
    				// 파일 업로드 중 예외가 발생할 수 있음
    				// 혹은 파일 업로드 중 문제가 발생해 attach = null이 되면
    				// 아래 코드들은 null을 참조하게 되어 NullPointerException 발생
    				attach.setTypeNo(Attach.PET);
    				attach.setPkNo(pet.getPetNo());
    				
    				// 기존 이미지파일 삭제
    				// 1) petNo, typeNo로 기존 이미지파일의 savedName을 가져옴
    				// 2) savedName에 해당하는 파일을 저장소에서 삭제
    				String oldSavedName = service.selectPetImgSavedName(attach);
    				System.out.println("[MyPetUpdateServlet] 삭제할 파일명: " + oldSavedName);
    				if (oldSavedName != null) {
	    				File oldSavedFile = new File(AttachService.getUploadDirectory(Attach.PET), oldSavedName);
	    				System.out.println("[MyPetUpdateServlet] 삭제할 파일경로: " + oldSavedFile.getAbsolutePath());
	    				if(oldSavedFile.exists()) {
	    					if (oldSavedFile.delete()) {
	    						System.out.println("[MyPetUpdateServlet] 기존 반려견 이미지 삭제 성공");
	    					} else {
	    						System.out.println("[MyPetUpdateServlet] 기존 반려견 이미지 삭제 실패");
	    					}
	    				} else {
	    					System.out.println("[MyPetUpdateServlet] 기존 반려견 이미지 파일이 존재하지 않음");
	    				}
    				}
    			} catch(Exception e) {
    	            sendErrorResponse("500", "파일 저장/삭제 중 문제가 발생했습니다: " + e.getMessage(), e, response);
    	            return;
    			}
    		}
    	} catch (Exception e) {
    		sendErrorResponse("400", "잘못된 입력 데이터입니다: " + e.getMessage(), e, response);
            return;
		}
        
        // 3. service 호출
        int result = service.updatePet(pet, attach);
        if (result != 0) {
        	sendSuccessResponse("200", "반려견 정보 수정에 성공했습니다", pet, response);
        	return;
        }

        // 4. 응답 인코딩하고 보내기
        sendErrorResponse("500", "반려견 정보 수정에 실패했습니다", null, response);
    }
}