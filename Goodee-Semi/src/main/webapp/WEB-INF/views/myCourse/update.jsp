<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>교육과정 정보 수정</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
	

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
	<h3 class="widget-header">
  	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
  </h3>
  
  <input type="hidden" id="validAuthor" value="${ sessionScope.loginAccount.author }" />
  <input type="hidden" id="isSameTrainer" value="${ course.accountNo eq sessionScope.loginAccount.accountNo }" />
	<c:if test="${ (sessionScope.loginAccount.author eq 1) and (course.accountNo eq sessionScope.loginAccount.accountNo) }">
		<form id="updateCourseForm">
			<label>과정명: </label>
			<input type="text" id="title" name="title" value="${ course.title }">
			
			<input type="hidden" name="courseNo" value="${ course.courseNo }">
			<input type="hidden" name="trainer" value="${ sessionScope.loginAccount.accountNo }">
			
			<label>태그: </label>
			<input type="text" id="tag" name="tag" value="${ course.tag }">
			<br>
			
			<label>소주제: </label>
			<input type="text" id="subTitle" name="subTitle" value="${ course.subTitle }">
			<br>
			
			<label>훈련 횟수: </label>
			<input type="number" id="totalStep" name="totalStep" value="${ course.totalStep }">
			
			<label>최대 수강 인원: </label>
			<input type="text" id="capacity" name="capacity" value="${ course.capacity }">
			<br>
			
			<label>훈련 내용 및 목표</label><br>
			<textarea id="object" name="object" rows="5" cols="30">${ course.object }</textarea>
			<br>
			
			<div class="container">
				<div class="row">
					<div class="col-3 text-center">
						<p style="margin-bottom: 5px;">현재 대표 이미지</p>
						<img style="border: 2px solid gray; padding: 0;" height="130" src="<c:url value='/filePath?no=${ course.thumbAttach.attachNo }' />" alt="thumbImage">		
					</div>
				
					<div class="col-4 text-center">
						<p style="margin-bottom: 5px;">현재 내부 이미지</p>
						<img style="border: 2px solid gray; padding: 0;" height="130" src="<c:url value='/filePath?no=${ course.inputAttach.attachNo }' />" alt="thumbImage">		
					</div>
				</div>
			</div>
			<br>
			
			<label>대표 이미지: </label>
			<input type="file" name="thumbImage">
			<br>
			
			<label>내부 이미지: </label>
			<input type="file" name="inputImage">
			<br>
			
			<input type="submit" value="등록">
		</form>
	</c:if>

	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		const myAuthor = $("#validAuthor").val();
		const isSameTrainer = $("#isSameTrainer").val();
		
		if (myAuthor == 2 || isSameTrainer == "false") {
			alert("잘못된 접근입니다.");
			location.href = "<%= request.getContextPath() %>/";
		}
	
		$("#updateCourseForm").submit((event) => {
			event.preventDefault();
			
			const formData = new FormData(document.getElementById("updateCourseForm"));
			
			const title = $("#title").val();
			const tag = $("#tag").val();
			const subTitle = $("#subTitle").val();
			const totalStep = $("#totalStep").val();
			const capacity = $("#capacity").val();
			const object = $("#object").val();
			
			const tagReg = /^#[a-zA-Z가-힣0-9]{1,8}( #[a-zA-Z가-힣0-9]{1,8}){0,2}$/
			
			// 유효성 검사
			if (!title) alert("과정명을 입력해주세요.");
			else if (!tag) alert("태그를 입력해주세요.");
			else if (!tagReg.test(tag)) alert("태그를 정확히 입력해주세요.");
			else if (!subTitle) alert("소주제를 입력해주세요.");
			else if (!totalStep) alert("훈련 횟수를 입력해주세요.");
			else if (!capacity) alert("최대 수강 인원을 입력해주세요.");
			else if (!object) alert("내용을 입력해주세요.");
			else {
				if (confirm("수정하시겠습니까?")) {
					$.ajax({
						url : "/myCourse/update",
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