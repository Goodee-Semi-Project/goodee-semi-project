<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사전 학습</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>



<main>
	<h2>사전 학습</h2>
	<c:if test="${ loginAccount.author eq 1 }">
		<div>
			<a href="/preCourse/regist" >사전학습 등록하기</a>
		</div>
	</c:if>
	<section>
		<div>
			<c:forEach var="c" items="${ courseList }" >
				<p>반려견: ${ c.name }</p>
				<p>코스명: ${ c.title }</p>
				<ul>
					<c:forEach var="p" items="${ preCourseMap.get(c.courseNo) }">
						<!-- 회원이 조회하는 페이지에서 수정 삭제 버튼만 if로 표시 -->
						<a href="/preCourse/detail?preNo=${ p.preNo }">
							사전학습명: ${ p.preTitle }
						</a>
						<br>
					</c:forEach>
				</ul>
				<br>
			</c:forEach>
		</div>
	</section>

</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>