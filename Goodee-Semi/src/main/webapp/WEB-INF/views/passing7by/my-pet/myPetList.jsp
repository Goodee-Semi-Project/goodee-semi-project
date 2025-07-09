<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
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
				<h4>OOO 님</h4>
				<div>
					<p>회원</p>
					<p>0000.00.00 가입</p>
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
				<c:forEach var="pet" items="${list }">
					<li>
						<img src="https://picsum.photos/150" alt="">
						<div class="pet-detail">
							<p>${pet.petName }</p>
							<p>${pet.petAge }살 / ${pet.petGender }</p>
							<p>${pet.petBreed }</p>
						</div>
						<div>
							<button class="btn-update">수정</button>
							<button class="btn-delete">삭제</button>
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