<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>공지사항 수정</title>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/notice/noticeHeader.jsp" %>

<section class="notice-write-container">
  <h2>공지사항 수정</h2>

  <form id="updateNoticeFrm" method="post" enctype="multipart/form-data">
    <!-- ✅ 공지번호 -->
    <input type="hidden" name="noticeNo" value="${notice.noticeNo}" />
    

    <div class="form-group">
      <label for="noticeTitle">제목</label>
      <input type="text" id="noticeTitle" name="noticeTitle" required value="${notice.noticeTitle}" />
    </div>

    <div class="form-group">
      <label for="noticeContent">내용</label>
      <textarea id="noticeContent" name="noticeContent" rows="10" required>${notice.noticeContent}</textarea>
    </div>

    <div class="form-group">
      <label for="noticeFile">첨부 파일</label>
      <input type="file" id="noticeFile" name="upfile" />
      <c:if test="${not empty attach}">
        <p>현재 파일: ${attach.originName}</p>
        <img src="<c:url value='/filePath?no=${attach.attachNo}'/>" style="max-width: 300px;">

      </c:if>
    </div>

    <div class="btn-group">
      <button type="submit">수정</button>
      <button type="button" onclick="history.back();">취소</button>
    </div>
  </form>
</section>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script>
$(function(){
  $("#updateNoticeFrm").submit(function(e){
    e.preventDefault(); // ✅ 먼저 기본 제출 막기

    if(confirm("수정하시겠습니까?")) {
      const form = document.getElementById("updateNoticeFrm");
      const formData = new FormData(form);

      $.ajax({
        url: "<%=request.getContextPath()%>/noticeUpdate",  // ✅ 수정 URL
        type: "post",
        data: formData,
        enctype: "multipart/form-data",
        contentType: false,
        processData: false,
        cache: false,
        dataType: "json",
        success: function(res) {
          alert(res.resultMsg || "수정 결과 수신");

          if (res.resultCode == "200") {
            location.href = "<%=request.getContextPath()%>/notice/list";
          }
        },
        error: function() {
          alert("서버 오류 발생");
        }
      });
    }
    // else를 따로 안 써도, confirm이 false면 그냥 아무 일도 안 하고 끝나게 됨
  });
});
</script>
</body>
</html>
