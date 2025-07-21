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
	
	<form id="add_list_form">
		<input type="hidden" id="answer_account_no" value="${loginAccount.accountNo}">
		<input type="hidden" id="quest_no" value="${question.questNo}">
		<textarea rows="40" cols="70" id="answer_content" style="resize: none; display: block"></textarea>
		<button type="button" onclick="location.href='<c:url value="/qnaBoard/list"/>'">목록</button>
		<button type="button" onclick="openModalAddAnswer()">답변등록</button>
	</form>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<div class="modal fade" id="modal_add_answer" tabindex="-1" role="dialog" aria-labelledby="printModal" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center">
	        답변을 등록하시겠습니까?
	      </div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" id="btn_modal_answer_confirm" class="btn btn-success">확인</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script>
	
	function openModalAddAnswer() {
		$("#modal_add_answer").modal("show");
	}
	
	$("#btn_modal_answer_confirm").click(function() {
		const answerAccountNo = $("#answer_account_no").val();
		const questNo = $("#quest_no").val();
		const answerContent = $("#answer_content").val();
		
		if(!answerContent) {
			$("#modal_add_answer").modal("hide");
			alert("내용을 작성해주세요");
			return;
		}
		$.ajax({
			url : "/qnaBoard/answerAdd",
			type : "post",
			data : {
				answerAccountNo : answerAccountNo,
				questNo : questNo,
				answerContent : answerContent
			},
			dataType : "json",
			success : function (data) {
				if(data.res_code == 200) {
					alert(data.res_msg);
					location.href="<%=request.getContextPath()%>/qnaBoard/detail?no=" + questNo;
				} else {
					alert(data.res_msg);
				}
			}
		})
	});
		
	
	</script>
	
</body>
</html>