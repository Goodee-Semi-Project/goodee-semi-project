<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>과제 세부 조회</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
	

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
	
	<div class="container">
		<div class="row">
			<div class="col-12">
				<article class="single-post">
					<h2>${ assign.assignTitle }</h2>
					<ul class="list-inline">
						<li class="list-inline-item">차수: ${ assign.schedStep }</li>
						<li class="list-inline-item">과제 생성일: ${ assign.assignStart }</li>
						<li class="list-inline-item">과제 마감일: ${ assign.assignEnd }</li>
					</ul>
					<img src="<c:url value='/filePath?no=${ assign.assignAttach.attachNo }' />" alt="assignAttach">
					<p>${ assign.assignContent }</p>
					
					<div style="display: flex; justify-content: center; align-items: center;">
						<c:if test="${ sessionScope.loginAccount.author eq 1 }">
							<button class="btn btn-success mr-2" onclick="" id="assignUpdate" style="padding: 5px 10px;">수정</button>
							<button class="btn btn-danger" onclick="" id="assignDelete" style="padding: 5px 10px;">삭제</button>
						</c:if>
						
						<c:if test="${ sessionScope.loginAccount.author eq 2 }">
							<button class="btn btn-transparent" onclick="assignSubmitFormOpen()" id="assignSubmitOpen" style="padding: 5px 10px;">제출하기</button>	
						</c:if>						
					</div>
				</article>
				
				<div class="block comment" id="assignSubmitFormController" style="display: none;">
					<h4 style="text-align: center;">과제 제출</h4>
					<form id="assignSubmitForm">
						<!-- Message -->
						<div class="form-group mb-30">
							<label for="assignSubmitTitle">제목</label>
							<input type="text" class="form-control" id="assignSubmitTitle" name="assignSubmitTitle" required>
						</div>
						<div class="form-group mb-30">
							<label for="assignSubmitContent">내용</label>
							<textarea class="form-control" id="assignSubmitContent" name="assignSubmitContent" rows="8" style="resize: none;" required></textarea>
						</div>
						
						<div class="mt-3 mb-3" style="display: flex; justify-content: center; align-items: center;">
	      			<div style="width: 45%;">
	             	<img width="150" height="150" style="padding: 5px; margin-right: 10px; border: 1px solid #ced4da; object-fit: contain;" id="preview" />
	             	<label for="assignSubmitImage" class="btn btn-outline-secondary" style="padding: 2px 5px;">
	             		<span style="width: 100px; font-size: 12px;">이미지 선택</span>
	             	</label>
								<input type="file" id="assignSubmitImage" name="assignSubmitImage" onchange="readURL(this)" style="opacity: 0; width: 0%;">
	            </div>
	      		</div>
						
						<div style="display: flex; justify-content: center; align-items: center;">
							<button type="submit" class="btn btn-transparent" style="padding: 5px 10px;">과제 제출</button>						
						</div>
					</form>
				</div>
				
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		function assignSubmitFormOpen() {
			$("#assignSubmitOpen").css("display", "none");
			$("#assignSubmitFormController").css("display", "block");
		}
		
		function readURL(input) {
			if (input.files && input.files[0]) {
			  const reader = new FileReader();
			    
			  reader.onload = function(event) {
			    document.getElementById('preview').src = event.target.result;
			  };
			    
			  reader.readAsDataURL(input.files[0]);
			} else {
			  document.getElementById('preview').src = "";
			}
		}
	</script>
</body>

</html>