<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>notice header</title>
	
	<!-- 인라인 style로 이미 설정되어 있던 css 속성을 수정해야 될 경우에는 !important 로 덮어씌웠음 -->
	<style type="text/css">
		.hero-area .content-block * {
			color: white !important;
			text-shadow: none !important;
		}
		
		.overly:before {
			background : rgba(0, 0, 0, 0.2) !important;
			border-radius: 0 !important;
		    top: 0 !important;
		    left: 0 !important;
		    right: 0 !important;
		}
		
		.bg-1 {
 			background: url("/static/images/home-background.jpg") !important;
 			background-size: cover !important;
 		}
	</style>
</head>
<body>
  <section class="notice-header">
    <section class="hero-area bg-1 text-left overly" style="position: relative; background-position: 0 45% !important;">
		<!-- Container Start -->
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<!-- Header Contetnt -->
					<div class="content-block">
						<h1 style="color: #0062CC; text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;">고객과 반려견이<br>더 가까워질 수 있도록.</h1>
						<p style="color: rgb(0, 0, 0, 0.7);">더 안전한 훈련, 더 정확한 행동 교정,<br>고객과 훈련사의 1:1 맞춤 관리 시스템으로<br>반려견과 함께하는 더 나은 삶을 위해 노력합니다.</p>
					</div>
				</div>
			</div>
		</div>
	<!-- Container End -->
	</section>
	
		<section class="page-title">
			<div class="container">
				<div class="row">
					<div class="col-md-8 offset-md-2 text-center">
						<h3>공지사항</h3>
					</div>
				</div>
			</div>
		</section>
  </section>
</body>
</html>