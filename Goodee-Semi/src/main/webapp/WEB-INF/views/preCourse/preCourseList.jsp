<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Objects" %>
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
			<a class="btn btn-success border px-2 py-1 mb-1" href="/preCourse/regist">사전학습 등록</a>
		</div>
	</c:if>
	<section>
		<div>
			<c:forEach var="c" items="${ courseList }" >
				<c:if test="${ not empty preCourseMap.get(c.courseNo) }">
					<ul class="list-inline border rounded p-2 mb-1"">
						<c:if test="${ not empty c.petNo }">
							<input type="text" value="${ c.petNo }" hidden>
						</c:if>
						<div class="d-flex overflow-hidden border-bottom" style="height: 50px;">
							<img class="object-fit-cover" height="100" alt="교육과정 썸네일" src="<c:url value='/filePath?no=${ attachMap.get(c.courseNo) }'/>">
							<h4><c:if test="${ not empty c.name }">${ c.name } - </c:if>${ c.title }</h4>
						</div>
						<c:forEach var="p" items="${ preCourseMap.get(c.courseNo) }">
							<!-- 회원이 조회하는 페이지에서 수정 삭제 버튼만 if로 표시 -->
							<li class=" d-block mb-1">
								<div class="d-flex justify-content-between">
									<a href="/preCourse/detail?preNo=${ p.preNo }&petNo=${ c.petNo }">
										[사전학습] ${ p.preTitle }
									</a>
									<c:if test="${ loginAccount.author ne 1 }">
										<div style="width: 90px;">
											<c:choose>
												<c:when test="${ not empty preProgMap.get(Objects.hash(c.classNo, p.preNo)).preProg }">
													<span>[진행도] ${ preProgMap.get(Objects.hash(c.classNo, p.preNo)).preProg }%</span>
												</c:when>
												<c:otherwise>
													<span>[진행도] 0%</span>
												</c:otherwise>
											</c:choose>
										</div>
									</c:if>
								</div>
							</li>
						</c:forEach>
					</ul>
				</c:if>
			</c:forEach>
		</div>
	</section>

</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>