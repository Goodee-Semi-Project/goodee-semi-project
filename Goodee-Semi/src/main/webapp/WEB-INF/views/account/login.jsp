<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인</title>

  <%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>

<body class="login-page">
  <%@ include file="/WEB-INF/views/include/header.jsp" %>
  
  <section class="login py-5 border-top-1">
	  <div class="container">
	    <div class="row justify-content-center">
	      <div class="col-lg-5 col-md-8 align-item-center">
	        <div class="border">
	          <h3 class="bg-gray p-4">LOG IN</h3>
	          <form id="accountLoginFrm">
	            <fieldset class="p-4">
	              <input class="form-control mb-3" type="text" id="accountId" name="accountId" placeholder="아이디" required>
	              <input class="form-control mb-3" type="password" id="accountPw" name="accountPw" placeholder="비밀번호" required>
	              <div class="loggedin-forgot" style="display: flex; justify-content: space-between; align-items: center; height: 30px;">
	              	<div>
		              	<label for="remember" class="pt-3 pb-2"><input type="checkbox" id="remember" name="remember" style="vertical-align: -1px;"> 아이디 기억하기</label>	              	
	              	</div>
	              	<div>
	              		<a href="<c:url value='/account/findId'/>" style="font-size: 14px; color: #848484;">아이디 찾기</a>
	              		<span style="font-size: 14px; color: #848484;"> | </span>
	              		<a href="<c:url value='/account/findPw'/>" style="font-size: 14px; color: #848484;">비밀번호 찾기</a>
	              	</div>
	              </div>
	              <button type="submit" class="btn btn-primary font-weight-bold col-12 mt-4" style="font-size: 16px;">로그인</button>
	              <button type="button" class="btn btn-outline-secondary font-weight-bold col-12 mt-1" style="font-size: 16px;" onclick="location.href='<c:url value='/account/register'/>'">회원가입</button>
	            </fieldset>
	          </form>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  <!-- ✅ jQuery 코드 실행은 페이지 맨 아래 -->
  <script>
    $("#accountLoginFrm").submit(function(e){
      e.preventDefault();

      const accountId = $("#accountId").val();
      const accountPw = $("#accountPw").val();

      if(!accountId){
        alert('아이디를 입력하세요.');
      } else if(!accountPw){
        alert('비밀번호를 입력하세요.');
      } else {
        $.ajax({
          url : "/account/login",
          type : "post",
          data : {
            accountId : accountId,
            accountPw : accountPw
          },
          dataType : 'json',
          success : function(data){
            if (data.res_code === "200") {
            	  alert(data.res_msg);
            	  location.href = "<%= request.getContextPath() %>/";
            	} else {
            	  alert(data.res_msg); // 실패 메시지 or 탈퇴 안내
            	}
          }
        });
      }
    });
  </script>
</body>
</html>
