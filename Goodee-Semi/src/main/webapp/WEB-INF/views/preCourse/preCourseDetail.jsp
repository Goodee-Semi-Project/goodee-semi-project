<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사전 학습 상세</title>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/include/courseSideBar.jsp" %>

	<main>
		<h1>${ preCourse.preTitle }</h1>
		<input type="text" id="author" value="${ loginAccount.author }" hidden>
		<input type="text" id="preNo" value="${ preCourse.preNo }" hidden>
		<input type="text" id="lastTime" value="${ watchLen }" hidden>
		<c:if test="${ petNo ne -1 }">
			<input type="text" id="petNo" value="${ petNo }" hidden>
		</c:if>
			<p>[교육과정] ${ preCourse.courseTitle }</p>
		<div>
			<video class="w-100" id="preVideo" controls preload="metadata">
				학습 영상
				<source src="<c:url value='/fileStream?no=${ attach.attachNo }'/>">
			</video>
			<p class="text-right" id="videoLen">[영상 길이] ${ preCourse.videoLen }</p>
		</div>
		<div class="w-100 d-flex justify-content-between"">
			<a class="btn btn-primary px-2 py-1" href="/preCourse/list">목록</a>
			<div>
				<c:choose>
					<c:when test="${ loginAccount.author eq 1 }">
						<button class="btn btn-primary px-2 py-1" id="test" onclick="location.href='/preCourse/test?no=${ preCourse.preNo }'">퀴즈 목록</button>
					</c:when>
					<c:otherwise>
						<button class="btn btn-primary px-2 py-1" id="test" onclick="location.href='/preCourse/test?no=${ preCourse.preNo }'" <c:if test="${ preProgress.preProg ne 100 }"> disabled </c:if> >퀴즈 풀기</button>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<c:if test="${ loginAccount.author eq 1 }">
			<div class="mt-1 d-flex justify-content-end">
				<a class="btn btn-success px-2 py-1 mr-1" href="/preCourse/edit?no=${ preCourse.preNo }">수정</a>
				<button class="btn btn-danger px-2 py-1" onclick="deletePre()">삭제</button>
			</div>
		</c:if>
	</main>

<%@ include file="/WEB-INF/views/include/sideBarEnd.jsp" %>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script type="text/javascript">

if ($('#author').val() != 1) {
	$(function() {
		
		const vid = document.querySelector('#preVideo');
		let lastTime = 0;

		if ($('#lastTime').val()) {
			lastTime = $('#lastTime').val();
		}
		
		vid.onloadeddata  = function() {
			if (lastTime > 0 && confirm('이어보기')){
				vid.play();
				vid.currentTime = lastTime - 0.01;
			}
		}
		
		vid.onseeked = function() {
			if (vid.currentTime > lastTime) {
				vid.currentTime = lastTime;
			}
		}
		
		vid.onseeking = function() {
			if (vid.currentTime > lastTime) {
				vid.currentTime = lastTime;
			}
		}
		
		vid.ontimeupdate = function() {
			if (vid.currentTime > lastTime + 1) {
				vid.currentTime = lastTime;
			} else if (vid.currentTime > lastTime) {
				lastTime = vid.currentTime;
			}
		}
		
		vid.onended = function() {
			$('#test').removeAttr('disabled');
		}
		
		// TODO: beforeunload, popstate 이벤트로 시청 시간 보내기
		onbeforeunload = function(event) {
			if (lastTime < 1) {
				lastTime = $('#lastTime').val();
			}
			const preNo = $('#preNo').val();
			const videoLen = $('#videoLen').text();
			const petNo = $('#petNo').val();
			
			$.ajax({
				url : '/preCourse/detail',
				type : 'post',
				data : {
					preNo : preNo,
					videoLen : videoLen,
					watchLen : lastTime,
					petNo : petNo
				},
				dataType : 'json',
				success : function(data) {
					if (data.res_code == 500) {
						event.preventDefault();
						alert(data.res_msg);
					}
				},
				error : function() {
					saveState = false;
				}
			});
		};
			
	})
} else {
	function deletePre() {
		if (confirm('정말 삭제하시겠습니까?')) {
			const preNo = $('#preNo').val();
			const attachNo = $('#attachNo').val();
			
			$.ajax({
				url : '/preCourse/delete',
				type : 'post',
				data : {
					preNo : preNo
				},
				dataType : 'json',
				success : function(data){
					alert(data.res_msg);
					if (data.res_code == 200) {
						location.href="<%= request.getContextPath() %>/preCourse/list";
					}
				},
				error : function(data) {
					alert('요청 실패');
				},
			});
		}
	}
}
</script>
</body>
</html>