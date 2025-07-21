<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 답변작성</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	
	<div style="display:flex; justify-content: between">
		<span>[QnA]</span>
		<h2>${question.questTitle}</h2>
		<span>${question.questMod}</span>
	</div>	
	<div>${question.questContent}</div>
	
	<form id="update_list_form">
		<input type="hidden" id="answer_account_no" value="${loginAccount.accountNo}">
		<input type="hidden" id="quest_no" value="${question.questNo}">
		<textarea rows="40" cols="70" id="answer_content" style="resize: none; display: block">${answer.answerContent}</textarea>
		<button type="button" onclick="location.href='<c:url value="/qnaBoard/list"/>'">목록</button>
		<button type="button" onclick="openUpdateModal()">수정완료</button>
	</form>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<div class="modal fade" id="modal_update_answer" tabindex="-1" role="dialog" aria-labelledby="printModal" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center">
	        답변을 수정하시겠습니까?
	      </div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" id="btn_modal_update_confirm" class="btn btn-success">확인</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script>
	
	function openUpdateModal() {
		$("#modal_update_answer").modal("show");
	}
	
	$("#btn_modal_update_confirm").click(function(){
		const accountNo = $("#answer_account_no").val();
		const questNo = $("#quest_no").val();
		const answerContent = $("#answer_content").val();
		
		if(!answerContent) {
			$("#modal_update_answer").modal("hide");
			alert("내용을 작성해주세요");
			return;
		}
		
		$.ajax({
			url : "/qnaBoard/answerUpdate",
			type : "post",
			data : {
				accountNo : accountNo,
				questNo : questNo,
				answerContent : answerContent
			},
			dataType : "json",
			success : function(data) {
				console.log(data);
				if(data.res_code == "200") {
					alert(data.res_msg);
					location.href="<%= request.getContextPath()%>/qnaBoard/detail?no=" + questNo;
				} 
			}
		});
	});
	</script>
	
	
</body>
</html>