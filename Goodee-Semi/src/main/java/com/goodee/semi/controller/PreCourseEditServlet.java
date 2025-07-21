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
import com.goodee.semi.service.PreTestService;

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
 * Servlet implementation class PreCourseEditServlet
 */
@MultipartConfig (
		fileSizeThreshold = 1024 * 1024,
		maxFileSize = 1024 * 1024 * 200,
		maxRequestSize = 1024 * 1024 * 200
)
@WebServlet("/preCourse/edit")
public class PreCourseEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreCourseService preCourseService = new PreCourseService();
	private AttachService attachService = new AttachService();
	private PreTestService preTestService = new PreTestService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreCourseEditServlet() {
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
		
		int preNo = -1;
		PreCourse preCourse = null;
		if (request.getParameter("no") != null) {
			preNo = Integer.parseInt(request.getParameter("no"));
			preCourse = preCourseService.selectPreCourse(preNo);
		}
		
		if (preCourse != null && preCourse.getAccountNo() != account.getAccountNo()) {
			
			request.getRequestDispatcher("/preCourse/list").forward(request, response);
			return;
		}
//		Attach attach = preCourseService.selectAttach(preNo);
		
		List<PreTest> list = preTestService.selectList(String.valueOf(preNo));
		
		request.setAttribute("list", list);
		
		request.setAttribute("preCourse", preCourse);
		request.getRequestDispatcher("/WEB-INF/views/preCourse/preCourseEdit.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// 사전 학습 수정
		String title = request.getParameter("title");
		int courseNo = -1;
		if (request.getParameter("courseNo") != null) {
			courseNo = Integer.parseInt(request.getParameter("courseNo"));
		}
		int preNo = -1;
		if (request.getParameter("preNo") != null) {
			preNo = Integer.parseInt(request.getParameter("preNo"));
		}
		
		int result = -1;
		if (courseNo != -1 && preNo != -1) {
			// 첨부 파일
			Part file = null;
			if (request.getPart("attach") != null) {
				file = request.getPart("attach");
			}
			
			Attach attach = null;
			int total = 0;
			if (file != null) {
				File uploadDir = attachService.getUploadDirectory(Attach.PRE_COURSE);
				attach = attachService.handleUploadFile(file, uploadDir);
				
				// 영상 시간 구하기
				// TODO: FFMpeg 설치하고 ffprobe.exe 경로 입력
				try {
					FFprobe ffprobe = new FFprobe("C://ffmpeg/bin/ffprobe.exe");
					FFmpegProbeResult probeResult = ffprobe.probe("C://goodee/upload/preCourse/" + attach.getSavedName());
					FFmpegFormat format = probeResult.getFormat();
					total = (int) format.duration;
					
				} catch (Exception e) {
				}
			}
			
			
			int hour = total / 360;
			int minute = (total % 360) / 60;
			int second = total % 60;
			
			
			String videoLen = "" + hour + ":" + minute + ":" + second;

			PreCourse preCourse = new PreCourse();
			preCourse.setPreNo(preNo);
			preCourse.setCourseNo(courseNo);
			preCourse.setPreTitle(title);
			if (attach != null) {
				preCourse.setVideoLen(videoLen);
			} else {
				preCourse.setVideoLen(request.getParameter("videoLen"));
			}
			
			result = preCourseService.updatePreCourse(preCourse, attach);
			
			// 테스트 수정
			if (result > 0) {
				int size = -1;
				if (request.getParameter("size") != null) {
					size = Integer.parseInt(request.getParameter("size"));
				}
				
				if (size > 0) {
					List<PreTest> list = new ArrayList<PreTest>();
					
					for (int i = 0; i < size; i++) {
						PreTest preTest = new PreTest();
						String testNo = request.getParameter("test" + i + "No");
						if (testNo == null) testNo = "-1";
						preTest.setTestNo(testNo);
						preTest.setPreNo(preNo);
						preTest.setTestContent(request.getParameter("content" + i));
						preTest.setTestAnswer(request.getParameter("quiz" + i));
						preTest.setOne(request.getParameter("one" + i));
						preTest.setTwo(request.getParameter("two" + i));
						preTest.setThree(request.getParameter("three" + i));
						preTest.setFour(request.getParameter("four" + i));
						
						list.add(preTest);
					}
					
					result = preTestService.updateList(list);
				}
			}
		}

		JSONObject obj = new JSONObject();
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "사전 학습 수정 완료");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "수정 실패");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
