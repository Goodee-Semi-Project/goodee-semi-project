<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div style="height: 180px;"></div>
<footer class="footer-bottom" style="position: absolute; width: 100%; height: 180px; bottom: 0%;">
  <!-- Container Start -->
  <div class="container">
    <div class="row">
      <div class="col-8 text-left mb-3 mb-lg-0">
        <!-- Copyright -->
        <div class="copyright">
        	<p>주식회사 Project Name | 대표 송근영 | 전화번호: 010-1234-5678 | 이메일: songky1234@example.com</p>
					<p>사업자번호: 123-45-67890 | 통신판매신고번호: 제2025-서울금천-12345</p>
					<p>주소: 서울특별시 금천구 가산디지털2로 95 (가산동) KM타워 3층</p>
        	<br>
          <p>Copyright &copy; <script>
              var CurrentYear = new Date().getFullYear()
              document.write(CurrentYear)
            </script> | 이 정보는 세미 프로젝트용으로 생성한 임의의 정보이며 실제 정보가 아닙니다.</p>
        </div>
      </div>
      <div class="col-4">
        <!-- Social Icons -->
        <ul class="social-media-icons text-right align-top">
          <li><a href="https://www.facebook.com/themefisher">이용약관</a></li>
          <li><a href="https://www.twitter.com/themefisher">개인정보처리방침</a></li>
          <li><a href="https://www.pinterest.com/themefisher">도움말</a></li>
        </ul>
      </div>
    </div>
  </div>
  <!-- Container End -->
  <!-- To Top -->
  <div class="scroll-top-to">
    <i class="fa fa-angle-up"></i>
  </div>
</footer>
</div>

<!-- Plugins -->
<script src="/static/plugins/jquery/jquery.min.js"></script>
<script src="/static/plugins/bootstrap/popper.min.js"></script>
<script src="/static/plugins/bootstrap/bootstrap.min.js"></script>
<script src="/static/plugins/bootstrap/bootstrap-slider.js"></script>
<script src="/static/plugins/tether/js/tether.min.js"></script>
<script src="/static/plugins/raty/jquery.raty-fa.js"></script>
<script src="/static/plugins/slick/slick.min.js"></script>
<script src="/static/plugins/jquery-nice-select/js/jquery.nice-select.min.js"></script>

<script src="/static/js/script.js"></script>
<script>
	function logout(e){
		e.preventDefault();
		
		if(confirm("로그아웃 하시겠습니까?")){
			location.href = "<c:url value='/account/logout' />";
		}
	}

	$(() => {
		
		$("#searchCourseForm").submit((event) => {
			event.preventDefault();
			
			const keyTitle = $("#searchByTitle").val();
			const keyName = $("#searchByTrainer").val();
			const keyTag = $("#searchByTag").val();
			
			if ((keyTitle != "" || keyName != "") && keyTag != "") alert("태그는 다른 조건과 함께 검색할 수 없습니다.");
			else {
				const form = document.getElementById("searchCourseForm");
				
				form.action = "/home";
				form.method = "POST";
				form.submit();
			}
		});
		
		$("#searchReset").on("click", (event) => {
			event.preventDefault();
			
			if (confirm("검색을 초기화 하시겠습니까?")) {
				location.href = "<%= request.getContextPath() %>/home";
			}
		});
	});
</script>