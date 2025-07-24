<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>

<main>
	<c:choose>
		<c:when test="${ list.size() eq 0 }">
			<div class="content-block" style="height: 50vh;">
				<h1>해당하는 퀴즈가 없습니다.</h1>
				<hr>
			</div>
		</c:when>
		<c:otherwise>
			<c:forEach var="i" begin="0" end="${ list.size() - 1 }">
				<div class="border rounded px-2 py-1 mb-2">
					<input type="text" id="answer${ i }" value="${ list[i].testAnswer }" hidden>
					<p class="border-bottom p-2" style="font-size: 20px;">${ list[i].testContent }</p>
					<div class="d-flex flex-column p-2">
						<label>
							<input type="radio" name="quiz${ i }" value="one">
							${ list[i].one }
						</label>
						<label>
							<input type="radio" name="quiz${ i }" value="two">
							${ list[i].two }
						</label>
						<label>
							<input type="radio" name="quiz${ i }" value="three">
							${ list[i].three }
						</label>
						<div class="d-flex justify-content-between">
							<label>
								<input type="radio" name="quiz${ i }" value="four">
								${ list[i].four }
							</label>
							<button class="btn btn-primary px-2 py-1" type="button" onclick="check(${ i })">정답 확인</button>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<div>
		<a class="btn btn-primary px-2 py-1" href="javascript:history.back();">뒤로가기</a>
	</div>
</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	function check(num) {
		const submit = document.querySelector('input[type=radio][name=quiz' + num + ']:checked').value;
		if (submit == $('#answer' + num).val()) {
			Swal.fire({ icon: "success", text: "정답입니다!"});
		} else {
			Swal.fire({ icon: "error", text: "오답입니다!"});
		}
	}
</script>
</body>
</html>