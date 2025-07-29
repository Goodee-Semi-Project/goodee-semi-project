package com.goodee.semi.controller;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import org.json.simple.JSONObject;

import com.goodee.semi.dto.Account;
import com.goodee.semi.dto.Attach;
import com.goodee.semi.dto.PreCourse;
import com.goodee.semi.dto.PreProgress;
import com.goodee.semi.service.PreCourseService;
import com.goodee.semi.service.PreProgressService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class PreCourseManageDetailServlet
 */
@WebServlet("/preCourse/detail")
public class PreCourseDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PreCourseService preCourseService = new PreCourseService();
	private PreProgressService preProgressService = new PreProgressService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreCourseDetailServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int petNo = -1;
		if (request.getParameter("petNo") != null) {
			petNo = Integer.parseInt(request.getParameter("petNo"));
		}
		
		int preNo = -1;
		if (request.getParameter("preNo") != null) {
			preNo = Integer.parseInt(request.getParameter("preNo"));
		}
		
		PreCourse preCourse = null;
		if (preNo != -1) {
			preCourse = preCourseService.selectPreCourse(preNo);
		}
		
		PreProgress preProgress = null;
		if (preCourse != null) {
			PreProgress param = new PreProgress();
			param.setPreNo(String.valueOf(preNo));
			param.setPetNo(petNo);
			
			preProgress = preProgressService.selectOne(param);
		}
		
		if (preCourse != null) {
			Attach attach = preCourseService.selectAttach(preNo);
			
			if (attach != null) {
				request.setAttribute("petNo", petNo);
				request.setAttribute("preCourse", preCourse);
				request.setAttribute("attach", attach);
				if (preProgress != null) {
					request.setAttribute("preProgress", preProgress);
					
					String watchLen = preProgress.getWatchLen();
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
					LocalTime time = LocalTime.parse(watchLen, formatter);
					int seconds = time.getHour() * 3600 +time.getMinute() * 60 + time.getSecond();
					request.setAttribute("watchLen", seconds);
				}
			}
			
		}

		request.getRequestDispatcher("/WEB-INF/views/preCourse/preCourseDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false);
		
		Account account = null;
		if (session != null && session.getAttribute("loginAccount") != null) {
			account = (Account) session.getAttribute("loginAccount");
		}
		
		String preNo = request.getParameter("preNo");;
		String videoLen = request.getParameter("videoLen").substring(8);
		String watchLen = request.getParameter("watchLen");
		int petNo = -1;
		if (request.getParameter("petNo") != null && request.getParameter("petNo") != "-1") {
			petNo = Integer.parseInt(request.getParameter("petNo"));
		}
		
		int idx = watchLen.indexOf('.');
		int watched = -1;
		// SJ: 
		if (idx > 0) {
			watched = Integer.parseInt(watchLen.substring(0, idx));
		}
		
		if (watched == -1) {
			
			JSONObject obj = new JSONObject();
			
			obj.put("res_code", "501");
			obj.put("res_msg", "진행도를 생성하지 않습니다.");
			
			response.setContentType("application/json; charset=utf-8");
			response.getWriter().print(obj);
			return;
		}
		
		watchLen = "" + watched / 3600 + ":" + watched / 60 % 60 + ":" + watched % 60;

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("H:m:s");
		
		String preProg = "";
		
		LocalTime watch = LocalTime.parse(watchLen, formatter);
		LocalTime video = LocalTime.parse(videoLen, formatter);
		
		// TODO: 진행 상황 계산이 잘못됨
//		long progress = (watch.getTime() / video.getTime()) * 100;
		long numerator = watch.getHour() * 3600 + watch.getMinute() * 60 + watch.getSecond();
		long denominator = video.getHour() * 3600 + video.getMinute() * 60 + video.getSecond();
		int progress = (int) ((double) numerator / denominator * 100);
		
		preProg = String.valueOf(progress);
		
		
		PreProgress preProgress = new PreProgress();
		preProgress.setPreNo(preNo);
		preProgress.setWatchLen(watchLen);
		preProgress.setPreProg(preProg);
		preProgress.setAccountNo(account.getAccountNo());
		preProgress.setPetNo(petNo);

		int result = preProgressService.insertOneWithAccountNo(preProgress);
		
		JSONObject obj = new JSONObject();
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "진행도 저장 완료");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "진행도 등록 실패");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	}

}
