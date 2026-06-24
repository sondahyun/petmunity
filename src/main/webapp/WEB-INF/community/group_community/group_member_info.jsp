<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	UserInfo user = (UserInfo)request.getAttribute("user");
	Pet pet = (Pet)request.getAttribute("pet");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>그룹원 정보</title>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page">
	<h1 class="pm-page-title">그룹원 정보</h1>
	<p class="pm-page-sub">같은 모임에 참여한 회원의 정보입니다.</p>

	<h2 class="pm-page-title" style="font-size:20px; margin-top:24px;">회원 정보</h2>
	<table class="pm-detail">
		<tr><th>사용자 ID</th><td>${user.loginId}</td></tr>
		<tr><th>이름</th><td>${user.userNickname}</td></tr>
		<tr><th>이메일</th><td>${user.email}</td></tr>
		<tr><th>전화번호</th><td>${user.phoneNumber}</td></tr>
		<tr><th>그룹 이름</th><td>${user.joinGroup}</td></tr>
	</table>

	<h2 class="pm-page-title" style="font-size:20px; margin-top:32px;">반려동물</h2>
	<% if (pet == null) { %>
		<p class="pm-note">등록된 반려동물이 없습니다.</p>
	<% } else { %>
		<div style="margin-bottom:18px;">
			<% if (pet.getFilename() != null) { %>
				<img src="<c:url value='/image?file=${pet.filename}'/>" style="width:200px; height:200px; border-radius:14px; object-fit:cover;"/>
			<% } else { %>
				<img src="<c:url value='/images/logo_transparent.png' />" style="width:200px; height:200px; border-radius:14px; object-fit:contain; background:var(--pm-parch);"/>
			<% } %>
		</div>
		<table class="pm-detail">
			<tr><th>이름</th><td>${pet.name}</td></tr>
			<tr><th>나이</th><td>${pet.age}</td></tr>
			<tr><th>성별</th><td>${pet.gender}</td></tr>
			<tr><th>건강상태</th><td>${pet.health}</td></tr>
			<tr><th>접종여부</th><td>${pet.vaccination}</td></tr>
			<tr><th>종</th><td>${pet.kind}</td></tr>
		</table>
	<% } %>
</div>
</body>
</html>
