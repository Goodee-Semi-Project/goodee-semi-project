<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소개</title>

<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<section class="page-title">
		<div class="container">
			<div class="row">
				<div class="col-md-8 offset-md-2 text-center">
					<h3>훈련소 소개</h3>
				</div>
			</div>
		</div>
	</section>

	<section class="section">
	  <div class="container">
	    <div class="row">
	      <div class="col-lg-12">
	        <div class="about-img text-center">
	          <img src="<c:url value='/static/images/about/intro.jpg'/>" class="img-fluid w-100 rounded" alt="">
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
	
	<div class="text-center">
		<h1>ㅁㅁㅁ 훈련소</h1>
	</div>
	
	<section class="section">
	  <div class="container">
	    <div class="row">
	      <div class="col-lg-12 pt-5 pt-lg-0">
	        <div class="about-content">
	          <h3 class="font-weight-bold">🐾 체계적이고 맞춤화된 교육 프로그램</h3>
	          <p>저희 훈련소에서는 오랜 경험과 전문성을 바탕으로, 강아지의 성격과 보호자의 생활 패턴을 고려한 맞춤형 교육 프로그램을 제공합니다.
	          기본적인 복종 훈련부터 사회화 교육, 문제 행동 교정에 이르기까지, 
	          각 반려견이 건강하고 안정적인 성장을 이룰 수 있도록 체계적인 방법으로 지도합니다. 
	          훈련 과정은 단순히 명령을 따르게 하는 것을 목표로 하지 않습니다.
	          강아지가 스스로 배우고 성장하며 보호자와 더욱 깊은 신뢰를 쌓아가는 과정을 중요하게 생각합니다.
	          그래서 보호자님도 함께 참여하며 배울 수 있는 동반 교육 방식을 지향합니다.</p>
	          <h3 class="font-weight-bold">🐶반려견과 보호자가 함께하는 행복한 순간</h3>
	          <p>깨끗하고 안전하게 관리되는 훈련 공간과 풍부한 경험을 지닌 전문 훈련사들이 언제나 여러분과 함께합니다.
	          반려견의 밝은 웃음과 보호자님의 든든한 미소가 어우러지는 순간이 저희의 가장 큰 보람입니다.
	          어떤 고민이든 편하게 문을 두드려 주세요.
	          여러분과 반려견이 더 행복한 내일을 만들어갈 수 있도록 늘 곁에서 함께하겠습니다.</p>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>

	<section class="mb-5">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div
						class="heading text-center text-capitalize font-weight-bold py-5">
						<h2>훈련사 소개</h2>
					</div>
				</div>
				<div class="col-lg-3 col-sm-6">
					<div class="card my-3 my-lg-0">
					<c:choose>
						<c:when test="${not empty accountList[0].profileAttach.attachNo}">
							<img class="card-img-top" src="<c:url value='/filePath?no=${accountList[0].profileAttach.attachNo}'/>"
							class="img-fluid w-100" alt="Card image cap">
						</c:when>
						<c:otherwise>
							<img class="card-img-top" src="<c:url value='/static/images/user/profile.png'/>"
							class="img-fluid w-100" alt="Card image cap">
						</c:otherwise>
					</c:choose>
						<div class="card-body bg-gray text-center" style="padding : 1.25rem 1.25rem 0 1.25rem;">
							<h5 class="card-title" style="margin : 0;">${accountList[0].name}</h5>
						</div>
						<div class="card-body bg-gray text-center">
							<p>반려견과 보호자가 함께 행복하게 살아가기 위한 길을 안내합니다. 
							따뜻한 마음으로 성격과 필요를 이해하며 맞춤형 훈련을 진행합니다. 
							즐겁고 긍정적인 방법으로 반려견의 변화를 이끌겠습니다.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-sm-6">
					<div class="card my-3 my-lg-0">
						<c:choose>
							<c:when test="${not empty accountList[1].profileAttach.attachNo}">
								<img class="card-img-top" src="<c:url value='/filePath?no=${accountList[1].profileAttach.attachNo}'/>"
								class="img-fluid w-100" alt="Card image cap">
							</c:when>
							<c:otherwise>
								<img class="card-img-top" src="<c:url value='/static/images/user/profile.png'/>"
								class="img-fluid w-100" alt="Card image cap">
							</c:otherwise>
						</c:choose>
						<div class="card-body bg-gray text-center" style="padding : 1.25rem 1.25rem 0 1.25rem;">
							<h5 class="card-title" style="margin : 0;">${accountList[1].name}</h5>
						</div>
						<div class="card-body bg-gray text-center">
							<p>체계적이고 과학적인 교육 방식을 바탕으로 반려견의 사회성 발달과 올바른 습관 형성을 돕고 있습니다. 
							보호자님과 긴밀히 소통하며, 반려견이 편안하게 배우고 즐길 수 있는 환경을 만들어갑니다.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-sm-6">
					<div class="card my-3 my-lg-0">
						<c:choose>
							<c:when test="${not empty accountList[2].profileAttach.attachNo}">
								<img class="card-img-top" src="<c:url value='/filePath?no=${accountList[2].profileAttach.attachNo}'/>"
								class="img-fluid w-100" alt="Card image cap">
							</c:when>
							<c:otherwise>
								<img class="card-img-top" src="<c:url value='/static/images/user/profile.png'/>"
								class="img-fluid w-100" alt="Card image cap">
							</c:otherwise>
						</c:choose>
						<div class="card-body bg-gray text-center" style="padding : 1.25rem 1.25rem 0 1.25rem;">
							<h5 class="card-title" style="margin : 0;">${accountList[2].name}</h5>
						</div>
						<div class="card-body bg-gray text-center">
							<p>반려견의 마음을 먼저 이해하고, 서로의 신뢰를 쌓아가며 교육합니다. 
							작은 성취도 소중히 여기며 보호자와 함께 기쁨을 나누고자 합니다. 
							즐거운 훈련으로 일상이 더 행복해지도록 노력하겠습니다.</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-sm-6">
					<div class="card my-3 my-lg-0">
						<c:choose>
							<c:when test="${not empty accountList[3].profileAttach.attachNo}">
								<img class="card-img-top" src="<c:url value='/filePath?no=${accountList[3].profileAttach.attachNo}'/>"
								class="img-fluid w-100" alt="Card image cap">
							</c:when>
							<c:otherwise>
								<img class="card-img-top" src="<c:url value='/static/images/user/profile.png'/>"
								class="img-fluid w-100" alt="Card image cap">
							</c:otherwise>
						</c:choose>
						<div class="card-body bg-gray text-center" style="padding : 1.25rem 1.25rem 0 1.25rem;">
							<h5 class="card-title" style="margin : 0;">${accountList[3].name}</h5>
						</div>
						<div class="card-body bg-gray text-center">
							<p>다양한 경험을 통해 얻은 노하우로 문제 행동 교정과 사회화 교육을 전문적으로 진행합니다. 
							반려견이 긍정적인 에너지로 성장할 수 있도록 최선을 다하며, 보호자님의 든든한 동반자가 되겠습니다.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<section class="section bg-gray">
	  <div class="container">
	    <div class="row">
	      <div class="col-lg-4 col-sm-6 my-lg-0 my-4">
	        <div class="counter-content text-center bg-light py-4 rounded">
	          <i class="fa fa-smile-o d-block"></i>
	          <span class="counter my-2 d-block" data-count="${totalAccountNum }">0</span>
	          <h5>가입 회원 수</h5>
	          </script>
	        </div>
	      </div>
	      <div class="col-lg-4 col-sm-6 my-lg-0 my-4">
	        <div class="counter-content text-center bg-light py-4 rounded">
	          <i class="fa fa-user-o d-block"></i>
	          <span class="counter my-2 d-block" data-count="${totalPetNum}">0</span>
	          <h5>등록된 반려견</h5>
	        </div>
	      </div>
	      <div class="col-lg-4 col-sm-6 my-lg-0 my-4">
	        <div class="counter-content text-center bg-light py-4 rounded">
	          <i class="fa fa-bookmark-o d-block"></i>
	          <span class="counter my-2 d-block" data-count="${totalCourseNum}">0</span>
	          <h5>진행중인 강의</h5>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>