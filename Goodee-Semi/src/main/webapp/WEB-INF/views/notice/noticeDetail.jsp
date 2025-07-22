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
						<div style="position: relative;">
							<h2>${ notice.noticeTitle }</h2>
							<ul class="list-inline">
								<li class="list-inline-item">훈련사 ${ notice.writer }</li>
								<li class="list-inline-item">작성일 ${ notice.regDate }</li>
							</ul>
							
							<div class="btn-group" style="position: absolute; top: 5%; right: 10px;">
								<c:choose>
									<c:when test="${sessionScope.loginAccount.author == 1}">
						        <button id="noticeUpdateBtn" type="button" data-no="${notice.noticeNo}" class="btn btn-outline-secondary" style="padding: 2px 5px;">수정</button>
						        <button id="noticeDeleteBtn" type="button" data-no="${notice.noticeNo}" class="btn btn-outline-secondary" style="padding: 2px 5px;">삭제</button>
						        <button onclick="location.href='<%=request.getContextPath()%>/notice/list'" class="btn btn-outline-secondary" style="padding: 2px 5px;">목록</button>
									</c:when>
									
									<c:otherwise>
										<button onclick="location.href='<%=request.getContextPath()%>/notice/list'" class="btn btn-outline-secondary" style="padding: 2px 5px;">목록</button>
									</c:otherwise>
								</c:choose>
				      </div>							
						</div>
						
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
						
						<div class="widget user text-center">
							<c:choose>
								<c:when test="${ sessionScope.loginAccount.author eq 1 }">
									<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="profile">
									<h4><a href="<c:url value='/myInfo' />">${ sessionScope.loginAccount.name } 님</a></h4>
									<div class="d-grid gap-2">
											<a href="<c:url value='/notice/write' />" class="btn btn-success col-12 mt-4">공지사항 등록</a>
										</div>
								</c:when>
								
								<c:when test="${ sessionScope.loginAccount.author eq 2 }">
									<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="profile">
									<h4><a href="<c:url value='/myInfo' />">${ sessionScope.loginAccount.name } 님</a></h4>
									<p class="member-time">가입일: ${ sessionScope.loginAccount.reg_date }</p>
								</c:when>
								
								<c:otherwise>
									<div class="d-grid gap-2">
										<a href="<c:url value='/account/login' />" class="btn btn-light btn-outline-dark col-12 px-5 my-1">로그인</a>
										<a href="<c:url value='/account/register' />" class="btn btn-success col-12 px-5 my-1">회원가입</a>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</section>

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  <script>
    $("#noticeUpdateBtn").click(function(){
      const noticeNo = $(this).data("no");
      location.href = "<%=request.getContextPath()%>/noticeUpdate?noticeNo="+noticeNo;
    });
    
    $("#noticeDeleteBtn").click(function(e){
    	e.preventDefault();
    	
    	if(confirm("삭제하시겠습니까?")) {
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
    
    });
    
  </script>
</body>
</html>
