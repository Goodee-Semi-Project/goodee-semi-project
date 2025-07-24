<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>${ course.title } - 교육과정 세부 조회</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<section class="hero-area bg-1 text-left overly">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<!-- Header Content -->
				<div class="content-block">
					<h1>기초부터 확실하게.</h1>
					<p>더 안전한 훈련, 더 정확한 행동 교정,<br>고객과 훈련사의 1:1 맞춤 관리 시스템으로<br>반려견과 함께하는 더 나은 삶을 위해 노력합니다.</p>
				</div>
				<%@ include file="/WEB-INF/views/include/search.jsp" %>
			</div>
		</div>
	</div>
	<!-- Container End -->
	</section>
	
	<section class="section bg-gray">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<!-- Left sidebar -->
			<div class="col-lg-8">
				<div class="product-details">
					<input id="courseNo" type="hidden" value="${ course.courseNo }">
					<div style="display: flex; justify-content: center;">
						<img class="card-img-top img-fluid" style="width: 200px; height: 200px; margin-right: 50px; border: 3px solid white" src="<c:url value='/filePath?no=${ course.thumbAttach.attachNo }' />" alt="img">
						<div class="product-meta" style="display: flex; flex-direction: column; justify-content: center;">
							<h1 class="product-title" style="font-size: 48px;">${ course.title }</h1>
							<ul class="list-inline">
								<li class="list-inline-item"><i class="fa fa-user-o"></i> 훈련사 ${ course.name }</li>
								<li class="list-inline-item"><i class="fa fa-tags"></i> 태그 ${ course.tag }</li>
							</ul>
						</div>
					</div>
				
					<div class="content mt-5 pt-5">
						<ul class="nav nav-pills  justify-content-center" id="pills-tab" role="tablist">
							<li class="nav-item">
								<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home"
								 aria-selected="true">과정 소개</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile"
								 aria-selected="false">세부 정보</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact"
								 aria-selected="false">후기</a>
							</li>
						</ul>
						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
								<h3 class="tab-title" style="font-size: 32px;">${ course.subTitle }</h3>
								<p style="font-size: 16px;">${ course.object }</p>
								<img class="card-img-top img-fluid" style="width: 800px; height: 400px; object-fit: cover; border: 3px solid white; box-shadow: 3px 3px 2px rgba(0, 0, 0, 0.2);" src="<c:url value='/filePath?no=${ course.inputAttach.attachNo }' />" alt="img">
								<div class="container" style="display: flex; align-items: center; margin: 40px auto;">
									<div class="col-4">
										<c:choose>
											<c:when test="${ not empty course.profileAttach }">
												<img class="rounded-circle img-fluid" style="border: 3px solid white; box-shadow: 3px 3px 2px rgba(0, 0, 0, 0.2);" src="<c:url value='/filePath?no=${ course.profileAttach.attachNo }' />" alt="profile">
											</c:when>
											<c:otherwise>
												<img class="rounded-circle img-fluid" style="border: 3px solid white; box-shadow: 3px 3px 2px rgba(0, 0, 0, 0.2);" src="<c:url value='/static/images/user/profile.png' />" alt="profile">
											</c:otherwise>
										</c:choose>
									</div>
									<div class="col-8">
										<h3 class="tab-title" style="font-size: 32px;">훈련사 ${ course.name }</h3>
										<p>
											강아지는 생후 약 8주부터 사회화하기 시작합니다.<br>
											적절한 시기, 적절한 훈련은 반려견의 사회화에<br>
											긍정적인 영향을 줍니다.<br>
											<br>
											12년간 쌓아올린 훈련 경력으로<br>
											반려견의 소중한 시기를 함께합니다.
										</p>
									</div>
								</div>
							</div>
							<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
								<h3 class="tab-title">교육과정 세부 정보</h3>
								<table class="table table-bordered product-table">
									<tbody>
										<tr>
											<td>과정번호</td>
											<td>${ course.courseNo }</td>
										</tr>
										<tr>
											<td>과정명</td>
											<td>${ course.title }</td>
										</tr>
										<tr>
											<td>담당 훈련사</td>
											<td>${ course.name }</td>
										</tr>
										<tr>
											<td>훈련 횟수</td>
											<td>${ course.totalStep }</td>
										</tr>
										<tr>
											<td>최대 수강 인원</td>
											<td>${ course.capacity }</td>
										</tr>
										<tr>
											<td>사전학습</td>
											<td>매 훈련 전 온라인 학습 진행</td>
										</tr>
										<tr>
											<td>수강확인증</td>
											<td>제공</td>
										</tr>
										<tr>
											<td>수료증</td>
											<td>제공</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
								<h3 class="tab-title">후기</h3>
								<div class="product-review">
									<div class="media">
										<!-- Avater -->
										<img src="images/user/user-thumb.jpg" alt="avater">
										<div class="media-body">
											<!-- Ratings -->
											<div class="ratings">
												<ul class="list-inline">
													<li class="list-inline-item">
														<i class="fa fa-star"></i>
													</li>
													<li class="list-inline-item">
														<i class="fa fa-star"></i>
													</li>
													<li class="list-inline-item">
														<i class="fa fa-star"></i>
													</li>
													<li class="list-inline-item">
														<i class="fa fa-star"></i>
													</li>
													<li class="list-inline-item">
														<i class="fa fa-star"></i>
													</li>
												</ul>
											</div>
											<div class="name">
												<h5>Jessica Brown</h5>
											</div>
											<div class="date">
												<p>Mar 20, 2018</p>
											</div>
											<div class="review-comment">
												<p>
													Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremqe laudant tota rem ape
													riamipsa eaque.
												</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="sidebar">
					<div class="widget user text-center">
						<input id="accountNo" type="hidden" value="${ sessionScope.loginAccount.accountNo }">
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
								<c:if test="${ sessionScope.loginAccount.accountNo eq course.accountNo }">
									<div class="d-grid gap-2">
										<a href="<c:url value='/myCourse/memberManagement' />" class="btn btn-light btn-outline-dark col-12 px-5 my-1">회원 관리</a>
										<a href="<c:url value='/myCourse/enrollList' />" class="btn btn-light btn-outline-dark col-12 px-5 my-1">수강신청 관리</a>
										<a href="<c:url value='/preCourse/list' />" class="btn btn-light btn-outline-dark col-12 px-5 my-1">사전학습 관리</a>
										<a href="<c:url value='/schedule' />" class="btn btn-light btn-outline-dark col-12 px-5 my-1">일정 관리</a>
										<a href="<c:url value='/assign/list' />" class="btn btn-light btn-outline-dark col-12 px-5 my-1">과제 관리</a>
									</div>
								</c:if>
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
								<div class="d-grid gap-2">
									<c:choose>
										<c:when test="${ course.petInCourseCount ge course.capacity }">
											<button type="button" id="enrollOpen" class="btn btn-danger col-12 px-5 my-1" disabled>신청 불가</button>
										</c:when>
										
										<c:otherwise>
											<a id="enrollOpen" class="btn btn-primary col-12 px-5 my-1">수강신청</a>
										</c:otherwise>
									</c:choose>
									<div id="enrollDiv" style="display: none;">
										<label for="selectPetForEnroll">수강을 신청할 반려견을 선택해주세요.</label>
										<select id="selectPetForEnroll" class="col-8 px-5 mr-5 my-1">
											<c:forEach var="pet" items="${ myPetList }">
												<option value="${ pet.petNo }">${ pet.petName }</option>
											</c:forEach>
										</select>
										<button id="enrollBtn" type="button" class="btn btn-success col-4 my-1">신청</button>
									</div>
									
									<c:choose>
										<c:when test="${ isLike eq 'Y' }">
											<a id="removeLikeBtn" class="btn btn-light btn-outline-dark col-12 px-5 my-1">찜 해제</a>
										</c:when>
										
										<c:otherwise>
											<a id="addLikeBtn" class="btn btn-danger col-12 px-5 my-1">찜하기</a>
										</c:otherwise>
									</c:choose>
									
									<a href="<c:url value='/preCourse/list' />" class="btn btn-light btn-outline-dark col-12 px-5 my-1">사전학습</a>
									<a href="<c:url value='/schedule' />" class="btn btn-light btn-outline-dark col-12 px-5 my-1">일정표</a>
									<a href="<c:url value='/assign/list' />" class="btn btn-light btn-outline-dark col-12 px-5 my-1">과제</a>
								</div>
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
	<!-- Container End -->
	</section>

	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		$(() => {
			$("#addLikeBtn").on("click", (event) => {
				event.preventDefault();
				
				Swal.fire({
					text: "찜 목록에 추가하시겠습니까?",
					icon: "question",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "추가",
					cancelButtonText: "취소"
				}).then((result) => {
					if (result.isConfirmed) {
						const likeFlag = "ADD";
						const accountNo = $("#accountNo").val();
						const courseNo = $("#courseNo").val();
						
						$.ajax({
							url : "/myCourse/like",
							type : "POST",
							data : {
								likeFlag : likeFlag,
								accountNo : accountNo,
								courseNo : courseNo
							},
							dataType : "JSON",
							success : function(data) {
								if (data.resultCode == 200) {
									Swal.fire({
										icon: "success",
										text: data.resultMsg,
										confirmButtonText: "확인"
									}).then((result) => {
										if (result.isConfirmed) {
											location.href = "<%= request.getContextPath() %>/course/detail?no=" + courseNo;							    
										}
									});
								} else {
									Swal.fire({ icon: "error", text: data.resultMsg});
								}
							},
							error : function() {
								Swal.fire({ icon: "error", text: "찜 목록 추가 중 오류가 발생했습니다."});
							}
						});
					}
				});
			});
			
			$("#removeLikeBtn").on("click", (event) => {
				event.preventDefault();
				
				Swal.fire({
					text: "찜 목록에서 제거하시겠습니까?",
					icon: "warning",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "제거",
					cancelButtonText: "취소"
				}).then((result) => {
					if (result.isConfirmed) {
						const likeFlag = "DELETE";
						const accountNo = $("#accountNo").val();
						const courseNo = $("#courseNo").val();
						
						$.ajax({
							url : "/myCourse/like",
							type : "POST",
							data : {
								likeFlag : likeFlag,
								accountNo : accountNo,
								courseNo : courseNo
							},
							dataType : "JSON",
							success : function(data) {
								if (data.resultCode == 200) {
									Swal.fire({
										icon: "success",
										text: data.resultMsg,
										confirmButtonText: "확인"
									}).then((result) => {
										if (result.isConfirmed) {
											location.href = "<%= request.getContextPath() %>/course/detail?no=" + courseNo;							    
										}
									});
								} else {
									Swal.fire({ icon: "error", text: data.resultMsg});
								}
							},
							error : function() {
								Swal.fire({ icon: "error", text: "찜 목록에서 제거 중 오류가 발생했습니다."});
							}
						});
					}
				});
			});
			
			$("#enrollOpen").on("click", (event) => {
				event.preventDefault();
				
				$("#enrollDiv").css("display", "block");
			});
			
			$("#enrollBtn").on("click", (event) => {
				Swal.fire({
					text: "수강을 신청하시겠습니까?",
					icon: "question",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "신청",
					cancelButtonText: "취소"
				}).then((result) => {
					if (result.isConfirmed) {
						const enrollFlag = "ADD";
						const courseNo = $("#courseNo").val();
						const petNo = $("#selectPetForEnroll").val();
						
						$.ajax({
							url : "/myCourse/enroll",
							type : "POST",
							data : {
								enrollFlag : enrollFlag,
								courseNo : courseNo,
								petNo : petNo
							},
							dataType : "JSON",
							success : function(data) {
								if (data.resultCode == 200) {
									Swal.fire({
										icon: "success",
										text: data.resultMsg,
										confirmButtonText: "확인"
									}).then((result) => {
										if (result.isConfirmed) {
											location.href = "<%= request.getContextPath() %>/course/detail?no=" + courseNo;							    
										}
									});
								} else {
									Swal.fire({ icon: "error", text: data.resultMsg});
								}
							},
							error : function() {
								Swal.fire({ icon: "error", text: "수강 신청 중 오류가 발생했습니다."});
							}
						});
					}
				});
			});
			
		});
	</script>
</body>

</html>