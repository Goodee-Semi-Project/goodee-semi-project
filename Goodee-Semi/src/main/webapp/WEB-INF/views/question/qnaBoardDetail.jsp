<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 게시글 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" 
integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
 crossorigin="anonymous">
 </script>
</head>
<body>
	<div style="display:flex; justify-content: between">
		<span>[QnA]</span>
		<h2>${question.questTitle}</h2>
		<span>${question.questReg}</span>
	</div>	
	<div>${question.questContent}</div>
	<input type="button" onclick='location.href="<c:url value='/qnaBoard/list'/>"' value="목록">
	
	<!-- 로그인 기능 병합 후 두 줄 삭제 -->
	<input type="button" id="btn_modify" onclick='location.href="<c:url value='/qnaBoard/list'/>"' value="수정">			
	<input type="button" id="btn_delete" value="삭제">	
	<!-- 로그인 기능 병합 후 주석 해제 --> 
<%-- 	<c:if test="${not empty loginAccount}"> --%>
<%-- 		<c:if test="${loginAccount.accountNo eq question.accountNo}"> --%>
<%-- 			<input type="button" onclick='location.href="<c:url value='/qnaBoard/list'/>"' value="수정">			 --%>
<%-- 			<input type="button" onclick='location.href="<c:url value='/qnaBoard/list/delete'/>"' value="삭제">			 --%>
<%-- 		</c:if> --%>
<%-- 	</c:if> --%>
	<script>
	$(document).ready(function(){
		$("#btn_delete").click(function(){
			if(confirm("정말 삭제하시겠습니까??")) {			
				
				$.ajax({
					url : "/qnaBoard/list/delete?no="+${question.questNo},
					type : "get",
					success : function(data) {
						if(data == 1) {
							alert("삭제되었습니다");
							location.href = "<%=request.getContextPath() %>/qnaBoard/list";
						}
					}
					
				})
			}		
		});
	});
	</script>
	

</body>
</html>