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
	<div class="container">
		<div style="border-bottom: 1px solid #ccc; padding: 15px; display: flex; justify-content: space-between;">
			<div>
				<span style="font-weight: bold;">[QnA]</span>
			</div>
			<div>
				<span class="h2" style="font-size: 18px;">${question.questTitle}</span>
			</div>
			<div>
				<div>${question.questReg}</div>
			</div>
		</div>
		<div class="p-2">
		    <div class="p-3">
		      ${question.questContent}
		    </div>
  		</div>
	</div>	


	<!-- 훈련사답변 -->
	<div class="container">
		<div class="p-2">
			<c:if test="${not empty answer}">
				<div class="d-flex justify-content-between p-2">
					<div class="d-flex p-1" style="align-items : center">
						<img src="<c:url value='/filePath?no=${answer.profileAttach.attachNo}'/>" alt="프로필사진" 
						style="width : 40px; height : 40px; border-radius : 20px; margin : 1px">
						<div class="mx-2">${answer.accountId}</div>
					</div>
					<div>${answer.answerReg}</div>		
				</div>
				<div>
					<div style="padding : 0 16px 16px 16px">${answer.answerContent}</div>
				</div>
			</c:if>
		</div>
	</div>
	
	<div class="container">
		<div class="d-flex justify-content-between p-3">
			<div>
				<input type="button" onclick='location.href="<c:url value='/qnaBoard/list'/>"' value="목록">
			</div>
			<c:if test="${not empty loginAccount}">
				<div>
					<c:if test="${loginAccount.accountNo eq question.accountNo}">
						<input type="button" onclick="update()" value="수정" >
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
				</div>
			</c:if>
		</div>
	</div>

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
					} else {
						alert("답변이 있는 게시물은 삭제할 수 없습니다");
						$("#deleteQuestionModal").modal("hide");
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