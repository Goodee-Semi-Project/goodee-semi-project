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
	<c:forEach var="i" begin="0" end="${ list.size() - 1 }">
		<div class="border rounded px-2 py-1">
			<input type="text" id="answer${ i }" value="${ list[i].testAnswer }" hidden>
			<p class="border-bottom pb-2" style="font-size: 20px;">${ list[i].testContent }</p>
			<div class="d-flex flex-column">
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
	
</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">
	function check(num) {
		const submit = document.querySelector('input[type=radio][name=quiz' + num + ']:checked').value;
		if (submit == $('#answer' + num).val()) {
			alert('정답입니다!');
		} else {
			alert('오답입니다!');
		}
	}
</script>
</body>
</html>