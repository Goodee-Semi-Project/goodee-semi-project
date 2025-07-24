package com.goodee.semi.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;

import com.goodee.semi.common.constant.HttpConstants;
import com.goodee.semi.common.util.GsonUtil;
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

@WebServlet("/myPet/insert")
@MultipartConfig(
		maxFileSize = 5 * 1024 * 1024, // 개별 파일 최대 크기: 5MB
		maxRequestSize = 10 * 1024 * 1024, // 전체 요청 최대 크기: 10MB
		fileSizeThreshold = 1024 * 1024 // 메모리에 저장할 임계값: 1MB
)
public class MyPetInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PetService service = new PetService();
       
    public MyPetInsertServlet() {
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
    
    private void sendSuccessResponse(String resCode, String resMsg, Pet pet, int targetPage, ServletResponse res) throws IOException {
    	// 응답 객체 생성
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("resCode", resCode);
    	map.put("resMsg", resMsg);    	
    	map.put("targetPage", targetPage);
    	map.put("pet", pet);
    	
    	// Gson으로 전체를 JSON 문자열로 변환
    	String jsonString = GsonUtil.toJson(map);
    	
    	res.setContentType(HttpConstants.CONTENT_TYPE_JSON);
    	res.getWriter().print(jsonString);
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
			int accountNo = Integer.parseInt(request.getParameter("accountNo"));
			Part petImgPart = request.getPart("petImg");
			
			pet.setPetName(petName);
			pet.setPetAge(petAge);
			pet.setPetGender(petGender);
			pet.setPetBreed(petBreed);
			pet.setAccountNo(accountNo);
			
    		// 2. 반려견 이미지가 업로드된 경우 업로드된 이미지파일 저장
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
    				System.out.println("[MyPetInsertServlet] 업로드된 파일의 메타데이터: " + attach);
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
        int result = service.insertPet(pet, attach);
        if (result != 0) {
        	// 페이징
        	pet.setNowPage(1);
            int totalData = service.selectPetCount(pet);
            pet.setTotalData(totalData); // 총 페이지 수가 pet에 set됨
            int targetPage = pet.getTotalPage();
            
        	sendSuccessResponse("200", "반려견 정보 등록에 성공했습니다", pet, targetPage, response);
        	return;
        }

        // 4. 응답 인코딩하고 보내기
        sendErrorResponse("500", "반려견 정보 등록에 실패했습니다", null, response);

	}
}
