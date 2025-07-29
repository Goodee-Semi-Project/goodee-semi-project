<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>수강확인증</title>
	
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	
	<style>
		@media print {
	    body * {
	        visibility: hidden;
	    }
	    
	    #printableArea, #printableArea * {
	        visibility: visible;
	    }
	    
	    #printableArea {
	        position: fixed;
	        left: 25%;
	        right: 25%;
	        top: 0;
	    }
		}
	</style>
</head>

<body>
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>
	<h3 class="widget-header">
  	<%@ include file="/WEB-INF/views/include/courseInnerBar.jsp" %>
  </h3>
  
  <!-- 모달 창 -->
	<div class="modal fade" id="printModal" tabindex="-1" role="dialog" aria-labelledby="printModal" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 700px;">
	    <div class="modal-content">
	      <div class="modal-header border-bottom-0">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center">
	        <h3 class="tab-title mb-2">수강확인증 발급</h3>
	        <p>다음의 이미지 형태로 출력됩니다.</p>
	        <div class="col-12" style="background-color: gray; padding: 0; display: flex; justify-content: center;">
	        	<div style="width: 80%; margin: 15px auto;">
	        		<div id="printableArea">
	        			<div style="position: relative;">
	        				<img src="/static/images/cert/cert_enroll.png" style="width: 100%;" alt="cert_enroll">
	        				<div style="position: absolute; top: 11%; left: 28%;">
	        					<p id="printTitle" style="color: black; font-size: 18px; margin-bottom: 2px; text-align: left;"></p>
	        					<p id="printPetName" style="color: black; font-size: 18px; margin-bottom: 2px; margin-left: 90px; text-align: left;"></p>
	        					<p id="printMemberName" style="color: black; font-size: 18px; margin-bottom: 2px; margin-left: 90px; text-align: left;"></p>
										<p id="printProgress" style="color: black; font-size: 18px; margin-bottom: 2px; text-align: left;"></p>
	        				</div>
	        				<div style="position: absolute; bottom: 11%; left: 0; right: 0;">
	        					<p id="printDate" style="color: black; font-size: 15px;"></p>
	        				</div>
	        				<div style="position: absolute; bottom: 5%; right: 10%;">
	        					<p id="printTrainerName" style="color: black; font-size: 15px;"></p>
	        				</div>
	        				<div style="position: absolute; bottom: 10px; right: 5%;">
	        					<img src="/static/images/cert/sign.png" style="width: 100px; opacity: 0.5;" alt="sign">
	        				</div>
	        			</div>
	        		</div>
	        	</div>
	        </div>
	      </div>
	      <div class="modal-footer border-top-0 mb-3 mx-5 justify-content-center">
	        <button type="button" class="btn btn-primary" style="padding: 5px 10px;" onclick="printCert()">출력</button>
	        <button type="button" class="btn btn-outline-secondary" style="padding: 5px 10px;" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 모달 창 종료 -->
  
  <h3 class="tab-title mb-4 text-center">수강확인증 발급</h3>
  <c:forEach var="course" items="${ courseList }" varStatus="index">
		<div class="container my-2" style="border: 1px solid black; border-radius: 10px; overflow: hidden; padding: 0; display: flex;">
			<div class="col-4" style="padding: 0;">
			 <img style="width: 200px; height: 50px; object-fit: cover;" src="<c:url value='/filePath?no=${ course.thumbAttach.attachNo }' />" alt="img">
			</div>
			<div class="col-3" style="display: flex; align-items: center;">
				<span style="font-size: 18px;">${ course.title }</span>
			</div>
			<div class="col-2" style="display:flex; align-items:center;">
				<img class="rounded-circle" style="width: 40px; height: 40px; object-fit: cover; display: inline-block; border: 2px solid white; box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);" src="<c:url value='/filePath?no=${ course.myPetInCourse.attachNo }' />" alt="img">
		   	<span class="ml-1" style="font-size: 15px;">${ course.myPetInCourse.petName }</span>
			</div>
			<div class="col-3" style="display: flex; justify-content: flex-end; align-items: center;">
				<button type="button" class="btn btn-outline-secondary" style="height: 30px; padding: 2px 5px;" onclick="openPrintModal('${ course.title }', '${ course.myPetInCourse.petName }', '${ sessionScope.loginAccount.name }', '${ course.classData.classProg }', '${ course.name }')" >다운로드</button>
			</div>
		</div>
	</c:forEach>

	<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<script>
		$("#ctenSideLink").css("color", "#5672F9");	
	
		function openPrintModal(title, petName, memberName, prog, trainerName) {
			const date = new Date();
			const dateString = date.getFullYear() + "년 " + (date.getMonth() + 1) + "월 " + date.getDate() + "일";
			
			$("#printTitle").text(title);
			$("#printPetName").text(petName);
			$("#printMemberName").text(memberName);
			$("#printProgress").text(prog + "%");
			$("#printDate").text(dateString);
			$("#printTrainerName").text("훈련사 " + trainerName);
			
			$("#printModal").modal("show");
		}
		
		function printCert() {
			window.print();
		}
	</script>
</body>

</html>