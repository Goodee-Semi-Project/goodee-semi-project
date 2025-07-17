<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사전 학습 상세</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>

	<main>
		<h1>사전학습 세부 정보</h1>
		<div>
			<span>[교육과정]</span>
			<span>${ preCourse.courseTitle }</span>
		</div>
		<div>
			<span>[제목]</span>
			<span>${ preCourse.preTitle }</span>
		</div>
		<div>
			<span>[학습영상]</span>
			<video width="400" id="preVideo" controls preload="metadata">
				<source src="<c:url value='/fileStream?no=${ attach.attachNo }'/>">
			</video>
			<p>${ preCourse.videoLen }</p>
			<button onclick="button()">버튼</button>
		</div>
		<c:if test="${ loginAccount.author eq 1 }">
			<div>
				<a href="/preCourse/edit?no=${ preCourse.preNo }">수정하기</a>
			</div>
		</c:if>
	</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	const vid = document.querySelector('#preVideo');
	vid.ontimeupdate = function() {
		// console.log(vid.currentTime);
	}
	
	
	function button() {
		console.log(vid.readyState);
		vid.currentTime += 10;
	}
</script>
</body>
</html>