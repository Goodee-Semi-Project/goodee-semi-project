<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
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
					
						<h2 class="tab-title" style="text-align: center;">공지사항 등록</h2>
						<form id="createNoticeFrm">
			      	<c:if test="${ sessionScope.loginAccount.author eq 1 }">
			      		<input type="hidden" name="noticeWriter" value="${ loginAccount.accountNo }">
			      		
			      		<fieldset class="p-4">
			      			<div class="mb-2" style="display: flex; justify-content: center;">
			      				<input class="form-control" type="text" id="noticeTitle" name="noticeTitle" placeholder="제목" style="width: 90%; height: 30px; margin: 0 5%;" required>
			      			</div>
			      			<textarea class="form-control" id="noticeContent" name="noticeContent" placeholder="내용을 입력하세요." style="width: 90%; height: 400px; margin: 0 auto;"></textarea>
			      			
			      			<div class="mt-3" style="width: 45%; display: flex; align-items: center;">
			             	<img width="150" height="150" style="width: 150px; padding: 5px; margin: 0 10px 0 15%; border: 1px solid #ced4da; object-fit: contain;" id="preview" />
			             	<label for="noticeFile" class="btn btn-outline-secondary" style="padding: 2px 5px;">
			             		<span style="width: 100px; font-size: 12px;">이미지 선택</span>
			             	</label>
										<input type="file" id="noticeFile" name="noticeFile" onchange="readURL(this)" style="opacity: 0; width: 0%;">
			            </div>

			          	<div class="mt-5" style="display: flex; justify-content: center;">
			          		<button type="submit" class="btn btn-primary font-weight-bold" style="padding: 10px 20px; margin-right: 20px;">등록</button>
			          		<button type="button" class="btn btn-outline-secondary font-weight-bold" style="padding: 10px 20px;" onclick="history.back()">취소</button>
			          	</div>
			        	</fieldset>
			      	</c:if>
			      </form>
					
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
		function readURL(input) {
			if (input.files && input.files[0]) {
			  const reader = new FileReader();
			    
			  reader.onload = function(event) {
			    document.getElementById('preview').src = event.target.result;
			  };
			    
			  reader.readAsDataURL(input.files[0]);
			} else {
			  document.getElementById('preview').src = "";
			}
		}
	
		$(function(){
    	$("#createNoticeFrm").submit(function(e){
        e.preventDefault();
        
        const form = document.getElementById("createNoticeFrm");
        const formData = new FormData(form);
        
        $.ajax({
          url : "<%=request.getContextPath()%>/notice/write",
          type : "post",
          data : formData,
          enctype : "multipart/form-data",
          contentType : false,
          processData : false,
          cache : false,
          dataType : "json",
          success: function(res){
            try {
              alert(res.resultMsg || "등록 결과 수신");
							
              if (res.resultCode == "200") {
                location.href = "<%=request.getContextPath()%>/notice/list";
              }
          	} catch (e) {
            	console.error("🔥 JS 예외 발생:", e);
          	}
        	}
      	});
  		});
		});
	</script>

</body>
</html>