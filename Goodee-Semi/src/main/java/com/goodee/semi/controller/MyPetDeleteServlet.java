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
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/myPet/delete")
public class MyPetDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PetService service = new PetService();
       
    public MyPetDeleteServlet() {
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
    
    private void sendSuccessResponse(String resCode, String resMsg, ServletResponse res) throws IOException {
    	JSONObject json = new JSONObject();
    	json.put("resCode", resCode);
    	json.put("resMsg", resMsg);
    	
    	res.setContentType(HttpConstants.CONTENT_TYPE_JSON);
    	res.getWriter().print(json);
    }

    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer petNo = null; // petNo = 0인 경우와 petNo를 못 받아오는 경우 구분을 위해 Integer 타입으로 선언
		int result = 0;
		
		try {
			// 1. request에 바인딩된 값 받아오기
			petNo = Integer.parseInt(request.getParameter("petNo"));
			
			// 2. 로컬에 저장된 파일 삭제
			Attach attach = new Attach();
			attach.setPkNo(petNo);
			attach.setTypeNo(Attach.PET);
			
			try {
				// 기존 이미지파일 삭제
				// 1) petNo, typeNo로 기존 이미지파일의 savedName을 가져옴
				// 2) savedName에 해당하는 파일을 저장소에서 삭제
				String oldSavedName = service.selectPetImgSavedName(attach);
				System.out.println("[MyPetDeleteServlet] 삭제할 파일명: " + oldSavedName);
				if (oldSavedName != null) {
					File oldSavedFile = new File(AttachService.getUploadDirectory(Attach.PET), oldSavedName);
					System.out.println("[MyPetDeleteServlet] 삭제할 파일경로: " + oldSavedFile.getAbsolutePath());
					if(oldSavedFile.exists()) {
						if (oldSavedFile.delete()) {
							System.out.println("[MyPetDeleteServlet] 기존 반려견 이미지 삭제 성공");
						} else {
							System.out.println("[MyPetDeleteServlet] 기존 반려견 이미지 삭제 실패");
						}
					} else {
						System.out.println("[MyPetDeleteServlet] 기존 반려견 이미지 파일이 존재하지 않음");
					}
				}
			} catch (Exception e) {
				sendErrorResponse("500", "파일 저장/삭제 중 문제가 발생했습니다: " + e.getMessage(), e, response);
	            return;
			}
			
		} catch (Exception e) {
			sendErrorResponse("400", "잘못된 입력 데이터입니다: " + e.getMessage(), e, response);
			return;
		}

		// 3. service의 삭제 로직 호출
		result = service.deletePet(petNo);
		
		// 4. 응답 인코딩하고 보내기
		if(result != 0) {
			sendSuccessResponse("200", "반려견 정보 삭제에 성공했습니다", response);
        	return;
		}
		
		sendErrorResponse("500", "반려견 정보 삭제에 실패했습니다", null, response);
	}
}
