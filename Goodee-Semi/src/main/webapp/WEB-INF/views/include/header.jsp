<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<header>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<nav class="navbar navbar-expand-lg navbar-light navigation">
					<a class="navbar-brand" href="<c:url value='/' />">
						<img src="static/images/logo.png" alt="">
					</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
					 aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav ml-auto main-nav ">
							<li class="nav-item dropdown dropdown-slide @@dashboard">
								<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#!">○○훈련소<span><i class="fa fa-angle-down"></i></span></a>
								
								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="<c:url value='/notice/list' />">공지사항</a></li>
									<li><a class="dropdown-item" href="<c:url value='/intro' />">회사 소개</a></li>
									<li><a class="dropdown-item" href="<c:url value='/location' />">찾아오시는 길</a></li>
								</ul>
							</li>
							
							<li class="nav-item dropdown dropdown-slide @@pages">
								<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">교육과정<span><i class="fa fa-angle-down"></i></span></a>

								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="<c:url value='/myCourse/list' />">내 교육과정</a></li>
									<li><a class="dropdown-item" href="<c:url value='/preCourse/list' />">사전학습</a></li>
									<li><a class="dropdown-item" href="<c:url value='/schedule' />">일정표</a></li>
									<li><a class="dropdown-item" href="<c:url value='/assign/list' />">과제</a></li>
									<li><a class="dropdown-item" href="<c:url value='/qnaBoard' />">질문 게시판</a></li>
								</ul>
							</li>
							
							<li class="nav-item dropdown dropdown-slide @@listing">
								<a class="nav-link dropdown-toggle" href="#!" data-toggle="dropdown">마이페이지<span><i class="fa fa-angle-down"></i></span></a>

								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="<c:url value='/myInfo' />">내 정보</a></li>
									<li><a class="dropdown-item" href="<c:url value='/myPet/list' />">내 반려견</a></li>
									<li><a class="dropdown-item" href="<c:url value='/attend' />">출석 현황</a></li>
									<li><a class="dropdown-item" href="<c:url value='/review/list' />">후기 관리</a></li>
								</ul>
							</li>
							
							<li class="nav-item active">
								<a class="nav-link" href="">고객센터</a>
							</li>
						</ul>
						
						<ul class="navbar-nav ml-auto mt-10">
							<c:choose>
								<c:when test="${not empty sessionScope.loginAccount }">
									<span style="font-size: 13px; text-align: left; margin-right: 5px;">${sessionScope.loginAccount.name }님!<br> 환영합니다.</span>
									<a class="nav-link login-button" href="#" onclick="logout(event)">로그아웃</a>
								</c:when>
								<c:otherwise>
									<li class="nav-item">
										<a class="nav-link login-button" href="<c:url value='/account/login' />">로그인</a>
									</li>
									<li class="nav-item">
										<a class="nav-link text-white add-button" href="<c:url value='/account/register' />">회원가입</a>
									</li>
								</c:otherwise>
							</c:choose>
						</ul>

					</div>
				</nav>
			</div>
		</div>
	</div>
</header>

