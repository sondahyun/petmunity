<%@page contentType="text/html; charset=utf-8" import="model.*" import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Pet pet = (Pet)request.getAttribute("pet");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>반려동물 정보 수정</title>
<script>
function petUpdate() {
	if (form.name.value == "") { alert("이름을 입력하십시오."); form.name.focus(); return false; }
	if (form.kind.value == "") { alert("종을 입력하십시오."); form.kind.focus(); return false; }
	if (form.age.value == "") { alert("나이를 입력하십시오."); form.age.focus(); return false; }
	form.submit();
}
</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page form">
	<h1 class="pm-page-title">반려동물 정보 수정</h1>
	<p class="pm-page-sub">우리 아이의 정보를 최신 상태로 유지하세요.</p>

	<c:if test="${updateFailed}">
		<p class="pm-note" style="color:#d70015;"><c:out value="${exception.getMessage()}" /></p>
	</c:if>

	<form name="form" method="POST" action="<c:url value='/pet/update' />" enctype="multipart/form-data" class="pm-form">
		<input type="hidden" name="petId" value="${pet.petId}"/>

		<div class="pm-field">
			<label class="pm-label" for="name">이름</label>
			<input id="name" type="text" class="pm-input" name="name" value="${pet.name}">
		</div>
		<div class="pm-inline" style="gap:16px; align-items:flex-start;">
			<div class="pm-field" style="flex:1;">
				<label class="pm-label" for="kind">종</label>
				<input id="kind" type="text" class="pm-input" name="kind" value="${pet.kind}">
			</div>
			<div class="pm-field" style="flex:1;">
				<label class="pm-label" for="gender">성별</label>
				<input id="gender" type="text" class="pm-input" name="gender" value="${pet.gender}">
			</div>
			<div class="pm-field" style="flex:1;">
				<label class="pm-label" for="age">나이</label>
				<input id="age" type="text" class="pm-input" name="age" value="${pet.age}">
			</div>
		</div>
		<div class="pm-field">
			<label class="pm-label" for="health">건강상태</label>
			<input id="health" type="text" class="pm-input" name="health" value="${pet.health}">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="vaccination">예방접종 여부</label>
			<input id="vaccination" type="text" class="pm-input" name="vaccination" value="${pet.vaccination}">
		</div>
		<div class="pm-field">
			<label class="pm-label">사진</label>
			<% if (pet != null && pet.getFilename() != null) { %>
				<img class="pm-media" src="<c:url value='/image?file=${pet.filename}'/>" alt="현재 사진" style="margin:0 0 10px;">
			<% } %>
			<input type="file" class="pm-input" name="filename">
			<p class="pm-note">사진을 바꾸지 않으려면 비워두세요.</p>
		</div>
		<div class="pm-actions">
			<input class="pm-btn" type="button" value="수정 완료" onClick="petUpdate()">
			<a class="pm-btn-line" href="<c:url value='/myPage/myPage' />">취소</a>
		</div>
	</form>
</div>
</body>
</html>
