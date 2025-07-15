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
				<div class="advance-search">
					<div class="container">
						<div class="row justify-content-center">
							<div class="col-lg-12 col-md-12 align-content-center">
								<form>
									<div class="form-row">
										<div class="form-group col-3">
											<input type="text" class="form-control my-2" id="inputtext4" placeholder="교육과정">
											<input type="checkbox" id="" value="onlyAvailable"> 수강 가능 과정만 검색하기
										</div>
										
										<div class="form-group col-3">
											<input type="text" class="form-control my-2" id="inputLocation4" placeholder="훈련사">
										</div>
										
										<div class="form-group col-2">
											<input type="text" class="form-control my-2" id="inputLocation4" placeholder="태그">
										</div>
										
										<div class="form-group col-2">
											<button type="submit" class="btn btn-primary active mt-1 w-100">검색</button>
										</div>
										
										<div class="form-group col-2">
											<button type="submit" class="btn btn-primary active mt-1 w-100">전체 조회</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
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
					<div style="display: flex; justify-content: center;">
						<img class="card-img-top img-fluid" style="width: 200px; height: 200px; margin-right: 50px; border: 3px solid white" src="<c:url value='/filePath?no=${ course.thumbAttach.attachNo }' />" alt="img">
						<div class="product-meta" style="display: flex; flex-direction: column; justify-content: center;">
							<h1 class="product-title" style="font-size: 48px;">${ course.title }</h1>
							<ul class="list-inline">
								<li class="list-inline-item"><i class="fa fa-user-o"></i> 훈련사 ${ course.name }</li>
								<li class="list-inline-item"><i class="fa fa-tags"></i> 태그 </li>
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
								<p style="font-size: 20px;">${ course.object }</p>
								<img class="card-img-top img-fluid" style="width: 800px; height: 450px; border: 3px solid white" src="<c:url value='/filePath?no=${ course.inputAttach.attachNo }' />" alt="img">
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
						<c:choose>
							<c:when test="${ sessionScope.loginAccount.author eq 1 }">
								<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="profile">
								<h4><a href="<c:url value='/myInfo' />">${ sessionScope.loginAccount.name } 님</a></h4>
								<div class="d-grid gap-2">
									<a href="#" class="btn btn-light btn-outline-dark col-12 px-5 my-1">회원 관리</a>
									<a href="#" class="btn btn-light btn-outline-dark col-12 px-5 my-1">수강신청 관리</a>
									<a href="#" class="btn btn-light btn-outline-dark col-12 px-5 my-1">사전학습 관리</a>
									<a href="#" class="btn btn-light btn-outline-dark col-12 px-5 my-1">일정 관리</a>
									<a href="#" class="btn btn-light btn-outline-dark col-12 px-5 my-1">과제 관리</a>
								</div>
							</c:when>
							
							<c:when test="${ sessionScope.loginAccount.author eq 2 }">
								<img class="rounded-circle img-fluid mb-5 px-5" src="<c:url value='/filePath?no=${ sessionScope.loginAccount.profileAttach.attachNo }' />" alt="profile">
								<h4><a href="<c:url value='/myInfo' />">${ sessionScope.loginAccount.name } 님</a></h4>
								<p class="member-time">가입일: ${ sessionScope.loginAccount.reg_date }</p>
								<div class="d-grid gap-2">
									<a href="#" class="btn btn-primary col-12 px-5 my-1">수강신청</a>
									<a href="#" class="btn btn-light btn-outline-dark col-12 px-5 my-1">수강신청 취소</a>
									<a href="#" class="btn btn-danger col-12 px-5 my-1">찜하기</a>
									<a href="#" class="btn btn-light btn-outline-dark col-12 px-5 my-1">찜하기 취소</a>
									<a href="#" class="btn btn-light btn-outline-dark col-12 px-5 my-1">사전학습</a>
									<a href="#" class="btn btn-light btn-outline-dark col-12 px-5 my-1">일정표</a>
									<a href="#" class="btn btn-light btn-outline-dark col-12 px-5 my-1">과제</a>
								</div>
							</c:when>
							
							<c:otherwise>
								<div class="d-grid gap-2">
									<a href="#" class="btn btn-light btn-outline-dark col-12 px-5 my-1">로그인</a>
									<a href="#" class="btn btn-success col-12 px-5 my-1">회원가입</a>
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
</body>

</html>