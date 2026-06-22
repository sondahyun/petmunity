<%@page contentType="text/html; charset=utf-8" import="model.*" import="java.util.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	PostAdoption pA = (PostAdoption)request.getAttribute("pA");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>입양·임보 글 수정</title>
<script>
function adoptUpdate() {
	if (form.postTitle.value == "") { alert("제목을 입력하십시오."); form.postTitle.focus(); return false; }
	if (form.postContent.value == "") { alert("내용을 입력하십시오."); form.postContent.focus(); return false; }
	if (form.kind.value == "") { alert("종을 입력하십시오."); form.kind.focus(); return false; }
	if (form.gender.value == "") { alert("성별을 입력하십시오."); form.gender.focus(); return false; }
	if (form.age.value == "") { alert("나이를 입력하십시오."); form.age.focus(); return false; }
	form.submit();
}
</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page form">
	<h1 class="pm-page-title">입양·임보 글 수정</h1>
	<p class="pm-page-sub">공고 내용과 동물 정보를 수정한 뒤 저장하세요.</p>

	<c:if test="${registerFailed}">
		<p class="pm-note" style="color:#d70015;"><c:out value="${exception.getMessage()}" /></p>
	</c:if>

	<form name="form" method="POST" action="<c:url value='/community/adopt_community/adopt_info_update' />" enctype="multipart/form-data" class="pm-form">
		<input type="hidden" name="postId" value="${pA.postId}"/>
		<input type="hidden" name="petId" value="${pA.animal.petId}"/>

		<div class="pm-field">
			<label class="pm-label" for="postTitle">제목</label>
			<input id="postTitle" type="text" class="pm-input" name="postTitle" value="${pA.postTitle}">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="postContent">작성자 희망 조건</label>
			<textarea id="postContent" name="postContent" class="pm-textarea" style="min-height:120px">${pA.postContent}</textarea>
		</div>
		<div class="pm-inline" style="gap:16px; align-items:flex-start;">
			<div class="pm-field" style="flex:1;">
				<label class="pm-label" for="kind">동물 종</label>
				<input id="kind" type="text" class="pm-input" name="kind" value="${pA.animal.kind}">
			</div>
			<div class="pm-field" style="flex:1;">
				<label class="pm-label" for="gender">성별</label>
				<input id="gender" type="text" class="pm-input" name="gender" value="${pA.animal.gender}">
			</div>
			<div class="pm-field" style="flex:1;">
				<label class="pm-label" for="age">나이</label>
				<input id="age" type="text" class="pm-input" name="age" value="${pA.animal.age}">
			</div>
		</div>
		<div class="pm-field">
			<label class="pm-label" for="health">건강상태</label>
			<input id="health" type="text" class="pm-input" name="health" value="${pA.animal.health}">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="vaccination">예방접종 여부</label>
			<input id="vaccination" type="text" class="pm-input" name="vaccination" value="${pA.animal.vaccination}">
		</div>
		<div class="pm-field">
			<label class="pm-label">사진</label>
			<% if (pA.getAnimal() != null && pA.getAnimal().getFilename() != null) { %>
				<img class="pm-media" src="<c:url value='/image?file=${pA.animal.filename}'/>" alt="현재 사진" style="margin:0 0 10px;">
			<% } %>
			<input type="file" class="pm-input" name="filename">
			<p class="pm-note">사진을 바꾸지 않으려면 비워두세요.</p>
		</div>
		<div class="pm-actions">
			<input class="pm-btn" type="button" value="수정 완료" onClick="adoptUpdate()">
			<a class="pm-btn-line" href="<c:url value='/community/adopt_community/adopt_info'><c:param name='postId' value='${pA.postId}'/></c:url>">취소</a>
		</div>
	</form>
</div>
</body>
</html>
