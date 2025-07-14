<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<%@ include file="/WEB-INF/views/notice/noticeHeader.jsp" %>

<section class="notice-write-container">
    <h2>공지사항 등록</h2>

    <form id="createNoticeFrm">
      <div class="form-group">
      <input type="hidden" name="noticeWriter" value="${loginAccount.accountNo }">
        <label for="noticeTitle">제목</label>
        <input type="text" id="noticeTitle" name="noticeTitle" required />
      </div>

      <div class="form-group">
        <label for="noticeContent">내용</label>
        <textarea id="noticeContent" name="noticeContent" rows="10" required></textarea>
      </div>

      <div class="form-group">
        <label for="noticeFile">첨부 파일</label>
        <input type="file" id="noticeFile" name="upfile" />
      </div>

      <div class="btn-group">
        <button type="submit">등록</button>
        <button type="button" onclick="history.back();">취소</button>
      </div>
    </form>
  </section>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
<script>
$(function(){
    $("#createNoticeFrm").submit(function(e){
        e.preventDefault();
        
        const form = document.getElementById("createNoticeFrm");
        const formData = new FormData(form);
        
        $.ajax({
            url : "/notice/write",
            type : "post",
            data : formData,
            enctype : "multipart/form-data",
            contentType : false,
            processData : false,
            cache : false,
            dataType : "json",
            success : function(res){
                alert(res.res_msg);
                if(res.res_code == 200){
                    location.href = "<%=request.getContextPath()%>/list";
                }
            }
        });
    });
});
</script>

</body>
</html>