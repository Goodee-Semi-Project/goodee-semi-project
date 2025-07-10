<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA게시글 등록</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
 crossorigin="anonymous">
 </script>
</head>
<body>
	<form id="addListform">
<%-- 	<input type="hidden" id="qna_account_no" value="${loginAccount.accountNo}"> --%>
		<label for="qna_account_no">임시 accountNo</label>
		<input type="number" id="qna_account_no" value="${loginAccount.accountNo}">
		
		<label for="qna_title">제목</label>
		<input type="text" name="qna_title" id="qna_title" placeholder="제목 입력">
		<textarea rows="40" cols="70" id="qna_content" style="resize: none; display: block"></textarea>
		<button type="button" onclick="location.href='<c:url value="/qnaBoard/list"/>'">목록</button>
		<button type="submit" id="btn_reg">등록</button>
	</form>
		
	<script>
		$("#addListform").submit(function(e){
			e.preventDefault();
			
			if(confirm('등록하시겠습니까?')) {
				const qnaAccountNo = $('#qna_account_no').val();
				const qnaTitle = $('#qna_title').val();
				const qnaContent = $('#qna_content').val();
				
				if(!qnaTitle || !qnaContent) {
					alert("제목과 내용을 모두 작성해주세요");
					return;
				}
				
				$.ajax({
					url : "/qnaBoard/list/add",
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
							console.log("sucess 가져옴")
							location.href = "<%=request.getContextPath() %>/qnaBoard/list"
						}
					}
				});
			}
			
		});
	</script>
</body>
</html>