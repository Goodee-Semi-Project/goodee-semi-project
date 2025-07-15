package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.AccountDetail;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.service.AccountService;
import com.goodee.semi.service.AttachService;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/account/register")
public class AccountRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AccountService accountService = new AccountService();
       
  public AccountRegisterServlet() {
    super();
  }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/account/register.jsp").forward(request, response);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String accountId = request.getParameter("accountId");
		String accountPw = request.getParameter("accountPw");
		
		String accountName = request.getParameter("accountName");
		char accountGender = switch (request.getParameter("accountGender")) { case "1" -> 'M'; case "2" -> 'F'; default -> ' '; };
		String accountBirth = request.getParameter("accountBirth");
		String accountPhone = request.getParameter("accountPhone");
		String accountEmail = request.getParameter("accountEmail");
		
		String postCode = request.getParameter("postcode");
		String address = request.getParameter("roadAddress");
		String addressDetail = request.getParameter("detailAddress");
		
		AccountDetail account = new AccountDetail();
		account.setAuthor(2);
		account.setAccountId(accountId);
		account.setAccountPw(accountPw);
		
		account.setName(accountName);
		account.setGender(accountGender);
		account.setBirth(accountBirth);
		account.setPhone(accountPhone);
		account.setEmail(accountEmail);
		account.setPostNum(postCode);
		account.setAddress(address);
		account.setAddressDetail(addressDetail);
		
		Part profileImage = null;
		try {
			profileImage = request.getPart("profileImage");
		} catch (IOException | ServletException e) { e.printStackTrace(); }
		
		File uploadDir = AttachService.getUploadDirectory(Attach.ACCOUNT);
		Attach profileAttach = AttachService.handleUploadFile(profileImage, uploadDir);
		
		int result = accountService.insertAccount(account, profileAttach);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("resultCode", "500");
		jsonObj.put("resultMsg", "회원 가입 중 오류가 발생했습니다.");
		
		if (result > 0) {
			jsonObj.put("resultCode", "200");
			jsonObj.put("resultMsg", "회원 가입에 성공했습니다!");
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().print(jsonObj);
	}

}
