package com.goodee.semi.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.service.PetService;

import jakarta.servlet.ServletException;
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO "로그인이 필요합니다"와 같이 안내 메시지를 응답하는 로직 필요
		// 1. 로그인한 사용자만 접근을 허용하는 로직
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loginAccount") == null) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		
		// 2. session에서 accountNo 가져오기
		AccountDetail accountDetail = (AccountDetail) session.getAttribute("loginAccount");
		Pet param = new Pet();
		param.setAccountNo(accountDetail.getAccountNo());
		
		// 3. 페이징
		// 1) 현재 페이지 정보 셋팅
		try {
			// Integer.parseInt()에서 NumberFormatException 발생 가능성
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
		
		// 4. pet 데이터를 가져와 바인딩
		List<Pet> list = service.selectPetList(param);
		if (list != null) {
		    System.out.println("[MyPetListServlet] 반려견 수: " + list.size());
		} else {
		    System.out.println("[MyPetListServlet] 조회된 반려견 없음");
		    list = new ArrayList<>();  // JSP에서 안전하게 사용할 수 있도록
		}

		request.setAttribute("list", list);
		
		// 5. 페이지 이동
		request.getRequestDispatcher("/WEB-INF/views/my-pet/myPetList.jsp").forward(request, response);
	}
}
