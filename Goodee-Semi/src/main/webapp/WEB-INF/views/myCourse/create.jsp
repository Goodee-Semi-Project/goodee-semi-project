<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>새 교육과정 생성</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<form id="createCourseForm">
		<label>과정명: </label>
		<input type="text" name="title">
		
		<input type="hidden" name="trainer" value="${ sessionScope.loginAccount.accountNo }">
		
		<label>태그: </label>
		<input type="text" name="tag">
		<br>
		
		<label>소주제: </label>
		<input type="text" name="subTitle">
		<br>
		
		<label>훈련 횟수: </label>
		<input type="number" name="totalStep">
		
		<label>최대 수강 인원: </label>
		<input type="text" name="capacity">
		<br>
		
		<label>훈련 내용 및 목표</label><br>
		<textarea name="object" rows="5" cols="30"></textarea>
		<br>
		
		<label>대표 이미지: </label>
		<input type="file" name="thumbImage">
		<br>
		
		<label>내부 이미지: </label>
		<input type="file" name="inputImage">
		
		<input type="submit" value="등록">
	</form>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		$("#createCourseForm").submit((event) => {
			event.preventDefault();
			
			const formData = new FormData(document.getElementById("createCourseForm"));
			
			$.ajax({
				url : "/myCourse/create",
				type : "POST",
				data : formData,
				enctype : "multipart/form-data",
				contentType : false,
				processData : false,
				cache : false,
				dataType : "JSON",
				success : function(data) {
					alert(data.resultMsg);
					
					if (data.resultCode == 200) {
						location.href = "<%= request.getContextPath() %>/myCourse/list";
					}
				},
				error : function() {
					alert("오류 발생!!");
				}
			});
		});
	</script>
</body>

</html>