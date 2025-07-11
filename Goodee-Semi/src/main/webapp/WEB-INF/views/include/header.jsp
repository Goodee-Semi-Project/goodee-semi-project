<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- Dropdown 1 --%>
<a href="<c:url value='/notice/list' />">공지사항</a>
<a href="<c:url value='/intro' />">회사 소개</a>
<a href="<c:url value='/location' />">찾아오시는 길</a>

<%-- Dropdown 2 --%>
<a href="<c:url value='/myCourse/list' />">내 교육과정</a>
<a href="<c:url value='/preCourse/list' />">사전학습</a>
<a href="<c:url value='/schedule' />">일정표</a>
<a href="<c:url value='/assign/list' />">과제</a>
<a href="<c:url value='/qnaBoard/list' />">질문 게시판</a>

<%-- Dropdown 3 --%>
<a href="<c:url value='/myInfo' />">내 정보</a>
<a href="<c:url value='/myPet/list' />">내 반려견</a>
<a href="<c:url value='/attend' />">출석 현황</a>
<a href="<c:url value='/review/list' />">후기 관리</a>

<%-- Dropdown 4 --%>
<a href="<c:url value='/contact' />">고객센터</a>

<%-- Log in / Log out / Sign in --%>
<c:choose>
	<c:when test="${not empty sessionScope.loginAccount }">
		<span>${sessionScope.loginAccount.name }님! 환영합니다.</span>
		<a href="<c:url value='#' />" onclick = "logout(event) ">로그아웃</a>
	</c:when>
	<c:otherwise>
		<a href="<c:url value='/account/login' />" >로그인</a>
		<a href="<c:url value='/account/register' />">회원가입</a>	
	</c:otherwise>
</c:choose>

<script>
	function logout(e){
		e.preventDefault();
		if(confirm("로그아웃 하시겠습니까?")){
			location.href = "<c:url value='/account/logout' />";
		}
	}
</script>