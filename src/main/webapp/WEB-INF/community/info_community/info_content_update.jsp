<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	PostInformation post0 = (PostInformation)request.getAttribute("post0");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>정보 글 수정</title>
<script>
function applyInfo() {
	if (form.postTitle.value == "") { alert("제목을 입력하십시오."); form.postTitle.focus(); return false; }
	if (form.postContent.value == "") { alert("내용을 입력하십시오."); form.postContent.focus(); return false; }
	form.submit();
}
</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page form">
	<h1 class="pm-page-title">정보 글 수정</h1>
	<p class="pm-page-sub">내용을 수정한 뒤 저장하세요.</p>

	<form name="form" method="POST" action="<c:url value='/community/info_community/info_content_update' />" enctype="multipart/form-data" class="pm-form">
		<input type="hidden" name="postId" value="${post0.postId}"/>
		<div class="pm-field">
			<label class="pm-label" for="postTitle">제목</label>
			<input id="postTitle" type="text" class="pm-input" name="postTitle" value="${post0.postTitle}">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="kind">종</label>
			<input id="kind" type="text" class="pm-input" name="kind" value="${post0.kind}">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="postContent">내용</label>
			<textarea id="postContent" name="postContent" class="pm-textarea">${post0.postContent}</textarea>
		</div>
		<div class="pm-field">
			<label class="pm-label">이미지</label>
			<% if (post0.getFileName() != null) { %>
				<img class="pm-media" src="<c:url value='/image?file=${post0.fileName}'/>" alt="현재 이미지" style="margin:0 0 10px;">
			<% } %>
			<input type="file" class="pm-input" name="fileName">
			<p class="pm-note">이미지를 바꾸지 않으려면 비워두세요.</p>
		</div>
		<div class="pm-actions">
			<input class="pm-btn" type="button" value="수정 완료" onClick="applyInfo()">
			<a class="pm-btn-line" href="<c:url value='/community/info_community/info_content'><c:param name='postId' value='${post0.postId}'/></c:url>">취소</a>
		</div>
	</form>
</div>
</body>
</html>
