<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- JQuery CDN -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script defer src="<c:url value='/js/my-pet/myPetList.js'/>"></script>
	<title>내 반려견</title>
</head>
<body>
	<!-- header -->
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<!-- 중앙정렬용 container -->
	<div id="container">
		<aside>
			<div id="profile">
				<img src="https://picsum.photos/150" alt="프로필 이미지">
				<h4>${loginAccount.name } 님</h4>
				<div>
					<p>${authurName }</p>
					<p>${regDate } 가입</p>
				</div>
			</div>
			<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>
		</aside>
		
		<section>
			<div id="title">
				<h3>등록된 반려견</h3>
				<button><span>+</span> 추가 등록</button>
			</div>
			<hr>

			<ul id="pet-list">
				<c:forEach var="pet" items="${list }" varStatus="status">
					<li>
						<img src="https://picsum.photos/150" alt="">
						<div class="pet-detail" id="pet-detail-${status.index }">
							<input type="text" class="pet-name" value="${pet.petName }" disabled>
							<div>
								<input type="text" class="pet-age" value="${pet.petAge }" disabled>
								<p>살 / <p>
								<input type="text" class="pet-gender" value="${pet.petGender }" disabled>
							</div>
							<input type="text" class="pet-breed" value="${pet.petBreed }" disabled>
							<input type="hidden" class="pet-no" value="${pet.petNo }">
							<input type="hidden" class="account-no" value="${pet.accountNo }">
						</div>
						<div class="pet-btn" id="pet-btn-${status.index }">
							<button class="pet-btn-up" id="pet-btn-up-${status.index }">수정</button>
							<button class="pet-btn-del" id="pet-btn-del-${status.index }">삭제</button>
						</div>
						<hr>
					</li>
				</c:forEach>
			</ul>

			<c:if test="${not empty list }">
				<div id="pagination">
					<c:if test="${paging.prev }">
						<a href="<c:url value='/myPet/list?nowPage=${paging.pageBarStart-1 }'/>">⬅️</a>
					</c:if>
					<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
						<a href="<c:url value='/myPet/list?nowPage=${i }'/>">${i }</a>
					</c:forEach>
					<c:if test="${paging.next }">
						<a href="<c:url value='/myPet/list?nowPage=${paging.pageBarEnd+1 }'/>">➡️</a>
					</c:if>
				</div>
			</c:if>

		</section>
	</div>
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>