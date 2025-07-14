<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA게시글 조회</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp"%>
	
	<div style="display:flex; justify-content: between">
		<span>[QnA]</span>
		<h2>${question.questTitle}</h2>
		<span>${question.questReg}</span>
	</div>	
	<div>${question.questContent}</div>
	<input type="button" onclick='location.href="<c:url value='/qnaBoard'/>"' value="목록">
	
	<!-- 로그인 기능 병합 후 두 줄 삭제 -->
	<input type="button" onclick='location.href="${request.contextPath()}/qnaBoard/questionUpdate?no=${question.questNo}"'
       value="수정">
		
	<input type="button" id="btn_delete" value="삭제">	
	<!-- 로그인 기능 병합 후 주석 해제 --> 
<%-- 	<c:if test="${not empty loginAccount}"> --%>
<%-- 		<c:if test="${loginAccount.accountNo eq question.accountNo}"> --%>
<%-- 			<input type="button" id="btn_update" onclick='location.href="<c:url value='/qnaBoard/questionUpdate?no=${question.questNo}'/>"' value="수정"> --%>
<%-- 			<input type="button" id="btn_delete" value="삭제">				 --%>
<%-- 		</c:if> --%>
<%-- 	</c:if> --%>


	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<script>
	$(document).ready(function(){
		$("#btn_delete").click(function(){
			if(confirm("정말 삭제하시겠습니까??")) {			
				$.ajax({
					url : "/qnaBoard/questionDelete?no="+${question.questNo},
					type : "get",
					success : function(data) {
						if(data == 1) {
							alert("삭제되었습니다");
							location.href = "<%=request.getContextPath() %>/qnaBoard";
						}
					}
				})
			}		
		});
	});
	</script>
</body>
</html>