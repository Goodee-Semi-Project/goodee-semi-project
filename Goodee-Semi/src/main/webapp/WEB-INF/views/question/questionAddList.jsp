<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA게시글 등록</title>

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
	
	<!-- Title -->
	<section class="page-title">
		<div class="container">
			<div class="row">
				<div class="col-md-8 offset-md-2 text-center">
					<h3>질문등록</h3>
				</div>
			</div>
		</div>
	</section>	
	
	<section class="section" style="padding: 0">
	    <div class="container">
	        <div class="row">
	            <div class="col-md-12">
                    <form id="addListform">
                        <fieldset class="p-4">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-lg-12 pt-6">
                                    	<input type="hidden" id="quest_account_no" value="${ loginAccount.accountNo }">
                                        <input type="text" name="quest_title" id="quest_title" placeholder="제목" class="form-control" required>
                                    </div>
                                </div>
                            </div>
                            <textarea id="quest_content" class="border w-100 p-3 mt-1 mt-lg-2" style="resize: none; height: 450px; outline: none;"></textarea>
                        </fieldset>
                       	<div class="d-flex justify-content-between px-4">
                 			<button type="button" class="btn btn-primary" onclick="toList()">목록</button>
							<button type="button" class="btn btn btn-success" style="background-color: #198754 !important;" onclick="openAddModal()">등록</button>
						</div>
                    </form>
	            </div>
	        </div>
	    </div>
	</section>
	
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
	      <div class="modal-body text-center">등록하시겠습니까?</div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" id="btn_modal_confirm" class="btn btn-success">확인</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
			
	<script>
		function toList() {
			location.href="<%=request.getContextPath()%>/qnaBoard/list"
		}
	
		function openAddModal() {
			$("#addModal").modal("show");
		}
		
		$(document).ready(function (){
			$("#btn_modal_confirm").click(function(){
				const qnaAccountNo = $('#quest_account_no').val();
				const qnaTitle = $('#quest_title').val();
				const qnaContent = $('#quest_content').val();
				
				if(!qnaTitle) {
					$("#addModal").modal("hide");
					alert("제목을 입력해주세요");
					return;
				}
				if(!qnaContent) {
					$("#addModal").modal("hide");
					alert("내용을 입력해주세요");
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