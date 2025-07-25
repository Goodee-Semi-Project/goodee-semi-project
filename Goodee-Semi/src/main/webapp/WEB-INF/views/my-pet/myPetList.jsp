<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>내 반려견</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<script defer src="<c:url value='/static/js/myPetList.js'/>"></script>
	
	<style>
		input:disabled {
			border: none;
			background-color: rgba(0, 0, 0, 0) !important;
		}
		
		.nice-select.disabled {
			border: none;
			background-color: rgba(0, 0, 0, 0) !important;
			color: #666;
		}
		
		.nice-select.disabled:after {
			border-color: rgba(0, 0, 0, 0);
		}
		
		.nice-select,
		.form-control {
			padding: .375rem .75rem;
    		height: 50px;
		}
		
		.pet-detail.col-7 {
			max-width: 52%;
		}
		
 		label {
			margin-right: 2px;
		}
		
		.col-3 {
		    max-width: 100%;
		}
		
 		.col-2 {
			margin-left: 10px;
		}
		
		/* 붓스트랩 스타일 커스터마이징 */
		div.container.mb-3 {
			display: flex; align-items: center; padding: 15px 25px; border: 1px solid white; box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2);
		}
		input.pet-img-input {
			display: none;
		}
		img.pet-img {
			padding: 5px; border: 1px solid #ced4da; object-fit: cover; border-radius: 50%;
		}
		div.pet-detail.col-7 {
			display: flex; align-items: center;
		}
		div.pet-detail.col-7 div:nth-child(1) {
			width: 60%; text-align: center;
		}
		div.pet-detail.col-7 div:nth-child(2) {
			width: 40%; margin-left: 20px; text-align: left;
		}
		input.form-control.pet-name.mb-3 {
			width: 75%; display: inline-block;
		}
		input.form-control.pet-breed {
			width: 75%; display: inline-block;
		}
		input.form-control.pet-age.mb-3 {
			width: 60%; display: inline-block;
		}
		button.pet-btn-up.btn.btn-primary.mb-3,
		button.pet-btn-del.btn.btn-danger,
		button.pet-btn-up.btn.btn-success.mb-3,
		button.pet-btn-del.btn.btn-outline-secondary,
		button.pet-btn-save.btn.btn-success {
			padding: 5px 10px !important;
		}
		div.pet-btn.col-2 {
			display: flex; flex-direction: column; justify-content: center; align-items: center
		}
	</style>
</head>
<body>
	<!-- header -->
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<!-- sideBar start -->
	<%@ include file="/WEB-INF/views/include/myPageSideBar.jsp" %>
	
	<!-- 중앙정렬용 container -->
	<div id="container">
		<section>
			<div id="title">
				<h2 class="tab-title mb-4 text-center">등록된 반려견</h2>
				<button id="add-pet-btn" data-account-no="${loginAccount.accountNo }" class="btn btn-success btn-sm mb-4" style="padding: 5px 10px;"><span>+</span> 추가 등록</button>
			</div>

			<ul id="pet-list">
				<c:choose>
					<c:when test="${not empty list }">
						<c:forEach var="pet" items="${list }" varStatus="status">
							<li>
								<div class="container mb-3">
									<div class="col-3">
										<input type="file" class="pet-img-input" name="petImg">
										<c:choose>
											<c:when test="${pet.imgFileSaveName eq null}">
												<img width="150" height="150" src="<c:url value='/static/images/user/pet_profile.png'/>" class="pet-img" alt="반려견 이미지">
											</c:when>
											<c:otherwise>
												<img width="150" height="150" src="<c:url value='/upload/pet/${pet.imgFileSaveName}'/>" class="pet-img" alt="반려견 이미지">
											</c:otherwise>
										</c:choose>
									</div>
									<div class="pet-detail col-7">
										<div>
											<label>이름: </label>
											<input type="text" class="form-control pet-name mb-3" name="petName" value="${pet.petName }" disabled>
											<br>
											<label>견종: </label>
											<input type="text" class="form-control pet-breed" name="petBreed" value="${pet.petBreed }" disabled>							
										</div>
										<div>
											<label>나이: </label>
											<input type="number" class="form-control pet-age mb-3" name="petAge" value="${pet.petAge }" disabled>
											<br>
											<label>성별: </label>
											<select class="pet-gender" name="petGender" disabled required>
												<option value="" disabled>성별</option>
												<c:choose>
													<c:when test="${pet.petGender == 77}">
														<option value="M" selected>남</option>
														<option value="F">여</option>
													</c:when>
													<c:otherwise>
														<option value="M">남</option>
														<option value="F" selected>여</option>
													</c:otherwise>
												</c:choose>
											</select>
										</div>
										<input type="hidden" class="pet-no" name="petNo" value="${pet.petNo }">
										<input type="hidden" class="account-no" name="accountNo" value="${pet.accountNo }">
									</div>
									<div class="pet-btn col-2">
										<button class="pet-btn-up btn btn-primary mb-3">수정</button>
										<button class="pet-btn-del btn btn-danger">삭제</button>
									</div>
								</div>
							</li>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<h3 id="msg">${msg }</h3>
					</c:otherwise>
				</c:choose>
			</ul>

			<c:if test="${not empty list }">
				<div id="pagination" style="text-align: center;">
					<c:if test="${paging.prev }">
						<a href="<c:url value='/myPet/list?nowPage=${paging.pageBarStart-1 }'/>" class="btn btn-outline-secondary" style="padding: 2px 5px;">⬅️</a>
					</c:if>
					<c:forEach var="i" begin="${paging.pageBarStart }" end="${paging.pageBarEnd }">
						<a href="<c:url value='/myPet/list?nowPage=${i }'/>" class="btn btn-outline-secondary" style="padding: 2px 5px;">${i }</a>
					</c:forEach>
					<c:if test="${paging.next }">
						<a href="<c:url value='/myPet/list?nowPage=${paging.pageBarEnd+1 }'/>" class="btn btn-outline-secondary" style="padding: 2px 5px;">➡️</a>
					</c:if>
				</div>
			</c:if>

		</section>
	</div>
	
	<!-- sideBar end -->
	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	
	<!-- footer -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	
	<!-- delete modal -->
	<!-- 모달 창 -->
	<div class="modal fade" id="delete-modal-box" tabindex="-1" role="dialog" aria-labelledby="delete-modal-box" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 600px;">
	    <div class="modal-content">
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center">
	        <h3 class="tab-title mb-2">반려견 정보를 삭제하시겠습니까?</h3>
	        <p>삭제한 반려견 정보는 되돌릴 수 없습니다.</p>
	        <input class="form-control mt-4" style="width: 60%; margin: 0 auto;" type="text" id="delete-input" placeholder="정보를 삭제하려면 '삭제' 입력">
	      </div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" id="delete-confirm-btn" class="btn btn-danger" style="padding: 5px 10px;">삭제</button>
	        <button type="button" class="btn btn-outline-secondary" style="padding: 5px 10px;" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달 창 종료 -->
	
</body>
</html>