package com.goodee.semi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/upload/pet/*")
public class MyPetImgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String BASE_DIR = "C:/goodee/upload/pet";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청 경로: /upload/pet/파일명 → 여기서 파일명만 추출
        String requestedPath = request.getPathInfo(); // 예: "/abc.jpg"
        if (requestedPath == null || requestedPath.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "파일명을 지정해야 합니다.");
            return;
        }

        // 보안: ../ 경로 접근 차단
        if (requestedPath.contains("..")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "잘못된 파일 경로입니다.");
            return;
        }

        // 실제 파일 객체
        File file = new File(BASE_DIR, requestedPath);
        if (!file.exists() || file.isDirectory()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "파일이 존재하지 않습니다.");
            return;
        }

        // MIME 타입 설정
        String mime = request.getServletContext().getMimeType(file.getName());
        if (mime == null) mime = "application/octet-stream";
        response.setContentType(mime);

        // 이미지 캐싱을 위한 헤더(Optional)
        response.setHeader("Cache-Control", "max-age=86400"); // 1일 캐싱

        // 바이너리 파일 응답
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int len;
            while ((len = fis.read(buffer)) != -1) {
                out.write(buffer, 0, len);
            }
        }
    }
}
