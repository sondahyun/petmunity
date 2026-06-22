<%@page contentType="text/html; charset=utf-8" import="model.*"
	import="java.util.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	PostPetstargram p2 = (PostPetstargram) request.getAttribute("p2");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>펫스타그램 글 수정</title>
<script>
function petstarUpdate() {
	if (form.postTitle.value == "") { alert("제목을 입력하십시오."); form.postTitle.focus(); return false; }
	if (form.postContent.value == "") { alert("내용을 입력하십시오."); form.postContent.focus(); return false; }
	if (form.kind.value == "") { alert("종을 입력하십시오."); form.kind.focus(); return false; }
	form.submit();
}
</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page form">
	<h1 class="pm-page-title">펫스타그램 글 수정</h1>
	<p class="pm-page-sub">사진과 내용을 수정한 뒤 저장하세요.</p>

	<form name="form" method="POST" action="<c:url value='/community/petstar_community/petstar_content_update' />" enctype="multipart/form-data" class="pm-form">
		<input type="hidden" name="postId" value="${p2.postId}"/>
		<div class="pm-field">
			<label class="pm-label" for="postTitle">제목</label>
			<input id="postTitle" type="text" class="pm-input" name="postTitle" value="${p2.postTitle}">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="kind">종</label>
			<input id="kind" type="text" class="pm-input" name="kind" value="${p2.kind}">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="postContent">내용</label>
			<textarea id="postContent" name="postContent" class="pm-textarea">${p2.postContent}</textarea>
		</div>
		<div class="pm-field">
			<label class="pm-label">사진</label>
			<% if (p2.getFileName() != null) { %>
				<img class="pm-media" src="<c:url value='/image?file=${p2.fileName}'/>" alt="현재 사진" style="margin:0 0 10px;">
			<% } %>
			<input type="file" class="pm-input" name="fileName">
			<p class="pm-note">사진을 바꾸지 않으려면 비워두세요.</p>
		</div>
		<div class="pm-actions">
			<input class="pm-btn" type="button" value="수정 완료" onClick="petstarUpdate()">
			<a class="pm-btn-line" href="<c:url value='/community/petstar_community/petstar_content'><c:param name='postId' value='${p2.postId}'/></c:url>">취소</a>
		</div>
	</form>
</div>
</body>
</html>
