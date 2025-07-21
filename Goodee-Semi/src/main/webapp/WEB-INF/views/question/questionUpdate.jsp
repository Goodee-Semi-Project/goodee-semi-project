<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA질문 수정</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	
	<form id="update_quest_form">
		<div>
			<input type="hidden" id="quest_account_no" value="${loginAccount.accountNo}">
			<label for="qna_title">제목</label>
			<input type="hidden" id="quest_no" value="${question.questNo}">
			<input type="text" name="quest_title" id="quest_title" value="${question.questTitle}">
			<textarea rows="100" cols="70" id="quest_content" style="resize: none; display: block">${question.questContent}</textarea>
			<button type="button" onclick="location.href='<c:url value="/qnaBoard/list"/>'">목록</button>
			<button type="button" onclick="openUpdateModal()">수정완료</button>
		</div>
	</form>
	
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="printModal" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center">
	      	게시글을 수정하시겠습니까?
	      </div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" id="btn_modal_confirm" class="btn btn-success">확인</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<script>
	
		function openUpdateModal() {
			$("#updateModal").modal("show");
		}
	
		$("#btn_modal_confirm").click(function (){
			const questNo = $("#quest_no").val();
			const questTitle = $("#quest_title").val();
			const questContent = $("#quest_content").val();
			
			if(!questNo || !questTitle || !questContent) {
				$("#updateModal").modal("hide");
				alert("제목과 내용을 모두 작성해주세요");
				return;		
			}
			
			$.ajax({
				url : "/qnaBoard/questionUpdate",
				type : "post",
				data : {
					questNo : questNo,
					questTitle : questTitle,
					questContent : questContent
				},
				dataType : "json",
				success : function(data) {
					if(data.res_code == 200) {
						alert(data.res_msg);
						location.href='<%=request.getContextPath() %>/qnaBoard/detail?no=' + questNo;
					} else {
						alert(data.res_msg);
					}
				}
			});
		});
	</script>		
</body>
</html>