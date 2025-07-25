<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항 수정</title>
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
					
						<h2 class="tab-title" style="text-align: center;">공지사항 수정</h2>
						<form id="updateNoticeFrm">
			      	<c:if test="${ sessionScope.loginAccount.author eq 1 }">
			      		<input type="hidden" name="noticeNo" value="${ notice.noticeNo }">
			      		<input type="hidden" name="noticeWriter" value="${ loginAccount.accountNo }">
			      		
			      		<fieldset class="p-4">
			      			<div class="mb-2" style="display: flex; justify-content: center;">
			      				<input class="form-control" type="text" id="noticeTitle" name="noticeTitle" placeholder="제목" value="${ notice.noticeTitle }" style="width: 90%; height: 30px; margin: 0 5%;">
			      			</div>
			      			<textarea class="form-control" id="noticeContent" name="noticeContent" placeholder="내용을 입력하세요." style="width: 90%; height: 400px; margin: 0 auto;">${ notice.noticeContent }</textarea>
			      			
			      			<div class="mt-3" style="width: 45%; display: flex; align-items: center;">
			             	<img width="150" height="150" src="<c:url value='/filePath?no=${ attach.attachNo }'/>" style="width: 150px; padding: 5px; margin: 0 10px 0 15%; border: 1px solid #ced4da; object-fit: contain;" id="preview" />
			             	<label for="noticeFile" class="btn btn-outline-secondary" style="padding: 2px 5px;">
			             		<span style="width: 100px; font-size: 12px;">이미지 선택</span>
			             	</label>
										<input type="file" id="noticeFile" name="noticeFile" onchange="readURL(this)" style="opacity: 0; width: 0%;">
			            </div>

			          	<div class="mt-5" style="display: flex; justify-content: center;">
			          		<button type="submit" class="btn btn-primary font-weight-bold" style="padding: 10px 20px; margin-right: 20px;">수정</button>
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
									<c:choose>
										<c:when test="${ not empty sessionScope.loginAccount.profileAttach }">
											<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="profile">
										</c:when>
										<c:otherwise>
											<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/static/images/user/profile.png' />" alt="profile">
										</c:otherwise>
									</c:choose>
									<h4><a href="<c:url value='/myInfo' />">${ sessionScope.loginAccount.name } 님</a></h4>
									<div class="d-grid gap-2">
											<a href="<c:url value='/notice/write' />" class="btn btn-success col-12 mt-4">공지사항 등록</a>
										</div>
								</c:when>
								
								<c:when test="${ sessionScope.loginAccount.author eq 2 }">
									<c:choose>
										<c:when test="${ not empty sessionScope.loginAccount.profileAttach }">
											<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="profile">
										</c:when>
										<c:otherwise>
											<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/static/images/user/profile.png' />" alt="profile">
										</c:otherwise>
									</c:choose>
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
		  $("#updateNoticeFrm").submit(function(e){
		    e.preventDefault(); 
		    
		    const form = document.getElementById("updateNoticeFrm");
		    const formData = new FormData(form);
		    
		    const title = formData.get("noticeTitle")?.trim();
		    const content = formData.get("noticeContent")?.trim();
		    const file = formData.get("noticeFile");

		    // 유효성 검사
		    if (!title) {
		    	Swal.fire({ icon: "error", text: "제목을 입력해주세요."});
		      return;
		    }
	
		    if (!content) {
		    	Swal.fire({ icon: "error", text: "내용을 입력해주세요."});
		      return;
		    }
	
		    if (file && file.name) {
		      const allowedExt = ["jpg", "jpeg", "png", "gif"];
		      const ext = file.name.split('.').pop().toLowerCase();
		      if (!allowedExt.includes(ext)) {
		        Swal.fire({ icon: "error", text: "이미지 파일(jpg, jpeg, png, gif)만 업로드할 수 있습니다."});
		        return;
		      }
		    }
	    	
		    Swal.fire({
					text: "게시글을 수정하시겠습니까?",
					icon: "question",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "수정",
					cancelButtonText: "취소"
				}).then((result) => {
					if (result.isConfirmed) {
						const form = document.getElementById("updateNoticeFrm");
					  const formData = new FormData(form);
					
					  $.ajax({
					    url: "<%=request.getContextPath()%>/noticeUpdate",  // ✅ 수정 URL
					    type: "post",
					    data: formData,
					    enctype: "multipart/form-data",
					    contentType: false,
					    processData: false,
					    cache: false,
					    dataType: "json",
					    success: function(data) {
					    	if (data.resultCode == 200) {
									Swal.fire({
										icon: "success",
										text: data.resultMsg,
										confirmButtonText: "확인"
									}).then((result) => {
										if (result.isConfirmed) {
											location.href="<%=request.getContextPath() %>/notice/list";						    
										}
									});
								} else {
									Swal.fire({ icon: "error", text: data.resultMsg});
								}
					    },
					    error: function() {
					    	Swal.fire({ icon: "error", text: "게시글 수정 중 오류가 발생했습니다."});
					    }
					  });
					}
				});
		    // else를 따로 안 써도, confirm이 false면 그냥 아무 일도 안 하고 끝나게 됨
		  });
		});
	</script>
</body>
</html>
