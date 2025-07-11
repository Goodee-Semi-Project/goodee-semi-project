package com.goodee.semi.common.mail;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class MailSender {
	private static String senderMail = "goodeesemi@gmail.com";
	private static String senderAppPw = "bmlltodlgdiycmhr"; // 테스트 시에만 입력
	
	public static int sendEmail(String toEmail, String authCode) {
		Properties props = getProperties();
		Session session = getSession(props);
		int result = 0;
		
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(toEmail, "훈련소"));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			message.setSubject("인증 코드를 화면의 인증 코드 입력란에 입력해주세요.");
			message.setText("인증 코드: " + authCode);
			
			Transport.send(message);
			result = 1;
		} catch (Exception e) { 
			e.printStackTrace();
		}
		
		return result;
	}
	
	private static Properties getProperties() {
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		
		return props;
	}
	
	private static Session getSession(Properties props) {
		Session session = Session.getDefaultInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(senderMail, senderAppPw);
			}
		});
		
		return session;
	}
}
