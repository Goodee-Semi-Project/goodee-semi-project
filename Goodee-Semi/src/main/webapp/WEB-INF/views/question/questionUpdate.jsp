<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA질문 수정</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
 crossorigin="anonymous">
 </script>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	
	<form id="btn_quest_update">
		<div>
		<%-- 		<input type="hidden" id="qna_account_no" value="${loginAccount.accountNo}"> --%>
		<label for="qna_account_no">임시 accountNo</label>
		<input type="number" id="quest_account_no" value="${question.accountNo}">

		<label for="qna_title">제목</label>
		<input type="hidden" id="quest_no" value="${question.questNo}">
		<input type="text" name="quest_title" id="quest_title" value="${question.questTitle}">
		<textarea rows="40" cols="70" id="quest_content" style="resize: none; display: block">${question.questContent}</textarea>
		<button type="button" onclick="location.href='<c:url value="/qnaBoard"/>'">목록</button>
		<button type="submit" id="btn_reg">수정완료</button>
		</div>
	</form>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<script>
		$("#btn_quest_update").submit(function (e){
			e.preventDefault();
			
			if(confirm("수정하시겠습니까?")) {
				const questNo = $("#quest_no").val();
				const questTitle = $("#quest_title").val();
				const questContent = $("#quest_content").val();
				
				if(!questNo || !questTitle || !questContent) {
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
			};
		});
	</script>		
</body>
</html>