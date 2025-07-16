package com.goodee.semi.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Attach;
import com.goodee.semi.service.AttachService;
import com.goodee.semi.service.NoticeService;


@WebServlet("/noticeDelete")
public class NoticeDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;   
    private NoticeService service = new NoticeService();
    public NoticeDeleteServlet() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
				
		Attach param = new Attach();
		param.setPkNo(noticeNo);
		param.setTypeNo(Attach.NOTICE);

        Attach attach = service.selectAttachOne(param);
        if (attach != null) {
            File oldFile = new File("C:/goodee/upload/notice/" + attach.getSavedName());
            if (oldFile.exists()) oldFile.delete();
           	}
		int result = service.deleteNoticeWithAttach(noticeNo);  
		
		JSONObject obj = new JSONObject();
		obj.put("res_code", "500");
		obj.put("res_msg", "게시글 삭제 중 오류가 발생했습니다.");
		
		if(result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "공지글이 삭제되었습니다.");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}
}


