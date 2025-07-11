<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<title>안녕하세요! ○○훈련소 입니다.</title>
	
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="Agency HTML Template">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0">
  <meta name="author" content="Themefisher">
  <meta name="generator" content="Themefisher Classified Marketplace Template v1.0">
  
  <!-- theme meta -->
  <meta name="theme-name" content="classimax" />

  <!-- favicon -->
  <link href="static/images/favicon.png" rel="shortcut icon">

  <!-- Essential stylesheets -->
  <link href="static/plugins/bootstrap/bootstrap.min.css" rel="stylesheet">
  <link href="static/plugins/bootstrap/bootstrap-slider.css" rel="stylesheet">
  <link href="static/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="static/plugins/slick/slick.css" rel="stylesheet">
  <link href="static/plugins/slick/slick-theme.css" rel="stylesheet">
  <link href="static/plugins/jquery-nice-select/css/nice-select.css" rel="stylesheet">
  
  <!-- CSS -->
  <link href="static/css/style.css" rel="stylesheet">
	
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<section class="hero-area bg-1 text-left overly">
	<!-- Container Start -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<!-- Header Contetnt -->
				<div class="content-block">
					<h1>고객과 반려견이<br>더 가까워질 수 있도록.</h1>
					<p>더 안전한 훈련, 더 정확한 행동 교정,<br>고객과 훈련사의 1:1 맞춤 관리 시스템으로<br>반려견과 함께하는 더 나은 삶을 위해 노력합니다.</p>
				</div>
				<!-- Advance Search -->
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

<section class="popular-deals section bg-gray">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="section-title">
					<h2>교육과정</h2>
				</div>
			</div>
		</div>
		<div class="row">
			<!-- offer 01 -->
			<div class="col-12">
				<div class="trending-ads-slide">
					<div class="col-4">
					
						<!-- curriculum start -->
<div class="product-item bg-light">
	<div class="card">
		<div class="thumb-content">
			<!-- <div class="price">$200</div> -->
			<a href="single.html">
				<img class="card-img-top img-fluid" src="static/images/products/products-1.jpg" alt="Card image cap">
			</a>
		</div>
		<div class="card-body">
		    <h4 class="card-title"><a href="single.html">11inch Macbook Air</a></h4>
		    <ul class="list-inline product-meta">
		    	<li class="list-inline-item">
		    		<a href="single.html"><i class="fa fa-folder-open-o"></i>Electronics</a>
		    	</li>
		    	<li class="list-inline-item">
		    		<a href="category.html"><i class="fa fa-calendar"></i>26th December</a>
		    	</li>
		    </ul>
		    <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, aliquam!</p>
		    <div class="product-ratings">
		    	<ul class="list-inline">
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item selected"><i class="fa fa-star"></i></li>
		    		<li class="list-inline-item"><i class="fa fa-star"></i></li>
		    	</ul>
		    </div>
		</div>
	</div>
</div>
						<!-- curriculum end -->
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>

</html>