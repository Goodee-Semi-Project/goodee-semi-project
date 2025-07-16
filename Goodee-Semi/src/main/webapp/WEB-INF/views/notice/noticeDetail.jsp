<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>게시글 상세 내용</title>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
  <%@ include file="/WEB-INF/views/include/header.jsp" %>
  <%@ include file="/WEB-INF/views/notice/noticeHeader.jsp" %>

  <div class="notice-wrapper">
    <div class="notice-box">
      <div class="notice-header">
        <div>${notice.noticeTitle}</div>
        <div>${notice.regDate}</div>
      </div>
      <div class="notice-meta">
        <div>번호 ${notice.noticeNo}</div>
        <div>작성자 ${notice.writer}</div>
      </div>
      <div class="notice-content">
        ${notice.noticeContent}
      </div>

      <div class="btn-group">
      <c:if test="${sessionScope.loginAccount.author == 1}">
        <button id="noticeUpdateBtn" type="button" data-no="${notice.noticeNo}">수정</button>
        <button id="noticeDeleteBtn" type="button" data-no="${notice.noticeNo}">삭제</button>
        <button onclick="location.href='<%=request.getContextPath()%>/notice/list'">목록</button>
      </c:if>
      </div>
    </div>
  </div>

  <c:if test="${not empty attach}">
    <h4>첨부파일</h4>
    <img src="<c:url value='/filePath?no=${attach.attachNo}'/>" style="max-width: 300px;">
  </c:if>

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>

  
  <script>
    $("#noticeUpdateBtn").click(function(){
      const noticeNo = $(this).data("no");
      location.href = "<%=request.getContextPath()%>/noticeUpdate?noticeNo="+noticeNo;
    });
    
    $("#noticeDeleteBtn").click(function(e){
    	e.preventDefault();
    	if(confirm("삭제하시겠습니까?")){
	    	const noticeNo = $(this).data("no");
    		$.ajax({
    			url:"<%=request.getContextPath()%>/noticeDelete",
    			type : "post",
    			data : {noticeNo : noticeNo},
    			success : function(data){
    				alert(data.res_msg);
    				if(data.res_code == 200){
    					location.href="<%=request.getContextPath() %>/notice/list"
    				}
    			}
    		});		
    	}
    	
    })
    
  </script>
</body>
</html>
