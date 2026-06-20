<%@page contentType="text/html; charset=utf-8" %> <!-- 변수 바꾸기 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>사용자 관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
function userCreate() {
	if (form.name.value == "") {
		alert("펫 이름을 입력하십시오.");
		form.name.focus();
		return false;
	}
	if (form.age.value == "") {
		alert("펫 나이를 입력하십시오.");
		form.age.focus();
		return false;
	}
	if (form.kind.value == "") {
		alert("펫 종을 입력하십시오.");
		form.kind.focus();
		return false;
	}
	if (form.gender.value == "") {
		alert("펫 성별을 입력하십시오.");
		form.gender.focus();
		return false;
	}
	if (form.vaccination.value == "") {
		alert("백신 접종 여부를 입력하십시오.");
		form.vaccination.focus();
		return false;
	}
	if (form.health.value == "") {
		alert("펫 건강상태를 입력하십시오.");
		form.health.focus();
		return false;
	}

	alert("회원가입 완료");

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
	<p class="pm-page-sub">2단계 · 펫의 정보 (없으면 건너뛸 수 있어요)</p>

	<form name="form" method="POST" action="<c:url value='/user/register_pet' />" enctype="multipart/form-data">
		<div class="pm-form">
			<div class="pm-field">
				<label class="pm-label" for="name">이름</label>
				<input class="pm-input" type="text" id="name" name="name"
					<c:if test="${registerFailed}">value="${pet.name}"</c:if>>
			</div>
			<div class="pm-field">
				<label class="pm-label" for="age">나이</label>
				<input class="pm-input" type="text" id="age" name="age" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
			</div>
			<div class="pm-field">
				<label class="pm-label" for="kind">종</label>
				<input class="pm-input" type="text" id="kind" name="kind" placeholder="종">
			</div>
			<div class="pm-field">
				<span class="pm-label">성별</span>
				<div class="pm-radios">
					<label><input type="radio" name="gender" value="female"/> 여성</label>
					<label><input type="radio" name="gender" value="male"/> 남성</label>
				</div>
			</div>
			<div class="pm-field">
				<label class="pm-label" for="vaccination">예방접종 여부</label>
				<input class="pm-input" type="text" id="vaccination" name="vaccination" placeholder="ex) 어떤 예방 접종을 몇 차까지 맞았는지">
			</div>
			<div class="pm-field">
				<label class="pm-label" for="health">건강상태</label>
				<input class="pm-input" type="text" id="health" name="health" placeholder="건강상태">
			</div>
			<div class="pm-field">
				<label class="pm-label" for="filename">첨부파일 (프로필 사진)</label>
				<input class="pm-input" type="file" id="filename" name="filename">
				<input class="pm-input file_fake" type="text" placeholder="* 10MB 미만의 jpg, png, bmp, gif만 첨부 가능" readonly tabindex="-1">
			</div>

			<div class="pm-actions">
				<input class="pm-btn" type="button" value="회원 가입" onClick="userCreate()">
				<input class="pm-btn-line" type="button" value="로그인 창으로 돌아가기" onClick="userList('<c:url value='/user/login' />')">
				<input class="pm-btn-line" type="button" value="펫 정보 기입 안하기" onClick="userList('<c:url value='/user/login' />')">
			</div>
		</div>
	</form>
</div>
</body>
</html>
