<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<div class="modal fade show" style="background-color: rgba(0, 0, 0, 0.1);" id="loading" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" role="dialog">
	<div class="modal-dialog modal-dialog-centered">
		<div class="w-100 d-flex justify-content-center">
			<div class="spinner-border text-primary" role="status">
				<span class="visually-hidden d-none">Loading...</span>
			</div>
		</div>
	</div>
</div>
</html>

<%-- 부트스트랩 d-block/d-none으로 켜고 끄시면 됩니다. --%>
<%-- @include file="/WEB-INF/views/include/loading.jsp" --%>
<%-- $('#loading').addClass('d-block'); --%>