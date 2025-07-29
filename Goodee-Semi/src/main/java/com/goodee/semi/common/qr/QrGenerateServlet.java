
package com.goodee.semi.common.qr;

import java.io.IOException;

import com.goodee.semi.dto.Schedule;
import com.goodee.semi.service.ScheduleService;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// QR 생성 서블릿
@WebServlet("/qr/generate")
public class QrGenerateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ScheduleService scheduleService = new ScheduleService();  
	
    public QrGenerateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String schedNoStr =  request.getParameter("schedNo");
		String petNo = request.getParameter("petNo");
		String courseNo = request.getParameter("courseNo");
		
		if (schedNoStr == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "shedNo is required.");
			return;
		}
		
		// 주소값을 기반으로 생성됨
		String qrContent = "http://your-ip-address/qr/attend?schedNo="+schedNoStr+"&petNo="+petNo+"&courseNo="+courseNo;
		
		int width = 400;
		int height = 400;
		
		try {
			QRCodeWriter qrWriter = new QRCodeWriter();
			BitMatrix matrix = qrWriter.encode(qrContent, BarcodeFormat.QR_CODE, width, height);
			
			response.setContentType("image/png");
			ServletOutputStream out = response.getOutputStream();
			MatrixToImageWriter.writeToStream(matrix, "PNG", out);
			out.flush();
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "QR 생성 실패");
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
