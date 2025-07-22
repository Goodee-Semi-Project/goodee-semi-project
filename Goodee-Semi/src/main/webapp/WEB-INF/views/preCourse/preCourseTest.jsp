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
		<input type="text" id="answer${ i }" value="${ list[i].testAnswer }" hidden>
		<p>${ list[i].testContent }</p>
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
		<label>
			<input type="radio" name="quiz${ i }" value="four">
			${ list[i].four }
		</label>
		<button type="button" onclick="check(${ i })">정답 확인</button>
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