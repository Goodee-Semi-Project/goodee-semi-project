<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>내 반려견</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<script defer src="<c:url value='/static/js/myPetList.js'/>"></script>
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
				<button id="add-pet-btn" data-account-no="${loginAccount.accountNo }"><span>+</span> 추가 등록</button>
			</div>
			<hr>

			<ul id="pet-list">
				<c:forEach var="pet" items="${list }" varStatus="status">
					<li>
						<input type="file" class="pet-img-input" name="petImg" style="display: none;">
						<img src="<c:url value='/upload/pet/${pet.imgFileSaveName }'/>" class="pet-img" alt="반려견 이미지">
						<div class="pet-detail">
							<input type="text" class="pet-name" name="petName" value="${pet.petName }" disabled>
							<div>
								<input type="text" class="pet-age" name="petAge" value="${pet.petAge }" disabled>
								<p>살 / <p>
								<input type="text" class="pet-gender" name="petGender" value="${pet.petGender }" disabled>
							</div>
							<input type="text" class="pet-breed" name="petBreed" value="${pet.petBreed }" disabled>
							<input type="hidden" class="pet-no" name="petNo" value="${pet.petNo }">
							<input type="hidden" class="account-no" name="accountNo" value="${pet.accountNo }">
						</div>
						<div class="pet-btn">
							<button class="pet-btn-up">수정</button>
							<button class="pet-btn-del">삭제</button>
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
	
	<!-- delete modal -->
	<div id="delete-modal-box" style="display:none; position: fixed; top: 0; width: 100%; height: 100%; background: rgba(50, 50, 50, 0.5); justify-content: center; align-items: center;">
		<div id="delete-modal" style="background: white;">
			<p>정말 삭제하시겠습니까?</p>
			<input type="text" id="delete-input" placeholder="정보를 삭제하려면 '삭제' 입력">
			<button id="delete-confirm-btn">확인</button>
			<button id="delete-close-btn">취소</button>
		</div>
	</div>
</body>
</html>