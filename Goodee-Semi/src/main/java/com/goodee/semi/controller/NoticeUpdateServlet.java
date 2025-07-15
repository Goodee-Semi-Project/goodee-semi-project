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

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.Notice;
import com.goodee.semi.service.AttachService;
import com.goodee.semi.service.NoticeService;

@WebServlet("/noticeUpdate")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB 임시 저장 크기
    maxFileSize = 1024 * 1024 * 5,        // 최대 파일 크기 5MB
    maxRequestSize = 1024 * 1024 * 20     // 전체 요청 크기 20MB
)
public class NoticeUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
   
    private NoticeService service = new NoticeService();

    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String noticeNoStr = request.getParameter("noticeNo");

        if (noticeNoStr == null || noticeNoStr.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "공지번호가 누락되었습니다.");
            return;
        }

        try {
            int noticeNo = Integer.parseInt(noticeNoStr);

            NoticeService service = new NoticeService();
            Notice notice = service.selectNoticeDetail(noticeNo);

            Attach param = new Attach();
            param.setPkNo(noticeNo);
            param.setTypeNo(Attach.NOTICE);
            Attach attach = service.selectAttachOne(param);

            request.setAttribute("notice", notice);
            request.setAttribute("attach", attach);

            request.getRequestDispatcher("/WEB-INF/views/notice/noticeUpdate.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "공지번호가 잘못된 형식입니다.");
        }
    }
    
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String noticeNoStr = request.getParameter("noticeNo");
        if (noticeNoStr == null || noticeNoStr.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "공지번호가 누락되었습니다.");
            return;
        }
        int noticeNo = Integer.parseInt(noticeNoStr);
        // 1. 요청 파라미터 수집
        String noticeTitle = request.getParameter("noticeTitle");
        String noticeContent = request.getParameter("noticeContent");
        Account loginAccount = (Account) request.getSession().getAttribute("loginAccount");
        int accountNo = loginAccount.getAccountNo();

        // 2. 새 파일 업로드 시도
        Part newPart = request.getPart("upfile");
        Attach newAttach = null;

        if (newPart != null && newPart.getSize() > 0) {
            File uploadDir = AttachService.getUploadDirectory(Attach.NOTICE);
            newAttach = AttachService.handleUploadFile(newPart, uploadDir);
        }

        // 3. 기존 파일 삭제 (새 첨부가 있을 경우만)
        if (newAttach != null) {
            Attach param = new Attach();
            param.setPkNo(noticeNo);
            param.setTypeNo(Attach.NOTICE);

            Attach oldAttach = service.selectAttachOne(param);
            if (oldAttach != null) {
                File oldFile = new File("C:/goodee/upload/notice/" + oldAttach.getSavedName());
                if (oldFile.exists()) oldFile.delete();
                newAttach.setAttachNo(oldAttach.getAttachNo());
            }
            newAttach.setPkNo(noticeNo); // 이게 없으면 DB에 어떤 글 첨부인지 모름
            newAttach.setTypeNo(Attach.NOTICE); // 어떤 타입인지도 지정 필요
        }

        // 4. 공지사항 객체 생성
        Notice notice = new Notice();
        notice.setNoticeNo(noticeNo);
        notice.setNoticeTitle(noticeTitle);
        notice.setNoticeContent(noticeContent);
        notice.setAccountNo(accountNo);

        // 5. 공지사항 + 첨부 업데이트 서비스 호출
        int result = service.updateNotice(notice, newAttach);

        // 6. 결과 JSON 응답
        JSONObject obj = new JSONObject();
        if (result > 0) {
            obj.put("resultCode", "200");
            obj.put("resultMsg", "공지사항이 수정되었습니다.");
        } else {
            obj.put("resultCode", "500");
            obj.put("resultMsg", "공지사항 수정 중 오류가 발생했습니다.");
        }

        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().print(obj.toJSONString());
    }
}
