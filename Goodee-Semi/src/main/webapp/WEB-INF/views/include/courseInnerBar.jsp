<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
	<c:when test="${ loginAccount.author eq 1 }">
		<a style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/list' />">내 교육과정</a>
		<a style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/' />">사전학습 등록</a>
		<a style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/memberManagement' />">회원 관리</a>
		<a style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/like' />">수강신청 관리</a>
	</c:when>
	
	<c:when test="${ loginAccount.author eq 2 }">
		<a style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/list' />">내 교육과정</a>
		<a style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/regist' />">신청한 교육과정</a>
		<a style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/like' />">찜한 교육과정</a>
		<a style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/certEnroll' />">수강 확인증</a>
		<a style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/certComplete' />">수료증</a>
	</c:when>
</c:choose>