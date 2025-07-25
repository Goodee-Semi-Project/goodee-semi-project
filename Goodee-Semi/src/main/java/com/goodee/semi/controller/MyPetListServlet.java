package com.goodee.semi.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;

import com.goodee.semi.common.constant.HttpConstants;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.service.PetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/myPet/list")
public class MyPetListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PetService service = new PetService();
       
    public MyPetListServlet() {
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
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO "로그인이 필요합니다"와 같이 안내 메시지를 응답하는 로직 필요
		// 1. session에서 account 정보 가져오기
		AccountDetail accountDetail = (AccountDetail) request.getSession(false).getAttribute("loginAccount");
		Pet param = new Pet();
		param.setAccountNo(accountDetail.getAccountNo());
		
		// 2. 페이징
		// 1) 현재 페이지 정보 셋팅
		try {
			// Integer.parseInt()에서 NumberFormatException 발생 가능성
			param.setNumPerPage(5); // 반려견 페이지에서는 5개씩 보이도록;
			String nowPageStr = request.getParameter("nowPage");
			int nowPage = (nowPageStr == null)? 1 : Integer.parseInt(nowPageStr);
			param.setNowPage(nowPage);
		} catch (Exception e) {
			System.out.println("[MyPetListServlet] 잘못된 입력 데이터: " + e.getMessage());
			e.printStackTrace();
			param.setNowPage(1); // 현재 페이지에 1을 넣고 계속 진행
		}
		
		// 2) 전체 게시글 개수 조회
		int totalData = service.selectPetCount(param);
		param.setTotalData(totalData);
		
		// 3) 페이징 정보 바인딩
		request.setAttribute("paging", param);
		
		// 3. pet 데이터를 가져와 바인딩
		List<Pet> list = new ArrayList<>(); //기본값: not null(JSP에서 안전하게 사용할 수 있도록)
		String msg = "";
		try {
			list = service.selectPetList(param);
			
			if (list.isEmpty()) {
				System.out.println("[MyPetListServlet] 조회된 반려견 없음");
				msg = "훈련을 함께할 반려견을 등록해 주세요.";
			} else {
				System.out.println("[MyPetListServlet] 반려견 수: " + list.size());
			}
		} catch(Exception e) {
			System.out.println("[MyPetListServlet] 반려견 정보 조회 실패: " + e.getMessage());
			e.printStackTrace();
			// 실패해도 그대로 페이지 이동
		}
		
		// TODO 클라이언트 단에서 list.isEmpty() 인 경우, 그렇지 않은 경우 처리
		// 4. 페이지 이동
		request.setAttribute("msg", msg);
		request.setAttribute("list", list);
		request.getRequestDispatcher("/WEB-INF/views/my-pet/myPetList.jsp").forward(request, response);
	}
}
