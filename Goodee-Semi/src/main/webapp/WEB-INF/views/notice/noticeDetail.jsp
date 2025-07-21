<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항 상세</title>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
  <%@ include file="/WEB-INF/views/include/header.jsp" %>
  <%@ include file="/WEB-INF/views/notice/noticeHeader.jsp" %>
  
  <section class="blog single-blog section">
		<div class="container">
			<div class="row">
				<div class="col-lg-8">
					<article class="single-post">
						<h2>${ notice.noticeTitle }</h2>
						<ul class="list-inline">
							<li class="list-inline-item">훈련사 ${ notice.writer }</li>
							<li class="list-inline-item">작성일 ${ notice.regDate }</li>
							<li class="list-inline-item">수정일 ${ notice.modDate }</li>
						</ul>
						
						<c:choose>
							<c:when test="${ not empty notice.noticeAttach }">
								<img class="img-fluid" src="<c:url value='/filePath?no=${ notice.noticeAttach.attachNo }' />" alt="notice">
							</c:when>
									
							<c:otherwise>
								<img class="img-fluid" src="/static/images/notice/notice_default.jpg" alt="notice_default">									
							</c:otherwise>
						</c:choose>
						<p>${ notice.noticeContent }</p>
					</article>
				</div>
				<div class="col-lg-4">
					<div class="sidebar">
						<!-- Search Widget -->
						<div class="widget search p-0">
							<div class="input-group">
								<form action="/notice/list" method="get" style="width: 100%; display: flex;">
	  							<input type="text" class="form-control" id="expire" name="keyword" placeholder="제목 또는 작성자 검색" value="${param.keyword}">
	  							<button type="submit" class="input-group-addon"><i class="fa fa-search px-3"></i></button>
								</form>
						  </div>
						</div>
						
						
					</div>
				</div>
			</div>
		</div>
	</section>

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
