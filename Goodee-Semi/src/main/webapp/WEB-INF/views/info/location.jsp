<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찾아오시는 길</title>

<script	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAriTdVIXQDpo48t7KVpxkw2H6sXMOuJt4&callback=initMap" async defer></script>

<script>
	  function initMap() {
	    const geocoder = new google.maps.Geocoder();
	    const address = "서울 금천구 가산디지털2로 95";
	
	    // 지도의 기본 중심
	    const defaultCenter = { lat: 37.5665, lng: 126.9780 };
	
	    const map = new google.maps.Map(document.getElementById("map"), {
	      zoom: 15,
	      center: defaultCenter
	    });
	
	    geocoder.geocode({ address: address }, (results, status) => {
	      if (status === "OK") {
	        map.setCenter(results[0].geometry.location);
	
	        const marker = new google.maps.Marker({
	          map: map,
	          position: results[0].geometry.location
	        });
	      } else {
	        alert("주소를 찾을 수 없습니다: " + status);
	      }
	    });
	  }
	</script>
	
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	
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
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	
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
					<h3>찾아오시는 길</h3>
				</div>
			</div>
		</div>
	</section>

	<section class="section" style="padding : 50px 100px 0 100px">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="about-img text-center" style="border: 1px solid gray; border-radius: 5px; padding: 5px;">
						<img src="<c:url value='/static/images/about/location.png'/>"  class="img-fluid w-100 rounded" alt="건물">
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="section">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 pt-5 pt-lg-0" style="display : flex; align-items : center;">
					<div class="about-content">
						<h2 class="font-weight-bold" style="font-size : 35px">찾아오시는 길</h2>
						<p>
							<span class="font-weight-bold text-dark">주소 : </span> 
							<span>서울 금천구	가산디지털2로 95</span>
						</p>
						<h2 class="font-weight-bold" style="font-size : 35x">교통편</h2>
						<p>
							<span class="font-weight-bold text-dark">지하철 : </span>
							<span>1,7호선 가산디지털단지역 8번 출구 도보 499m</span> 
							<br> 
							<span class="font-weight-bold text-dark">버스 : </span> 
							<span>21, 503, 504, 571, 652, 5536, 5714 도보 3분거리</span>
							<br>
							<span class="font-weight-bold text-dark">주차 : </span>
							<span>고객 전용 주차장운영</span>
						</p>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="about-img" style="border: 1px solid gray; border-radius: 5px; padding: 5px;">
						<div id="map" style="width: 100%; height: 400px;"></div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		$(() => {
			setTimeout(() => {
				$("#homeDog1").css("opacity", "1");
			}, 1000);
			
			setTimeout(() => {
				$("#homeDog2").css("opacity", "1");
			}, 2000);
			
			setTimeout(() => {
				$("#homeDog3").css("opacity", "1");
			}, 3000);
		})
	</script>
</body>
</html>