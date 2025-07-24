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
						<c:if test="${ (sessionScope.loginAccount.author eq 1) and (empty assign.assignSubmit) }">
							<button class="btn btn-success mr-2" onclick="assignUpdate('${ assign.assignNo }')" id="assignUpdate" style="padding: 5px 10px;">수정</button>
							<button class="btn btn-danger" onclick="assignDelete('${ assign.assignNo }')" id="assignDelete" style="padding: 5px 10px;">삭제</button>
						</c:if>
						
						<c:if test="${ (sessionScope.loginAccount.author eq 2) and (empty assign.assignSubmit) }">
							<button class="btn btn-transparent" onclick="assignSubmitFormOpen()" id="assignSubmitOpen" style="padding: 5px 10px;">제출하기</button>	
						</c:if>
					</div>
				</article>
				
				<c:if test="${ not empty assign.assignSubmit }">
					<article id="calledAssignSubmit" class="single-post">
						<h2>${ assign.assignSubmit.submitTitle }</h2>
						<ul class="list-inline">
							<li class="list-inline-item">제출일: ${ assign.assignSubmit.submitDate }</li>
						</ul>
						<img src="<c:url value='/filePath?no=${ assign.assignSubmit.submitAttach.attachNo }' />" alt="assignAttach">
						<p>${ assign.assignSubmit.submitContent }</p>
						
						<div style="display: flex; justify-content: center; align-items: center;">
							<c:if test="${ sessionScope.loginAccount.author eq 2 }">
								<button class="btn btn-success mr-2" onclick="assignSubmitUpdateFormOpen()" style="padding: 5px 10px;">수정</button>
								<button class="btn btn-danger" onclick="assignSubmitDelete('${ assign.assignSubmit.submitNo }')" style="padding: 5px 10px;">삭제</button>
							</c:if>					
						</div>
					</article>
				</c:if>
				
				<div class="block comment" id="assignSubmitFormController" style="display: none;">
					<h4 style="text-align: center;">과제 제출</h4>
					<form id="assignSubmitForm">
						<!-- Message -->
						<input type="hidden" id="submitNo" name="submitNo" value="${ assign.assignSubmit.submitNo }">
						<input type="hidden" id="assignNo" name="assignNo" value="${ assign.assignNo }">
						<div class="form-group mb-30">
							<label for="assignSubmitTitle">제목</label>
							<input type="text" class="form-control" id="assignSubmitTitle" name="assignSubmitTitle" value="${ assign.assignSubmit.submitTitle }" required>
						</div>
						<div class="form-group mb-30">
							<label for="assignSubmitContent">내용</label>
							<textarea class="form-control" id="assignSubmitContent" name="assignSubmitContent" rows="8" style="resize: none;" required>${ assign.assignSubmit.submitContent }</textarea>
						</div>
						
						<div class="mt-3 mb-3" style="display: flex; justify-content: center; align-items: center;">
	      			<div style="width: 45%;">
	             	<img width="150" height="150" <c:if test="${ not empty assign.assignSubmit }"> src="<c:url value='/filePath?no=${ assign.assignSubmit.submitAttach.attachNo }' />" </c:if> style="padding: 5px; margin-right: 10px; border: 1px solid #ced4da; object-fit: contain;" id="preview" />
	             	<label for="assignSubmitImage" class="btn btn-outline-secondary" style="padding: 2px 5px;">
	             		<span style="width: 100px; font-size: 12px;">이미지 선택</span>
	             	</label>
								<input type="file" id="assignSubmitImage" name="assignSubmitImage" onchange="readURL(this)" style="opacity: 0; width: 0%;">
	            </div>
	      		</div>
						
						<div style="display: flex; justify-content: center; align-items: center;">
							<c:if test="${ empty assign.assignSubmit }">
								<button type="button" id="assignSubmitBtn" class="btn btn-transparent" style="padding: 5px 10px;">과제 제출</button>													
							</c:if>
							
							<c:if test="${ not empty assign.assignSubmit }">
								<button class="btn btn-success mr-2" id="assignSubmitUpdateBtn" style="padding: 5px 10px;">수정</button>
								<button type="button" class="btn btn-danger" onclick="assignSubmitUpdateFormClose()" style="padding: 5px 10px;">취소</button>												
							</c:if>
						</div>
					</form> 
				</div>
				
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		function assignUpdate(assignNo) {
			location.href = "<%= request.getContextPath() %>/assign/update?assignNo=" + assignNo;
		}
		
		function assignDelete(assignNo) {
			if (confirm("과제를 삭제하시겠습니까?")) {
				$.ajax({
					url : "/assign/delete",
					type : "POST",
					data : {
						assignNo : assignNo
					},
					dataType : "JSON",
					success : function(data) {
						alert(data.resultMsg);
						
						if (data.resultCode == 200) {
							location.href = "<%= request.getContextPath() %>/assign/management";
						}
					},
					error : function() {
						alert("오류 발생!!");
					}
				});
			}
		}
	
		function assignSubmitFormOpen() {
			$("#submitNo").removeAttr("value");
			$("#assignSubmitTitle").removeAttr("value");
			$("#assignSubmitContent").removeAttr("value");
			$("#preview").removeAttr("src");
			
			$("#assignSubmitOpen").css("display", "none");
			$("#assignSubmitFormController").css("display", "block");
		}
		
		function assignSubmitUpdateFormOpen() {
			$("#calledAssignSubmit").css("display", "none");
			$("#assignSubmitFormController").css("display", "block");
		}
		
		function assignSubmitUpdateFormClose() {
			$("#assignSubmitFormController").css("display", "none");
			$("#calledAssignSubmit").css("display", "block");
		}
		
		function assignSubmitDelete(submitNo) {
			const assignNo = $("#assignNo").val();
			
			if (confirm("과제를 삭제하시겠습니까?")) {
				$.ajax({
					url : "/assign/submit/delete",
					type : "POST",
					data : {
						submitNo : submitNo
					},
					dataType : "JSON",
					success : function(data) {
						alert(data.resultMsg);
						
						if (data.resultCode == 200) {
							location.href = "<%= request.getContextPath() %>/assign/detail?assignNo=" + assignNo;
						}
					},
					error : function() {
						alert("오류 발생!!");
					}
				});
			}
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
		
		$(() => {
			$("#assignSubmitUpdateBtn").on("click", (event) => {
				event.preventDefault();
				
				const assignNo = $("#assignNo").val();
				
				if (confirm("과제를 수정하시겠습니까?")) {
					const formData = new FormData(document.getElementById("assignSubmitForm"));
					
					$.ajax({
						url : "/assign/submit/update",
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
								location.href = "<%= request.getContextPath() %>/assign/detail?assignNo=" + assignNo;
							}
						},
						error : function() {
							alert("오류 발생!!");
						}
					});
				}
			});
			
			$("#assignSubmitBtn").on("click", (event) => {
				event.preventDefault();
				
				const assignNo = $("#assignNo").val();
				
				if (confirm("과제를 제출하시겠습니까?")) {
					const formData = new FormData(document.getElementById("assignSubmitForm"));
					
					$.ajax({
						url : "/assign/submit/create",
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
								location.href = "<%= request.getContextPath() %>/assign/detail?assignNo=" + assignNo;
							}
						},
						error : function() {
							alert("오류 발생!!");
						}
					});
				}
			});
		});
	</script>
</body>

</html>