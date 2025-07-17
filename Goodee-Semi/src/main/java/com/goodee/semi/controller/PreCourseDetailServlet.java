package com.goodee.semi.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
		int preNo = -1;
		if (request.getParameter("preNo") != null) {
			preNo = Integer.parseInt(request.getParameter("preNo"));
		}
		
		PreCourse preCourse = null;
		if (preNo != -1) {
			preCourse = preCourseService.selectPreCourse(preNo);
		}
		
		if (preCourse != null) {
			Attach attach = preCourseService.selectAttach(preNo);
			
			if (attach != null) {
				request.setAttribute("preCourse", preCourse);
				request.setAttribute("attach", attach);
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
		String watchLen = request.getParameter("watchLen");
		String videoLen = request.getParameter("videoLen");
		
		int idx = watchLen.indexOf('.');
		int watched = Integer.parseInt(watchLen.substring(0, idx));
		
		watchLen = "" + watched / 3600 + ":" + watched / 60 % 60 + ":" + watched % 60;
		
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		
		String preProg = "";
		
		try {
			Date watch = sdf.parse(watchLen);
			Date video = sdf.parse(videoLen);
			
			long progress = (watch.getTime() / video.getTime()) * 100;
			
			preProg = String.valueOf(progress);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		
		PreProgress preProgress = new PreProgress();
		preProgress.setPreNo(preNo);
		preProgress.setWatchLen(watchLen);
		preProgress.setPreProg(preProg);
		preProgress.setAccountNo(account.getAccountNo());
		
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
