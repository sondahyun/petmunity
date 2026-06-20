<%@page contentType="text/html; charset=utf-8" %> <!-- 변수 바꾸기 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>사용자 관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
function userCreate() {
	alert("나의 정보 작성완료 -> 펫 정보 작성하기");

	if (form.userNickname.value == "") {
		alert("이름을 입력하십시오.");
		form.userNickname.focus();
		return false;
	}
	if (form.loginId.value == "") {
		alert("사용자 ID를 입력하십시오.");
		form.userId.focus();
		return false;
	}
	if (form.loginPwd.value == "") {
		alert("비밀번호를 입력하십시오.");
		form.loginPwd.focus();
		return false;
	}
	if (form.loginPwd.value != form.password2.value) {
		alert("비밀번호가 일치하지 않습니다.");
		form.password2.focus();
		return false;
	}
	if (form.userBirth.value == "") {
		alert("생년월일을 입력하십시오.");
		form.userBirth.focus();
		return false;
	}
	if (form.gender.value == "") {
		alert("성별을 입력하십시오.");
		form.gender.focus();
		return false;
	}
	if (form.address.value == "") {
		alert("거주지 주소를 입력하십시오.");
		form.address.focus();
		return false;
	}
	if (form.email.value == "") {
		alert("이메일 주소를 입력하십시오.");
		form.userNickname.focus();
		return false;
	}
	if (form.phone1.value == "" || form.phone2.value =="" || form.phone3.value=="") {
		alert("전화번호를 입력하십시오.");
		form.phone1.focus();
		return false;
	}

	//프론트팀 전달
	var emailExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;	//""
	if(emailExp.test(form.email.value)==false) {
		alert("이메일 형식이 올바르지 않습니다.");
		form.email.focus();
		return false;
	}
	//동작?
	/* var phoneExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
	if(phoneExp.test(form.phone.value)==false) {
		alert("전화번호 형식이 올바르지 않습니다.");
		form.phone.focus();
		return false;
	} */
	//form.method="post";
	form.submit();
}

function userList(targetUri) {
	form.method = "GET";
	form.action = targetUri;
	form.submit();	//get
}

</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %><!-- 화면 로드 시 서버로부터 커뮤니티 목록을 가져와 commSelect 메뉴 생성 -->
<!-- registration form  -->

<div class="pm-page narrow">
	<h1 class="pm-page-title">회원가입</h1>
	<p class="pm-page-sub">1단계 · 나의 정보</p>

	<form name="form" method="POST" action="<c:url value='/user/register_person' />">
		<!-- 회원가입이 실패한 경우 exception 객체에 저장된 오류 메시지를 출력 -->
		<c:if test="${registerFailed}">
			<p class="pm-note" style="color:#d70015;"><c:out value="${exception.getMessage()}" /></p>
		</c:if>

		<div class="pm-form">
			<div class="pm-field">
				<label class="pm-label" for="userNickname">이름</label>
				<input class="pm-input" type="text" id="userNickname" name="userNickname"
					<c:if test="${registerFailed}">value="${user.userNickname}"</c:if>>
			</div>
			<div class="pm-field">
				<label class="pm-label" for="userBirth">생년월일</label>
				<input class="pm-input" type="date" id="userBirth" name="userBirth">
			</div>
			<div class="pm-field">
				<span class="pm-label">성별</span>
				<div class="pm-radios">
					<label><input type="radio" name="gender" value="female"/> 여성</label>
					<label><input type="radio" name="gender" value="male"/> 남성</label>
				</div>
			</div>
			<%--
			<div class="pm-field">
				<label class="pm-label" for="phone">전화번호</label>
				<input class="pm-input" type="text" id="phone" name="phone"
					<c:if test="${registerFailed}">value="${user.phone}"</c:if>>
			</div> --%>
			<div class="pm-field">
				<span class="pm-label">전화번호</span>
				<div class="pm-inline">
					<select class="pm-select" name="phone1" style="width:auto;">
						<option value=0 selected>010</option>
						<option value=1>080</option>
						<option value=2>070</option>
						<option value=3>02</option>
					</select>
					<span>-</span>
					<input class="pm-input" type="text" name="phone2" value="" size="4" maxlength="4" style="width:80px;">
					<span>-</span>
					<input class="pm-input" type="text" name="phone3" value="" size="4" maxlength="4" style="width:80px;">
					<%-- <c:if test="${registerFailed}">value="${user.phone}"</c:if> --%>
				</div>
			</div>
			<div class="pm-field">
				<label class="pm-label" for="loginId">사용자 ID</label>
				<input class="pm-input" type="text" id="loginId" name="loginId">
			</div>
			<div class="pm-field">
				<label class="pm-label" for="loginPwd">비밀번호</label>
				<input class="pm-input" type="password" id="loginPwd" name="loginPwd">
			</div>
			<div class="pm-field">
				<label class="pm-label" for="password2">비밀번호 확인</label>
				<input class="pm-input" type="password" id="password2" name="password2">
			</div>
			<div class="pm-field">
				<label class="pm-label" for="email">이메일 주소</label>
				<input class="pm-input" type="text" id="email" name="email" placeholder="you@example.com">
				<%-- <c:if test="${registerFailed}">value="${user.address}"</c:if>> --%>
			</div>
			<div class="pm-field">
				<label class="pm-label" for="address">거주지 주소</label>
				<input class="pm-input" type="text" id="address" name="address" placeholder="주소지"
					<c:if test="${registerFailed}">value="${user.address}"</c:if>>
			</div>

			<div class="pm-actions">
				<input class="pm-btn" type="button" value="다음 단계로 넘어가기" onClick="userCreate()">
				<input class="pm-btn-line" type="button" value="로그인 창으로 돌아가기" onClick="userList('<c:url value='/user/login' />')">
			</div>
		</div>
	</form>
</div>
</body>
</html>
