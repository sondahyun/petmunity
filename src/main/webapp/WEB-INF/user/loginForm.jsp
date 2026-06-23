<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>사용자 관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script>
function login() {
	if (form.loginId.value == "") {
		alert("사용자 ID를 입력하십시오.");
		form.loginId.focus();
		return false;
	}
	if (form.password.value == "") {
		alert("비밀번호를 입력하십시오.");
		form.password.focus();
		return false;
	}
	form.submit();
}

function userCreate(targetUri) {
	form.action = targetUri;
	form.method="GET";		// register form 요청
	form.submit();
}
</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page narrow auth">
	<h1 class="pm-page-title">로그인</h1>
	<p class="pm-page-sub">Petmunity 계정으로 로그인하세요.</p>

	<!-- login form  -->
	<form name="form" method="POST" action="<c:url value='/user/login' />">
		<!-- 로그인이 실패한 경우 exception 객체에 저장된 오류 메시지를 출력 -->
		<c:if test="${loginFailed}">
			<p class="pm-note" style="color:#d70015;">
				<c:choose>
					<c:when test="${withdrawn}">탈퇴한 계정입니다.</c:when>
					<c:otherwise>아이디 또는 비밀번호가 올바르지 않습니다.</c:otherwise>
				</c:choose>
			</p>
		</c:if>

		<div class="pm-form">
			<div class="pm-field">
				<label class="pm-label" for="loginId">ID</label>
				<input class="pm-input" type="text" id="loginId" name="loginId">
			</div>
			<div class="pm-field">
				<label class="pm-label" for="password">비밀번호</label>
				<input class="pm-input" type="password" id="password" name="password">
			</div>
			<div class="pm-actions">
				<input class="pm-btn" type="button" value="로그인" onClick="login()">
				<input class="pm-btn-line" type="button" value="회원가입" onClick="userCreate('<c:url value='/user/register_person/form'/>')">
			</div>
		</div>
	</form>
</div>
</body>
</html>
