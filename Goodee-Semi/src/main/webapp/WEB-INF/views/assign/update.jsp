<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>과제 수정</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
	

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
	
	<div class="container">
	  <div class="row justify-content-center">
	    <div class="align-item-center" style="width: 100%;">
	      <h3 class="tab-title" style="text-align: center; font-size: 32px;">과제 수정</h3>
	      <form id="updateAssignForm">
	      	<c:if test="${ sessionScope.loginAccount.author eq 1 }">
	      		<input type="hidden" name="trainer" value="${ sessionScope.loginAccount.accountNo }">
	      		<input type="hidden" id="assignNo" name="assignNo" value="${ assign.assignNo }" />
	      		
	      		<fieldset class="p-4">
	      			<input class="form-control mb-3" type="text" id="assignTitle" name="assignTitle" placeholder="과제 제목" value="${ assign.assignTitle }" style="width: 90%; height: 42px; margin: 0 auto;" required>
	      			
	      			<div class="mt-2 mb-4" style="width: 90%; margin: 0 auto; display: flex; justify-content: space-between;">
	      				<div style="width: 45%;">
	      					<label>과제 시작일: </label>
	      					<input class="form-control" type="datetime-local" id="assignStart" name="assignStart" value="${ assign.assignStart }" style="width: 100%; height: 42px; margin: 0 auto;">
	      				</div>
	      				
	      				<div style="width: 45%;">
	      					<label>과제 마감일: </label>
	      					<input class="form-control" type="datetime-local" id="assignEnd" name="assignEnd" value="${ assign.assignEnd }" style="width: 100%; height: 42px; margin: 0 auto;">
	      				</div>
	      			</div>
	      			
	      			<textarea class="form-control" id="assignContent" name="assignContent" placeholder="내용을 입력하세요." style="width: 90%; height: 400px; margin: 0 auto; resize: none;">${ assign.assignContent }</textarea>
	      			
	      			<div class="mt-3 mb-3" style="display: flex; justify-content: center; align-items: center;">
	      				<div style="width: 45%;">
	             		<img width="150" height="150" src="<c:url value='/filePath?no=${ assign.assignAttach.attachNo }' />" style="padding: 5px; margin-right: 10px; border: 1px solid #ced4da; object-fit: contain;" id="preview" />
	             		<label for="assignImage" class="btn btn-outline-secondary" style="padding: 2px 5px;">
	             			<span style="width: 100px; font-size: 12px;">이미지 선택</span>
	             		</label>
									<input type="file" id="assignImage" name="assignImage" onchange="readURL(this)" style="opacity: 0; width: 0%;">
	            	</div>
	      			</div>

	          	<div class="mt-5" style="display: flex; justify-content: center;">
	          		<button type="button" id="submitAssignFormBtn" class="btn btn-primary font-weight-bold" style="padding: 10px 20px; margin-right: 20px;">수정</button>
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
		
		$(() => {
			$("#submitAssignFormBtn").on("click", (event) => {
				event.preventDefault();
				
				const assignNo = $("#assignNo").val();
				
				Swal.fire({
					text: "과제를 수정하시겠습니까?",
					icon: "question",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "수정",
					cancelButtonText: "취소"
				}).then((result) => {
					if (result.isConfirmed) {
						const formData = new FormData(document.getElementById("updateAssignForm"));
						
						$.ajax({
							url : "/assign/update",
							type : "POST",
							data : formData,
							enctype : "multipart/form-data",
							contentType : false,
							processData : false,
							cache : false,
							dataType : "JSON",
							success : function(data) {
								if (data.resultCode == 200) {
									Swal.fire({
										icon: "success",
										text: data.resultMsg,
										confirmButtonText: "확인"
									}).then((result) => {
										if (result.isConfirmed) {
											location.href = "<%= request.getContextPath() %>/assign/detail?assignNo=" + assignNo;							    
										}
									});
								} else {
									Swal.fire({ icon: "error", text: data.resultMsg});
								}
							},
							error : function() {
								Swal.fire({ icon: "error", text: "수정 중 오류가 발생했습니다."});
							}
						});
					}
				});
			});
		});
	</script>
</body>

</html>