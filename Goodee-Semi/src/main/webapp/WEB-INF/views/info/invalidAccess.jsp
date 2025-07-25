<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title></title>
</head>

<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.22.2/dist/sweetalert2.min.css" rel="stylesheet">
<body>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.22.2/dist/sweetalert2.all.min.js"></script>
<script>
	Swal.fire({
		text: "잘못된 접근입니다.",
		icon: "warning",
		confirmButtonColor: "#3085d6",
		confirmButtonText: "홈으로",
	}).then((result) => {
		if (result.isConfirmed) {
			location.href = "<%= request.getContextPath() %>/home";
		}
	});
</script>
</body>

</html>