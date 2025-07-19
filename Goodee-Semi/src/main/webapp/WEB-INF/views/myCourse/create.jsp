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
  
	<div class="container">
	  <div class="row justify-content-center">
	    <div class="align-item-center" style="width: 100%;">
	      <h3 class="tab-title" style="text-align: center; font-size: 32px;">교육과정 생성</h3>
	      <form id="createCourseForm">
	      	<c:if test="${ sessionScope.loginAccount.author eq 1 }">
	      		<input type="hidden" id="validAuthor" value="${ sessionScope.loginAccount.author }">
	      		<input type="hidden" name="trainer" value="${ sessionScope.loginAccount.accountNo }">
	      		
	      		<fieldset class="p-4">
	      			<div class="mb-2" style="display: flex; justify-content: space-between;">
	      				<input class="form-control" type="text" id="title" name="title" placeholder="과정명" style="width: 40%; height: 30px; margin: 0 5%;" required>
	      				<input class="form-control" type="text" id="tag" name="tag" placeholder="#태그 (3개까지 입력 가능)" style="width: 40%; height: 30px; margin: 0 5%;" required>
	      			</div>
	      			<div class="mb-4" style="display: flex; justify-content: space-between;">
	      				<input class="form-control" type="text" id="totalStep" name="totalStep" placeholder="훈련 횟수" style="width: 40%; height: 30px; margin: 0 5%;" required>
	      				<input class="form-control" type="text" id="capacity" name="capacity" placeholder="최대 수강 인원" style="width: 40%; height: 30px; margin: 0 5%;" required>
	      			</div>
	      			<input class="form-control mb-3" type="text" id="subTitle" name="subTitle" placeholder="소주제" style="width: 90%; height: 30px; margin: 0 auto;" required>
	      			<textarea class="form-control" id="object" name="object" placeholder="내용을 입력하세요." style="width: 90%; height: 400px; margin: 0 auto;"></textarea>
	      			
	      			<div class="mt-3 mb-3" style="display: flex; justify-content: center; align-items: center;">
	      				<div style="width: 45%;">
	             		<img width="150" height="150" style="padding: 5px; margin-right: 10px; border: 1px solid #ced4da; object-fit: contain;" id="thumbPreview" />
	             		<label for="thumbImage" class="btn btn-outline-secondary" style="padding: 2px 5px;">
	             			<span style="width: 100px; font-size: 12px;">대표 이미지 선택</span>
	             		</label>
									<input type="file" id="thumbImage" name="thumbImage" onchange="readThumbURL(this)" style="opacity: 0; width: 0%;">
	            	</div>
	            	
	            	<div style="width: 45%;">
	             		<img width="150" height="150" style="padding: 5px; margin-right: 10px; border: 1px solid #ced4da; object-fit: contain;" id="inputPreview" />
	             		<label for="inputImage" class="btn btn-outline-secondary" style="padding: 2px 5px;">
	             			<span style="width: 100px; font-size: 12px;">내부 이미지 선택</span>
	             		</label>
									<input type="file" id="inputImage" name="inputImage" onchange="readInputURL(this)" style="opacity: 0; width: 0%;">
	            	</div>
	      			</div>

	          	<div class="mt-5" style="display: flex; justify-content: center;">
	          		<button type="submit" class="btn btn-primary font-weight-bold" style="padding: 10px 20px; margin-right: 20px;">등록</button>
	          		<button type="button" class="btn btn-outline-secondary font-weight-bold" style="padding: 10px 20px;" onclick="history.back()">취소</button>
	          	</div>
	        	</fieldset>
	      	</c:if>
	      </form>
	    </div>
	  </div>
	</div>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		const myAuthor = $("#validAuthor").val();
		
		if (myAuthor == 2) {
			alert("잘못된 접근입니다.");
			location.href = "<%= request.getContextPath() %>/";
		}
		
		function readThumbURL(input) {
			if (input.files && input.files[0]) {
			  const reader = new FileReader();
			    
			  reader.onload = function(event) {
			    document.getElementById('thumbPreview').src = event.target.result;
			  };
			    
			  reader.readAsDataURL(input.files[0]);
			} else {
			  document.getElementById('thumbPreview').src = "";
			}
		}
		
		function readInputURL(input) {
			if (input.files && input.files[0]) {
			  const reader = new FileReader();
			    
			  reader.onload = function(event) {
			    document.getElementById('inputPreview').src = event.target.result;
			  };
			    
			  reader.readAsDataURL(input.files[0]);
			} else {
			  document.getElementById('inputPreview').src = "";
			}
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