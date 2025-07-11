<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Qna 답변작성</title>

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
		<label for="answer_title">제목</label>
		<textarea rows="40" cols="70" id="answer_content" style="resize: none; display: block"></textarea>
		<button type="button" onclick="location.href='<c:url value="/qnaBoard/list"/>'">목록</button>
		<button type="submit" id="btn_reg">답변등록</button>
	</form>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<script>
	$("#add_list_form").submit(function(e) {
		e.preventDefault();
		
		if(confirm("답변을 등록하시겠습니까?")) {
		
			const answerAccountNo = $("#answer_account_no").val();
			const questNo = $("#quest_no").val();
			const answerContent = $("#answer_content").val();
			
			if(!answerContent) {
				alert("제목과 내용을 모두 작성해주세요");
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
			
		};
	});
		
	
	</script>
	
</body>
</html>