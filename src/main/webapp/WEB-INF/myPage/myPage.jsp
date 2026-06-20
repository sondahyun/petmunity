<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>myPage</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page wide">
	<h1 class="pm-page-title">마이페이지</h1>
	<p class="pm-page-sub">내 프로필과 반려동물 정보를 확인하세요.</p>
	<div style="display:flex; gap:28px; align-items:flex-start; flex-wrap:wrap;">
		<div style="flex:0 0 200px; max-width:200px;">
			<%@include file="/WEB-INF/myPage/myPage_info_mini.jsp"%>
		</div>
		<div style="flex:1; min-width:280px;">
			<%@include file="/WEB-INF/myPage/myPage_info.jsp"%>
		</div>
	</div>
</div>
</body>
</html>