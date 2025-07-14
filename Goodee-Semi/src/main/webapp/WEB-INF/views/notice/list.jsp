<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<h2>공지사항</h2>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/notice/noticeHeader.jsp" %>


	<form action="/notice/list" method="get">
	  <input type="text" name="keyword" placeholder="제목 또는 작성자 검색" value="${param.keyword}">
	  <button type="submit">검색</button>
	</form>	
	<table>
	  <thead>
	    <tr>
	    	<th>번호</th>
	    	<th>제목</th>
	    	<th>작성자</th>
	    	<th>작성일</th>
    	</tr>
	  </thead>
	  <tbody>
	    <c:forEach var="n" items="${noticeList}">
		 <tr>
		   <td>
		     <c:choose>
		       <c:when test="${n.nailUp eq 'Y'}">
		         <span style="font-size: 18px;">📌</span>
		       </c:when>
		       <c:otherwise>
		         ${n.noticeNo}
		       </c:otherwise>
		     </c:choose>
		   </td>
		   <td onclick="location.href='<c:url value='/noticeDetail?no=${n.noticeNo}'/>'">${n.noticeTitle}</td>
		   <td>${n.writer}</td>
		   <td>${n.regDate}</td>
		 </tr>
		</c:forEach>

	  </tbody>
	</table>
	<c:if test="${not empty noticeList }">
		<div>
			<c:if test="${paging.prev }">
				<a href="<c:url value='/notice/list?nowPage=${paging.pageBarStart-1 }&keyword=${param.keyword }'/>">
					&laquo;
				</a>
			</c:if>
			<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
				<a href="<c:url value='/notice/list?nowPage=${i }&keyword=${param.keyword }'/>">
					${i }
				</a>
			</c:forEach>
			<c:if test="${paging.next }">
				<a href="<c:url value='/notice/list?nowPage=${paging.pageBarEnd+1 }&keyword=${param.keyword }'/>">
					&raquo;
				</a>
			</c:if>			
		</div>
	</c:if>
	<c:if test="${sessionScope.loginAccount.author == 1}">
	  <form action="/notice/write" method="get" style="display:inline;">
	    <button type="submit">등록</button>
	  </form>
	</c:if>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>