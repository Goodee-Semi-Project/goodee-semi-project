<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
	
	<div>
		<h1>수강 인원 관리</h2>
	</div>
	
	<c:forEach var="c" items="${courseList}" >
	  <div>
	    <div>
	    <c:if test="${c.thumbAttach ne null}">	    
	      <img src="<c:url value='C://goodee/upload/${c.thumbAttach.saveName}'/>" alt="${c.title}">
		</c:if>
	    </div>
	    <div style="display : flex; width : 700px; justify-content : space-between;">
	      <h2>${c.title}</h2>
	      <div>
	        <a href="<c:url value='/myCourse/MemberDetail?courseNo=${c.courseNo }'/>">상세보기</a>
	        <div>수강 인원</div>
	        <span>${c.currentEnrollment}</span>/<span>${c.capacity}</span>
	      </div>
	    </div>
	  </div>
	</c:forEach>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>