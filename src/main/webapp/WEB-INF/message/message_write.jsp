<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>쪽지쓰기</title>
<script>
function toggleSelf() {
	var chk = document.getElementById('toSelf');
	var rcv = document.getElementById('wrtReceiver');
	if (chk.checked) { rcv.value = ''; rcv.disabled = true; }
	else { rcv.disabled = false; }
}
function messageCreate() {
	if (form.mTitle.value == "") { alert("제목을 입력하십시오."); form.mTitle.focus(); return false; }
	var self = document.getElementById('toSelf').checked;
	if (!self && form.loginId.value == "") {
		alert("받는 사람을 입력하거나 '나에게 보내기'를 선택하세요.");
		form.loginId.focus();
		return false;
	}
	if (form.content.value == "") { alert("내용을 입력하십시오."); form.content.focus(); return false; }
	form.submit();
}
function userList(targetUri) { form.action = targetUri; form.submit(); }
</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page form">
	<h1 class="pm-page-title">쪽지쓰기</h1>
	<p class="pm-page-sub">받는 사람에게 쪽지를 보냅니다.</p>

	<c:if test="${sendFailed}">
		<p class="pm-note" style="color:#d70015;">${sendError}</p>
	</c:if>

	<form name="form" method="POST" action="<c:url value='/message/message_write' />" class="pm-form">
		<div class="pm-field">
			<label class="pm-label" for="wrtTitle">제목</label>
			<input id="wrtTitle" type="text" class="pm-input" name="mTitle" maxlength="256" value="${mTitle}">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="wrtReceiver">받는 사람</label>
			<input id="wrtReceiver" type="text" class="pm-input" name="loginId" maxlength="256" placeholder="받는 사람의 아이디">
			<label style="display:inline-flex; align-items:center; gap:6px; font-size:14px; color:var(--pm-muted); margin-top:4px; cursor:pointer;">
				<input type="checkbox" name="toSelf" id="toSelf" value="on" onchange="toggleSelf()"> 나에게 보내기
			</label>
		</div>
		<div class="pm-field">
			<label class="pm-label" for="wrtContent">내용</label>
			<textarea id="wrtContent" name="content" class="pm-textarea" style="min-height:280px">${content}</textarea>
		</div>
		<div class="pm-actions">
			<input class="pm-btn" type="button" value="전송하기" onClick="messageCreate()">
			<input class="pm-btn-line" type="button" value="목록보기" onClick="userList('<c:url value='/message/message' />')">
		</div>
	</form>
</div>
</body>
</html>
