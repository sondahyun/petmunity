<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	PostGroup post1 = (PostGroup)request.getAttribute("post1");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>그룹 모임 수정</title>
<script>
function applyInfo() {
	if (form.postTitle.value == "") { alert("모임명을 입력하십시오."); form.postTitle.focus(); return false; }
	if (form.postContent.value == "") { alert("모임 설명을 입력하십시오."); form.postContent.focus(); return false; }
	form.submit();
}
</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page form">
	<h1 class="pm-page-title">그룹 모임 수정</h1>
	<p class="pm-page-sub">모임 정보를 수정한 뒤 저장하세요.</p>

	<form name="form" method="POST" action="<c:url value='/community/group_community/group_content_update' />" enctype="multipart/form-data" class="pm-form">
		<input type="hidden" name="postId" value="${post1.postId}"/>
		<div class="pm-field">
			<label class="pm-label" for="postTitle">모임명</label>
			<input id="postTitle" type="text" class="pm-input" name="postTitle" value="${post1.postTitle}">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="postContent">모임 설명</label>
			<textarea id="postContent" name="postContent" class="pm-textarea" style="min-height:120px">${post1.postContent}</textarea>
		</div>
		<div class="pm-field">
			<label class="pm-label" for="groupPurpose">모임 목적</label>
			<input id="groupPurpose" type="text" class="pm-input" name="groupPurpose" value="${post1.groupPurpose}">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="region">지역</label>
			<input id="region" type="text" class="pm-input" name="region" value="${post1.region}">
		</div>
		<div class="pm-field">
			<label class="pm-label">모임 대표 사진</label>
			<% if (post1.getFileName() != null) { %>
				<img class="pm-media" src="<c:url value='/image?file=${post1.fileName}'/>" alt="현재 사진" style="margin:0 0 10px;">
			<% } %>
			<input type="file" class="pm-input" name="fileName">
			<p class="pm-note">사진을 바꾸지 않으려면 비워두세요.</p>
		</div>
		<div class="pm-actions">
			<input class="pm-btn" type="button" value="수정 완료" onClick="applyInfo()">
			<a class="pm-btn-line" href="<c:url value='/community/group_community/group_content'><c:param name='postId' value='${post1.postId}'/></c:url>">취소</a>
		</div>
	</form>
</div>
</body>
</html>
