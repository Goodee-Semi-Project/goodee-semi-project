package com.goodee.semi.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.PreCourse;
import com.goodee.semi.dto.PreTest;
import com.goodee.semi.service.AttachService;
import com.goodee.semi.service.PreCourseService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.probe.FFmpegFormat;
import net.bramp.ffmpeg.probe.FFmpegProbeResult;

/**
 * Servlet implementation class PreCourseRegistServlet
 */
@MultipartConfig (
		fileSizeThreshold = 1024 * 1024,
		maxFileSize = 1024 * 1024 * 200,
		maxRequestSize = 1024 * 1024 * 200
)
@WebServlet("/preCourse/regist")
public class PreCourseRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreCourseService preCourseService = new PreCourseService();
	private AttachService attachService = new AttachService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreCourseRegistServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		Account account = null;
		if (session != null && session.getAttribute("loginAccount") != null) {
			account = (Account) session.getAttribute("loginAccount");
		}
		
		if (account.getAuthor() != 1) {
			response.sendRedirect("/invalidAccess");
			return;
		}
		
		request.getRequestDispatcher("/WEB-INF/views/preCourse/preCourseRegist.jsp").forward(request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		// 사전 학습 등록
		String title = request.getParameter("title");
		int courseNo = -1;
		if (request.getParameter("courseNo") != null) {
			courseNo = Integer.parseInt(request.getParameter("courseNo"));
		}
		
		PreCourse preCourse = null;
		int result = -1;
		if (courseNo != -1) {
			// 첨부 파일
			Part file = null;
			if (request.getPart("attach") != null) {
				file = request.getPart("attach");
			}
			
			Attach attach = null;
			if (file != null) {
				File uploadDir = attachService.getUploadDirectory(Attach.PRE_COURSE);
				attach = attachService.handleUploadFile(file, uploadDir);
			}
			
			// 영상 시간 구하기
			// TODO: FFMpeg 설치하고 ffprobe.exe 경로 입력
			int total = 0;
			if (new File("C:/ffmpeg/bin/ffprobe.exe").exists() == false) {
				System.err.println("FFMpeg 경로 설정이 필요합니다!\n"
						+ "https://github.com/GyanD/codexffmpeg/releases/tag/2025-07-12-git-35a6de137a");
			} else {
				try {
					FFprobe ffprobe = new FFprobe("C:/ffmpeg/bin/ffprobe.exe");
					FFmpegProbeResult probeResult = ffprobe.probe("C://goodee/upload/preCourse/" + attach.getSavedName());
					FFmpegFormat format = probeResult.getFormat();
					total = (int) format.duration;
					
				} catch (Exception e) {
				}
			}
			
			if (new File("C:/ffmpeg/bin/ffprobe.exe").exists() == false) {
				System.err.println("FFMpeg 경로 설정이 필요합니다!");
			}
			
			int hour = total / 360;
			int minute = (total % 360) / 60;
			int second = total % 60;
			
			
			String videoLen = "" + hour + ":" + minute + ":" + second;
			
			preCourse = new PreCourse();
			preCourse.setCourseNo(courseNo);
			preCourse.setPreTitle(title);
			preCourse.setVideoLen(videoLen);
			
			// TODO: 사전 학습 테스트
			
			int count = -1;
			if (request.getParameter("count") != null) {
				count = Integer.parseInt(request.getParameter("count"));
			}
			
			List<PreTest> testList = new ArrayList<PreTest>();
			if (count != -1) {
				String arrStr = request.getParameter("arr");
				String[] arr = arrStr.split(",");
				
				for (int i = 0; i < arr.length; i++) {
					String testContent = request.getParameter("content" + arr[i]);
					String testAnswer = request.getParameter("quiz" + arr[i]);
					String one = request.getParameter("one" + arr[i]);
					String two = request.getParameter("two" + arr[i]);
					String three = request.getParameter("three" + arr[i]);
					String four = request.getParameter("four" + arr[i]);
					
					if (testContent != null && testAnswer != null && one != null && 
							two != null && three != null && four != null) {
						PreTest preTest = new PreTest();
						preTest.setTestContent(testContent);
						preTest.setTestAnswer(testAnswer);
						preTest.setOne(one);
						preTest.setTwo(two);
						preTest.setThree(three);
						preTest.setFour(four);
						
						testList.add(preTest);
					}
				}
			}

			if (attach != null && total == 0) {
				result = -2;
			} else {
				result = preCourseService.updatePreCourse(preCourse, attach);
			}
		}

		JSONObject obj = new JSONObject();
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "사전 학습 생성 완료");
		} else if (result == -2) {
			obj.put("res_code", "501");
			obj.put("res_msg", "FFMpeg 설정이 필요합니다. 서버 관리자에게 문의하세요.");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "등록 실패");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
