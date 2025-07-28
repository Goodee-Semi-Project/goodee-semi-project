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
            <p>
            <c:choose><c:when test="${ sessionScope.loginAccount.author eq 1 }">훈련사</c:when><c:when test="${ sessionScope.loginAccount.author eq 2 }">회원</c:when><c:otherwise>게스트</c:otherwise></c:choose> | 가입일: ${ fn:split(sessionScope.loginAccount.reg_date, " ")[0]  }</p>
            <a href="<c:url value='/myInfo' />" class="btn btn-main">내 정보</a>
            
          </div>

          <div class="widget user-dashboard-menu">
            <ul>
              <li><a href="<c:url value='/myInfo' />">내 정보</a></li>
              <c:if test="${ sessionScope.loginAccount.author eq 2 }">
								<li><a href="<c:url value='/myPet/list' />">내 반려견</a></li>
							</c:if>
              <li><a href="<c:url value='/attend' />">출석 현황</a></li>
              <li><a href="<c:url value='/review/list' />">후기 관리</a></li>
            </ul>
          </div>
        </div>
      </div>
      <div class="col-lg-9">
        <div class="widget dashboard-container">