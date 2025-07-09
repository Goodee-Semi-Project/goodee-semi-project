<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <%@ include file="/WEB-INF/views/include/header.jsp" %>
</head>
<body class="login-page">
  <div class="login-wrap container">
    <div class="login-box">
      <h2>LOG IN</h2>
      <form id="memberLoginFrm" action="<c:url value='/member/login'/>" method="post">
        <div class="form-group">
          <input type="text" id="memberId" placeholder="아이디">
        </div>
        <div class="form-group">
          <input type="password" id="memberPw" placeholder="비밀번호">
        </div>
        <div class="form-options">
          <label><input type="checkbox" name="remember"> 아이디 기억하기</label>
          <a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a>
        </div>
        <button type="submit" class="btn btn-block">로그인</button>
        <button type="button" class="btn btn-block btn-outline" onclick="location.href='<c:url value='/member/register'/>'">
          회원가입
        </button>
      </form>
    </div>
    <div class="login-image">
      <img src="<c:url value='/resources/images/pug.png'/>" alt="강아지">
    </div>
  </div>

  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>

<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous">
  
  ${"#memberLoginFrm"}.submit(function(e){
	 e.preventDefault();
	 
	 const memberId = ${"#memberId"}.val();
	 const memberPw = ${"#memberPw"}.val();
	 
	 if(!memberId){
		 alert('아이디를 입력하세요.');
	 }else if(!memberPw){
		 alert('비밀번호를 입력하세요.');
	 }else{
		 $.ajax({
			 url : "/memberLogin",
			 type : "post",
			 data : {
				 memberId : memberId,
				 memberPw : memberPw
			 },
			 dataType : 'json',
			 success : function(result){
				 
			 } 
		 });
	 }
	 
  });
 </script>
</body>
</html>