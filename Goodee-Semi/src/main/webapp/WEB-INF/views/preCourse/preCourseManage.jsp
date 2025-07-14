<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사전 학습 목록</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>

<main>
	<div>
		<!-- TODO: 버튼으로 courseList 넘겨주기 -->
		<a href="/preCourse/regist" >사전학습 등록</a>
	</div>
	<section>
		<div>
			<c:forEach var="c" items="${ courseList }" >
				<p>코스명: ${ c.title }</p>
				<ul>
					<c:forEach var="p" items="${ preCourseMap.get(c.courseNo) }">
						<li>
							사전학습명: ${ p.preTitle }
						</li>
					</c:forEach>
				</ul>
			</c:forEach>
		</div>
	</section>

</main>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>