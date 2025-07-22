<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 답변작성</title>

<style>
	.d-flex button{
		padding : 5px 20px !important; 
		background-color: #5672f9 !important;
	}
</style>

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
				<span class="h2" style="font-size: 18px;">${ question.questTitle }</span>
			</div>
			<div>
				<div>${ question.questReg }</div>
			</div>
		</div>
		<div>
		    <div style="padding : 24px"></div>
  		</div>
	</div>	
	
	
	<section>
	    <div class="container">
	        <div class="row">
	            <div class="col-md-12">
                    <form id="update_list_form">
                        <div class="col-lg-12 pt-6">
                        	<input type="hidden" id="answer_account_no" value="${ loginAccount.accountNo }">
                        	<input type="hidden" id="quest_no" value="${ question.questNo }">
                       		<textarea name="message" id="answer_content" class="border p-3 mx-2 mt-3 mt-lg-4" style="resize: none; height: 200px; width: 97%; outline: none;">${answer.answerContent}</textarea>
	                       	<div class="d-flex justify-content-between m-2">
	                 			<button type="button" class="btn btn-primary" onclick="toList()">목록</button>
								<button type="button" class="btn btn-success" style="background-color: #198754 !important;" onclick="openUpdateModal()">등록</button>
							</div>
                        </div>
                    </form>
	            </div>
	        </div>
	    </div>
	</section>
	
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
	      <div class="modal-body text-center">답변을 수정하시겠습니까?</div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" id="btn_modal_update_confirm" class="btn btn-success">확인</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script>
	function toList() {
		location.href="<%=request.getContextPath()%>/qnaBoard/list";
	}	
	
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