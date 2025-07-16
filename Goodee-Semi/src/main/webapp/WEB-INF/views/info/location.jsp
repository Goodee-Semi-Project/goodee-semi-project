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
	
	        const infowindow = new google.maps.InfoWindow({
	          content: "<div style='font-size:14px;'>서울 금천구 가산디지털2로 95</div>"
	        });
	
	        infowindow.open(map, marker);
	      } else {
	        alert("주소를 찾을 수 없습니다: " + status);
	      }
	    });
	  }
	</script>
	
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<section class="page-title">
		<!-- Container Start -->
		<div class="container">
			<div class="row">
				<div class="col-md-8 offset-md-2 text-center">
					<!-- Title text -->
					<h3>찾아오시는 길</h3>
				</div>
			</div>
		</div>
		<!-- Container End -->
	</section>

	<section class="section">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="about-img text-center">
						<img src="<c:url value='/static/images/about/location.png'/>"
							class="img-fluid w-100 rounded" alt="">
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
						<h3 class="font-weight-bold">찾아오시는 길</h3>
						<p>
							<span class="font-weight-bold">주소 : </span> 
							<span>서울 금천구	가산디지털2로 95</span>
						</p>
						<h3 class="font-weight-bold">교통편</h3>
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
					<div class="about-img">
						<div id="map" style="width: 100%; height: 400px;"></div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<%@ include file="/WEB-INF/views/include/footer.jsp"%>


</body>
</html>