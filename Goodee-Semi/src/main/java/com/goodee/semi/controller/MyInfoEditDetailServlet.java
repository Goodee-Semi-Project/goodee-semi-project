package com.goodee.semi.controller;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.service.AccountService;
import com.goodee.semi.service.AttachService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

/**
 * Servlet implementation class myInfoEditDetailServlet
 */
@MultipartConfig (
		fileSizeThreshold = 1024 * 1024,
		maxFileSize = 1024 * 1024 * 5,
		maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/myInfo/editDetail")
public class MyInfoEditDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	AccountService accountService = new AccountService();
	AttachService attachService = new AttachService();
       
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
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		
		Account account = null;
		int accountNo = -1;
		if (session.getAttribute("loginAccount") != null && session.getAttribute("loginAccount") instanceof Account) {
			account = (Account) session.getAttribute("loginAccount");
			accountNo = account.getAccountNo();
		}
		
		int result = -1;
		if (accountNo != -1) {
	//		String birDate = request.getParameter("birDate");
			char gender = request.getParameter("gender").charAt(0);
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String postNum = request.getParameter("postNum");
			String address = request.getParameter("address");
			String addressDetail = request.getParameter("addressDetail").trim();
			
			Attach attach = null;
			Part file = null;
			if ((file = request.getPart("attach")) != null) {
				File uploadDir = attachService.getUploadDirectory(Attach.ACCOUNT);
				attach = attachService.handleUploadFile(file, uploadDir);
			}
			
			AccountDetail accountDetail = new AccountDetail();
			accountDetail.setAccountNo(accountNo);
	//		accountDetail.setBirDate(birDate);
			accountDetail.setGender(gender);
			accountDetail.setEmail(email);
			accountDetail.setPhone(phone);
			accountDetail.setPostNum(postNum);
			accountDetail.setAddress(address);
			accountDetail.setAddressDetail(addressDetail);
			
			if (attach != null) {
				result = accountService.updateAccountDetailWithAttach(accountDetail, attach);
				account.setProfileAttach(attach);
			} else {
				result = accountService.updateAccountDetail(accountDetail);
			}
		}
		
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
