package com.goodee.semi.common.filter;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;

public class PasswordEncryptWrapper extends HttpServletRequestWrapper {

	public PasswordEncryptWrapper(HttpServletRequest request) {
		super(request);
	}

	@Override
	public String getParameter(String param) {
		String result = super.getParameter(param);
		
		if (param.contains("Pw")) {
			result = getSHA512(result);
		}
		
		return result;
	}
	
	private String getSHA512(String originValue) {
		String result = null;
		
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-512");
			byte[] originValueByte = originValue.getBytes();
			
			md.update(originValueByte);
			
			byte[] encryptedValueByte = md.digest();
			result = Base64.getEncoder().encodeToString(encryptedValueByte);
		} catch (NoSuchAlgorithmException e) { e.printStackTrace(); }
		
		return result;
	}
}
