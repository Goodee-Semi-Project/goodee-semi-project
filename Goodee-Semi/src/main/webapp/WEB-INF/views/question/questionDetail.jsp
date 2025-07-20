<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA게시글 조회</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	
	<!-- 회원글 -->
	<div style="display:flex; justify-content: between">
		<span>[QnA]</span>
		<h2>${question.questTitle}</h2>
		<span>${question.questReg}</span>
	</div>	
	<div>${question.questContent}</div>
	
	<!-- 훈련사답변 -->
	<c:if test="${not empty answer}">
		<div>
		<div>${answer.accountId}</div>
		<div>${answer.answerReg}</div>		
		</div>
		<div>${answer.answerContent}</div>
	</c:if>
	
	<input type="button" onclick='location.href="<c:url value='/qnaBoard/list'/>"' value="목록">
	<c:if test="${not empty loginAccount}">
		<c:if test="${loginAccount.accountNo eq question.accountNo}">
			<input type="button" value="수정" id="btn_update_answer" onclick="update()">
			<input type="button" onclick="openDeleteQuestionModal()" value="삭제">				
		</c:if>
		<c:if test="${loginAccount.author eq 1}">
			<c:choose>
				<c:when test="${empty answer}">
					<button type="button" onclick="location.href='${request.contextPath()}/qnaBoard/answerAdd?no=${question.questNo}'">답변등록</button>
				</c:when>
				<c:otherwise>
					<button type="button" onclick="location.href='${request.contextPath()}/qnaBoard/answerUpdate?no=${question.questNo}'">답변수정</button>
					<button type="button" onclick="openDeleteAnswerModal()">답변삭제</button>
				</c:otherwise>
			</c:choose>
		</c:if>
	</c:if>

    <%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<!-- 게시글 삭제 -->
	<div class="modal fade" id="deleteQuestionModal" tabindex="-1" role="dialog" aria-labelledby="printModal" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center">
	        게시글을 삭제하시겠습니까?
	      </div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" id="btn_modal_delete_question" class="btn btn-success">확인</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 답글 삭제 -->
	<div class="modal fade" id="deleteAnswerModal" tabindex="-1" role="dialog" aria-labelledby="printModal" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center">
	        답변을 삭제하시겠습니까?
	      </div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" id="btn_modal_delete_answer" class="btn btn-success">확인</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script>
	
	function openDeleteQuestionModal() {
		$("#deleteQuestionModal").modal("show");
		
	}
	function openDeleteAnswerModal() {
		$("#deleteAnswerModal").modal("show");
	}

	function update() {
		location.href="<%=request.getContextPath()%>/qnaBoard/questionUpdate?no=${question.questNo}&accountNo=${question.accountNo}"
	}
	
	$(document).ready(function(){
		$("#btn_modal_delete_question").click(function(){
			$.ajax({
				url : "/qnaBoard/questionDelete?no="+${question.questNo},
				type : "get",
				success : function(data) {
					if(data == 1) {
						alert("삭제되었습니다");
						location.href = "<%=request.getContextPath() %>/qnaBoard/list";
					}
				}
			})
		});
	});

	$(document).ready(function(){
		$("#btn_modal_delete_answer").click(function(){
			$.ajax({
				url : "/qnaBoard/answerDelete?no="+${question.questNo},
				type : "get",
				success : function(data) {
					if(data.res_code == 200) {
						alert(data.res_msg);
						location.href = "<%=request.getContextPath()%>/qnaBoard/detail?no=" + ${question.questNo};
					} else if(data.res_code == 500) {
						alert(data.res_msg);
					}
				}
			})				
		})
	});
	</script>
</body>
</html>