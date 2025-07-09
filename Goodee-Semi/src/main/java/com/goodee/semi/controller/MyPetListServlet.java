package com.goodee.semi.controller;

import java.io.IOException;
import java.util.List;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Pet;
import com.goodee.semi.service.PetService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// 내 반려견 리스트 페이지 조작 servlet
@WebServlet("/myPet/list")
public class MyPetListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PetService service = new PetService();
       
    public MyPetListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 로그인한 사용자만 접근을 허용하는 로직
		HttpSession session = request.getSession(false);
		if (session == null) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		} else if(session.getAttribute("loginAccount") == null) {
			response.sendRedirect(request.getContextPath() + "/");
			return;
		}
		
		// 2. session에서 accountNo 가져오기
		Account account = (Account) session.getAttribute("loginAccount");
		Pet param = new Pet();
		param.setAccountNo(account.getAccountNo());
		
		// 3. 페이징
		// 1) 현재 페이지 정보 셋팅
		String nowPageStr = request.getParameter("nowPage");
		int nowPage = (nowPageStr == null) ? 1 : Integer.parseInt(nowPageStr);
		param.setNowPage(nowPage);
		
		// 2) 전체 게시글 개수 조회
		int totalData = service.selectPetCount(param);
		param.setTotalData(totalData);
		
		// 3) 페이징 정보 바인딩
		request.setAttribute("paging", param);
		
		// 4. pet 데이터를 가져와 바인딩
		List<Pet> list = service.selectPetList(param);
		request.setAttribute("list", list);
		
		// 5. 페이지 이동
		request.getRequestDispatcher("/WEB-INF/views/passing7by/my-pet/myPetList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
