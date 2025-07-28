<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:choose>
	<c:when test="${ loginAccount.author eq 1 }">
		<a id="listSideLink" style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/list' />">내 교육과정</a>
		<a id="manageSideLink" style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/memberManagement' />">회원 관리</a>
		<a id="enrollSideLink" style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/enrollList' />">수강신청 관리</a>
	</c:when>
	
	<c:when test="${ loginAccount.author eq 2 }">
		<a id="listSideLink" style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/list' />">내 교육과정</a>
		<a id="enrollSideLink" style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/enrollList' />">신청한 교육과정</a>
		<a id="likeSideLink" style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/likeList' />">찜한 교육과정</a>
		<a id="ctenSideLink" style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/certEnroll' />">수강 확인증</a>
		<a id="ctcmSideLink" style="margin-right: 10px; font-weight: normal; font-size: 15px;" href="<c:url value='/myCourse/certComplete' />">수료증</a>
	</c:when>
</c:choose>