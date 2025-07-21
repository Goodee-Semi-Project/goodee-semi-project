<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA게시글 등록</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	
	<form id="addListform">
		<input type="hidden" id="qna_account_no" value="${loginAccount.accountNo}">
		<label for="qna_title">제목</label>
		<input type="text" name="qna_title" id="qna_title" placeholder="제목 입력">
		<textarea rows="40" cols="70" id="qna_content" style="resize: none; display: block"></textarea>
		<button type="button" onclick="location.href='<c:url value="/qnaBoard/list"/>'">목록</button>
		<button type="button" onclick="openAddModal()">등록</button>
	</form>
	
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="printModal" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center">
	        등록하시겠습니까?
	      </div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" id="btn_modal_confirm" class="btn btn-success">확인</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
			
	<script>
		function openAddModal() {
			$("#addModal").modal("show");
		}
		
		$(document).ready(function (){
			$("#btn_modal_confirm").click(function(){
				const qnaAccountNo = $('#qna_account_no').val();
				const qnaTitle = $('#qna_title').val();
				const qnaContent = $('#qna_content').val();
				
				if(!qnaTitle || !qnaContent) {
					$("#addModal").modal("hide");
					alert("제목과 내용을 모두 작성해주세요");
					return;
				}
				
				$.ajax({
					url : "/qnaBoard/questionAdd",
					type : "post",
					data : {
						qnaAccountNo : qnaAccountNo,
						qnaTitle : qnaTitle,
						qnaContent : qnaContent
					},
					dataType : "json",
					success : function(data) {
						alert(data.res_msg);
						if(data.res_code == 200) {
							location.href = "<%=request.getContextPath() %>/qnaBoard/list"
						}
					}
				});
			});
		})
		
		
		
	</script>
</body>
</html>