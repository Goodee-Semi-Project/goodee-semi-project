<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 센터</title>

<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	
	<section class="hero-area bg-1 text-left overly" style="position: relative;">
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
	
	<div id="homeDog1" style="position: absolute; top: 35%; right: 30%; border-radius: 10px; overflow: hidden; z-index: 10; transform: rotate(-20deg); opacity: 0; transition: 0.5s;">
		<img width="200" height="200" src="/static/images/home/homeDog1.jpg" style="border: 7px solid white;" alt="dog" />
	</div>
	
	<div id="homeDog2" style="position: absolute; top: 15%; right: 25%; border-radius: 10px; overflow: hidden; z-index: 11; opacity: 0; transition: 0.5s;">
		<img width="200" height="200" src="/static/images/home/homeDog2.jpg" style="border: 7px solid white;" alt="dog" />
	</div>
	
	<div id="homeDog3" style="position: absolute; top: 35%; right: 20%; border-radius: 10px; overflow: hidden; z-index: 12; transform: rotate(20deg); opacity: 0; transition: 0.5s;">
		<img width="200" height="200" src="/static/images/home/homeDog3.jpg" style="border: 7px solid white;" alt="dog" />
	</div>
	<!-- Container End -->
	</section>
	
	<section class="page-title">
		<div class="container">
			<div class="row">
				<div class="col-md-8 offset-md-2 text-center">
					<h3>고객 센터</h3>
				</div>
			</div>
		</div>
	</section>
	
	<section class="section">
	    <div class="container">
	        <div class="row">
	            <div class="col-md-6">
	                <div class="contact-us-content p-4">
	                    <h1 class="pt-3">무엇을 도와드릴까요?</h1>
	                    <p class="pt-3 pb-5">처음 방문하셨나요? 혹은 이용 중 불편을 겪고 계신가요? 
	                    어떤 상황이든, 이곳에서 자유롭게 말씀해 주세요. 
	                    이름과 이메일, 문의 내용을 정확히 입력해주시면 보다 빠른 안내가 가능합니다.
	                    교육 과정, 예약 일정, 반려견 등록, 훈련사 상담 등 모든 문의를 환영하며,
	                    담당자가 확인 후 신속하게 답변드리겠습니다.
	                    여러분의 편안하고 즐거운 이용을 위해 항상 귀 기울이겠습니다.</p>
	                </div>
	            </div>
	            <div class="col-md-6">
                    <form action="#">
                        <fieldset class="p-4">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-lg-6 py-2">
                                        <input type="text" placeholder="이름 *" class="form-control" required>
                                    </div>
                                    <div class="col-lg-6 pt-2">
                                        <input type="email" placeholder="이메일 *" class="form-control" required>
                                    </div>
                                </div>
                            </div>
                            <select name="" id="" class="form-control w-100">
                                <option value="1">카테고리 선택</option>
                                <option value="1">교육과정</option>
                                <option value="1">일정</option>
                                <option value="1">훈련사</option>
                                <option value="1">반려견</option>
                            </select>
                            <textarea name="message" id=""  placeholder="메세지 *" class="border w-100 p-3 mt-3 mt-lg-4"></textarea>
                            <div class="btn-grounp">
                                <button type="submit" class="btn btn-primary mt-2 float-right">보내기</button>
                            </div>
                        </fieldset>
                    </form>
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