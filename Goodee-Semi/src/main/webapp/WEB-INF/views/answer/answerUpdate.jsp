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
		<button type="submit" id="btn_reg">수정완료</button>
	</form>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<script>
	$("#update_list_form").submit(function(e){
		e.preventDefault();
		
		if(confirm("수정하시겠습니까?")) {
			const accountNo = $("#answer_account_no").val();
			const questNo = $("#quest_no").val();
			const answerContent = $("#answer_content").val();
			
			if(!answerContent) {
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
					console.log("성공함")
					console.log(data);
					if(data.res_code == "200") {
						alert(data.res_msg);
						location.href="<%= request.getContextPath()%>/qnaBoard/detail?no=" + questNo;
					} 
				}
			});
		};
	});
	</script>
	
	
</body>
</html>