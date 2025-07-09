package com.goodee.semi.controller;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.MyInfo;
import com.goodee.semi.service.MyInfoService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class myInfoEditDetailServlet
 */
@WebServlet("/myInfo/editDetail")
public class MyInfoEditDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MyInfoService service = new MyInfoService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyInfoEditDetailServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session =request.getSession();
		
		Object userNoObj;
		int userNo = 0;
		if ((userNoObj = session.getAttribute("userNo")) != null && userNoObj instanceof String) {
			userNo = Integer.parseInt((String) userNoObj);
		}
//		String birDate = request.getParameter("birDate");
		char userGender = request.getParameter("userGender").charAt(0);
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String addressDetail = request.getParameter("addressDetail");
		
		MyInfo myInfo = new MyInfo();
		myInfo.setUserNo(userNo);
//		myInfo.setBirDate(birDate);
		myInfo.setUserGender(userGender);
		myInfo.setEmail(email);
		myInfo.setPhone(phone);
		myInfo.setAddress(address);
		myInfo.setAddressDetail(addressDetail);
		
		int result = service.updateMyInfo(myInfo);
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "변경되었습니다.");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "변경 요청에 실패했습니다.");
		}
		
		response.setContentType("applictaion/json; charset=utf-8");
		response.getWriter().print(obj);
		
	}

}
