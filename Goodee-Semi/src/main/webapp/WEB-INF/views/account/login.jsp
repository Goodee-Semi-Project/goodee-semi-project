<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인</title>

  <!-- ✅ jQuery는 head 또는 body 끝에 로드 -->
  <script src="https://code.jquery.com/jquery-3.7.1.js"
          integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
          crossorigin="anonymous"></script>

  <%@ include file="/WEB-INF/views/include/header.jsp" %>
</head>

<body class="login-page">
  <div class="login-wrap container">
    <div class="login-box">
      <h2>LOG IN</h2>
      <form id="accountLoginFrm">
        <div class="form-group">
          <input type="text" id="accountId" name="accountId" placeholder="아이디">
        </div>
        <div class="form-group">
          <input type="password" id="accountPw" name="accountPw" placeholder="비밀번호">
        </div>
        <div class="form-options">
          <label><input type="checkbox" name="remember"> 아이디 기억하기</label>
          <a href="<c:url value='/account/findId'/>">아이디 찾기</a> | <a href="<c:url value='/account/findPw'/>">비밀번호 찾기</a>
        </div>
        <button type="submit" class="btn btn-block">로그인</button>
        <button type="button" class="btn btn-block btn-outline"
                onclick="location.href='<c:url value='/account/register'/>'">
          회원가입
        </button>
      </form>
    </div>
    <div class="login-image">
      <%-- <img src="<c:url value='/resources/images/pug.png'/>" alt="강아지"> --%>
    </div>
  </div>

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
            alert(data.res_msg);
            
            if(data.res_code == 200){
              location.href = "<%= request.getContextPath() %>/";
            }
          }
        });
      }
    });
  </script>
</body>
</html>
