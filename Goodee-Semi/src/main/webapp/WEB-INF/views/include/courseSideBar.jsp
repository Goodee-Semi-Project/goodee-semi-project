<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<section class="dashboard section">
  <div class="container">
    <div class="row">
      <div class="col-lg-3">
        <div class="sidebar">
          <div class="widget user-dashboard-profile">
						<c:choose>
							<c:when test="${ not empty sessionScope.loginAccount.profileAttach }">
					    	<div class="profile-thumb">
					      	<img src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="" class="rounded-circle" style="box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2);"/>
					    	</div>
							</c:when>
							
							<c:otherwise>
								<!-- NOTE: 공통 사용 이미지로 -->
					    	<div class="profile-thumb">
									<img alt="profile-img" src="<c:url value='/static/images/user/profile.png'/>"  alt="" class="rounded-circle" style="box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2);"/>
					    	</div>
							</c:otherwise>
						</c:choose>
            
            <h5 class="text-center" style="margin-top: 10px;">${ sessionScope.loginAccount.name } 님</h5>
            <p>회원 | 가입일: ${ fn:split(sessionScope.loginAccount.reg_date, " ")[0] }</p>
            <a href="<c:url value='/myInfo' />" class="btn btn-main" style="padding: 10px 20px;">내 정보</a>
            
          </div>

          <div class="widget user-dashboard-menu">
            <ul>
            	<c:choose>
								<c:when test="${ sessionScope.loginAccount.author eq 1 }">
									<li><a href="<c:url value='/myCourse/list' />">교육과정 관리</a></li>
									<li><a href="<c:url value='/preCourse/list' />">사전학습 관리</a></li>
									<li><a href="<c:url value='/schedule' />">일정표</a></li>
									<li><a href="<c:url value='/assign/management' />">과제 관리</a></li>										
									<li><a href="<c:url value='/qnaBoard/list' />">질문 게시판</a></li>
								</c:when>
										
								<c:otherwise>
									<li><a href="<c:url value='/myCourse/list' />">내 교육과정</a></li>
									<li><a href="<c:url value='/preCourse/list' />">내 사전학습</a></li>
									<li><a href="<c:url value='/schedule' />">일정표</a></li>
									<li><a href="<c:url value='/assign/list' />">내 과제</a></li>
									<li><a href="<c:url value='/qnaBoard/list' />">질문 게시판</a></li>								
								</c:otherwise>
							</c:choose>
            </ul>
          </div>
        </div>
      </div>
      <div class="col-lg-9">
        <div class="widget dashboard-container">
