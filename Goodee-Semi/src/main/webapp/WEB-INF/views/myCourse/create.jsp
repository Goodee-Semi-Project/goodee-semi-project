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
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
	<h3 class="widget-header">
  	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
  </h3>
  
  <input type="hidden" id="validAuthor" value="${ sessionScope.loginAccount.author }">
  <c:if test="${ sessionScope.loginAccount.author eq 1 }">
  	<form id="createCourseForm">
			<label>과정명: </label>
			<input type="text" id="title" name="title">
			
			<input type="hidden" name="trainer" value="${ sessionScope.loginAccount.accountNo }">
			
			<label>태그: </label>
			<input type="text" id="tag" name="tag">
			<br>
			
			<label>소주제: </label>
			<input type="text" id="subTitle" name="subTitle">
			<br>
			
			<label>훈련 횟수: </label>
			<input type="number" id="totalStep" name="totalStep">
			
			<label>최대 수강 인원: </label>
			<input type="text" id="capacity" name="capacity">
			<br>
			
			<label>훈련 내용 및 목표</label><br>
			<textarea id="object" name="object" rows="5" cols="30"></textarea>
			<br>
			
			<label>대표 이미지: </label>
			<input type="file" id="thumbImage" name="thumbImage">
			<br>
			
			<label>내부 이미지: </label>
			<input type="file" id="inputImage" name="inputImage">
			
			<input type="submit" value="등록">
		</form>
  </c:if>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		const myAuthor = $("#validAuthor").val();
		
		if (myAuthor == 2) {
			alert("잘못된 접근입니다.");
			location.href = "<%= request.getContextPath() %>/";
		}
	
		$("#createCourseForm").submit((event) => {
			event.preventDefault();
			
			const formData = new FormData(document.getElementById("createCourseForm"));
			
			const title = $("#title").val();
			const tag = $("#tag").val();
			const subTitle = $("#subTitle").val();
			const totalStep = $("#totalStep").val();
			const capacity = $("#capacity").val();
			const object = $("#object").val();
			const thumbImage = $("#thumbImage").val();
			const inputImage = $("#inputImage").val();
			
			const tagReg = /^#[a-zA-Z가-힣0-9]{1,8}( #[a-zA-Z가-힣0-9]{1,8}){0,2}$/
			
			// 유효성 검사
			if (!title) alert("과정명을 입력해주세요.");
			else if (!tag) alert("태그를 입력해주세요.");
			else if (!tagReg.test(tag)) alert("태그를 정확히 입력해주세요.");
			else if (!subTitle) alert("소주제를 입력해주세요.");
			else if (!totalStep) alert("훈련 횟수를 입력해주세요.");
			else if (!capacity) alert("최대 수강 인원을 입력해주세요.");
			else if (!object) alert("내용을 입력해주세요.");
			else if (!thumbImage) alert("대표 이미지를 추가해주세요.");
			else if (!inputImage) alert("내부 이미지를 추가해주세요.");
			else {
				if (confirm("등록하시겠습니까?")) {
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
				}
			}
		});
	</script>
</body>

</html>