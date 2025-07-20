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
	
	<!-- 회원글 -->
	<div style="display:flex; justify-content: between">
		<span>[QnA]</span>
		<h2>${question.questTitle}</h2>
		<span>${question.questReg}</span>
	</div>	
	<div>${question.questContent}</div>
	
	<!-- 훈련사답변 -->
	<c:if test="${not empty answer}">
		<div>
		<div>${answer.accountId}</div>
		<div>${answer.answerReg}</div>		
		</div>
		<div>${answer.answerContent}</div>
	</c:if>
	
	<input type="button" onclick='location.href="<c:url value='/qnaBoard/list'/>"' value="목록">
	<c:if test="${not empty loginAccount}">
		<c:if test="${loginAccount.accountNo eq question.accountNo}">
			<input type="button" value="수정" 
			onclick='location.href="${request.contextPath()}/qnaBoard/questionUpdate?no=${question.questNo}&accountNo=${question.accountNo}"'>
			<input type="button" id="btn_delete_question" value="삭제">				
		</c:if>
		<c:if test="${loginAccount.author eq 1}">
			<c:choose>
				<c:when test="${empty answer}">
					<button type="button" onclick="location.href='${request.contextPath()}/qnaBoard/answerAdd?no=${question.questNo}'">답변등록</button>
				</c:when>
				<c:otherwise>
					<button type="button" onclick="location.href='${request.contextPath()}/qnaBoard/answerUpdate?no=${question.questNo}'">답변수정</button>
					<button type="button" id="btn_delete_answer">답변삭제</button>
				</c:otherwise>
			</c:choose>
		</c:if>
	</c:if>

    <%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	
	<script>
	$(document).ready(function(){
		$("#btn_delete_question").click(function(){
			if(confirm("정말 삭제하시겠습니까??")) {
				$.ajax({
					url : "/qnaBoard/questionDelete?no="+${question.questNo},
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

	$(document).ready(function(){
		$("#btn_delete_answer").click(function(){
			if(confirm("정말 삭제하시겠습니까?")) {
				$.ajax({
					url : "/qnaBoard/answerDelete?no="+${question.questNo},
					type : "get",
					success : function(data) {
						if(data.res_code == 200) {
							alert(data.res_msg);
							location.href = "<%=request.getContextPath()%>/qnaBoard/detail?no=" + ${question.questNo};
						} else if(data.res_code == 500) {
							alert(data.res_msg);
						}
					}
				})				
			}
		})
	});
	</script>
</body>
</html>