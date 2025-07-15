<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<section class="dashboard section">
  <div class="container">
    <div class="row">
      <div class="col-lg-4">
        <div class="sidebar">
          <div class="widget user-dashboard-profile">
				<c:choose>
					<c:when test="${ not empty sessionScope.loginAccount.profileAttach }">
			            <div class="profile-thumb">
			              <img src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="" class="rounded-circle"/>
			            </div>
					</c:when>
					<c:otherwise>
						<!-- TODO: 공통 사용 이미지로 -->
			            <div class="profile-thumb">
							<img alt="profile-img" src="<c:url value='/static/images/user/profile.png'/>"  alt="" class="rounded-circle"/>
			            </div>
					</c:otherwise>
				</c:choose>
            
            <h5 class="text-center" style="margin-top: 10px;">${ sessionScope.loginAccount.name } 님</h5>
            <p>회원 | 가입일: ${ sessionScope.loginAccount.reg_date }</p>
            <a href="<c:url value='/myInfo' />" class="btn btn-main">내 정보</a>
            
          </div>

          <div class="widget user-dashboard-menu">
            <ul>
              <li><a href="<c:url value='/myCourse/list' />">내 교육과정</a></li>
              <li><a href="<c:url value='/preCourse/list' />">사전학습</a></li>
              <li><a href="<c:url value='/schedule' />">일정표</a></li>
              <li><a href="<c:url value='/assign/list' />">과제</a></li>
              <li><a href="<c:url value='/qnaBoard' />">질문 게시판</a></li>
            </ul>
          </div>
        </div>
      </div>
      <div class="col-lg-8">
        <div class="widget dashboard-container">