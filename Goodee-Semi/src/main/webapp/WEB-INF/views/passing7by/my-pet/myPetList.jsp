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
				<li>
					<img src="https://picsum.photos/150" alt="">
					<div class="pet-detail">
						<p>반려견 이름</p>
						<p>나이 / 성별</p>
						<p>품종</p>
					</div>
					<div>
						<button class="btn-update">수정</button>
						<button class="btn-delete">삭제</button>
					</div>
					<hr>
				</li>
			</ul>

			<div id="pagination">
				<a href="">⬅️</a>
				<a href="">1</a>
				<a href="">➡️</a>
			</div>
		</section>
	</div>
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>