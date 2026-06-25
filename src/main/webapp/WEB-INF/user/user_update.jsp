<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*" import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	UserInfo user = (UserInfo)request.getAttribute("user");
	Pet pet = (Pet)request.getAttribute("pet");
	System.out.println(pet.toString());

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user_update</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
function userCreate() {
	alert("실행");

	if (form.loginId.value == "") {
		alert("사용자 ID를 입력하십시오.");
		form.userId.focus();
		return false;
	}
	// 비밀번호는 변경할 때만 입력 (빈 칸이면 기존 비밀번호 유지)
	if (form.loginPwd.value != "" && form.loginPwd.value != form.password2.value) {
		alert("비밀번호가 일치하지 않습니다.");
		form.password2.focus();
		return false;
	}
	if (form.userNickname.value == "") {
		alert("이름을 입력하십시오.");
		form.userNickname.focus();
		return false;
	}
	if (form.name.value == "") {
		alert("펫 이름을 입력하십시오.");
		form.name.focus();
		return false;
	}

	form.submit();
}

function userList(targetUri) {
	form.action = targetUri;
	form.submit();	//get
}

</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page form">
	<h1 class="pm-page-title">회원 정보 수정</h1>
	<p class="pm-page-sub">나의 정보와 반려동물 정보를 수정할 수 있습니다.</p>

	<form name="form" method="POST" action="<c:url value='/user/user_update' />" enctype="multipart/form-data" class="pm-form">
		<input type="hidden" name="petId" value="${pet.petId}">

		<c:if test="${registerFailed}">
			<p class="pm-note" style="color:#d70015;"><c:out value="${exception.getMessage()}" /></p>
		</c:if>

		<h2 class="pm-page-title" style="font-size:20px;">나의 정보</h2>

		<div class="pm-field">
			<label class="pm-label">이름</label>
			<input type="text" class="pm-input" name="userNickname" value="${user.userNickname}">
		</div>

		<div class="pm-field">
			<label class="pm-label">생일</label>
			<input type="date" class="pm-input" name="userBirth" value="${user.userBirth}">
		</div>

		<div class="pm-field">
			<label class="pm-label">성별</label>
			<div class="pm-radios">
			<%
			if(user.getGender().equals("female")) {%>
				<label><input type="radio" name="gender" value="female" checked /> 여성</label>
				<label><input type="radio" name="gender" value="male"/> 남성</label>
			<%} else{%>
				<label><input type="radio" name="gender" value="female"  /> 여성</label>
				<label><input type="radio" name="gender" value="male" checked/> 남성</label>
			<%} %>
			</div>
		</div>

		<%--
		<div class="pm-field">
			<label class="pm-label">전화번호</label>
			<input type="text" class="pm-input" name="phone"
				<c:if test="${registerFailed}">value="${user.phone}"</c:if>>
		</div> --%>

		<div class="pm-field">
			<label class="pm-label">전화번호</label>
			<div class="pm-inline">
			<%
			String phone[] = (user.getPhoneNumber()).split("-");
			if(phone[0].equals("010")){%>
				<select name=phone1 class="pm-select" style="width:auto;">
					<option value=010 selected>010</option>
					<option value=080>080</option>
					<option value=070>070</option>
					<option value=02>02</option>
				</select>
			<%}
			else if(phone[0].equals("080")){ %>
				<select name=phone1 class="pm-select" style="width:auto;">
					<option value=010>010</option>
					<option value=080 selected>080</option>
					<option value=070>070</option>
					<option value=02>02</option>
				</select>
			<%}
			else if(phone[0].equals("070")){%>
				<select name=phone1 class="pm-select" style="width:auto;">
					<option value=010>010</option>
					<option value=080>080</option>
					<option value=070 selected>070</option>
					<option value=02>02</option>
				</select>
			<%}
			else{%>
				<select name=phone1 class="pm-select" style="width:auto;">
					<option value=010>010</option>
					<option value=080>080</option>
					<option value=070>070</option>
					<option value=02 selected>02</option>
				</select>
			<%} %>
				<span>-</span>
				<input type="text" class="pm-input" style="width:90px;" name="phone2" size="4" maxlength="4" value=<%=phone[1]%>>
				<span>-</span>
				<input type="text" class="pm-input" style="width:90px;" name="phone3" size="4" maxlength="4" value=<%=phone[2]%>>
				<%-- <c:if test="${registerFailed}">value="${user.phone}"</c:if> --%>
			</div>
		</div>

		<div class="pm-field">
			<label class="pm-label">사용자 ID</label>
			<input type="text" class="pm-input" name="loginId" value="${user.loginId}">
		</div>

		<div class="pm-field">
			<label class="pm-label">비밀번호</label>
			<input type="password" class="pm-input" name="loginPwd" value="" placeholder="변경할 때만 입력하세요">
		</div>

		<div class="pm-field">
			<label class="pm-label">비밀번호 확인</label>
			<input type="password" class="pm-input" name="password2" placeholder="변경할 때만 입력하세요">
		</div>

		<div class="pm-field">
			<label class="pm-label">이메일 주소</label>
			<input type="text" class="pm-input" name="email" value="${user.email}">
			<%-- <c:if test="${registerFailed}">value="${user.address}"</c:if>> --%>
		</div>

		<div class="pm-field">
			<label class="pm-label">거주지 주소</label>
			<input type="text" class="pm-input" name="address" value="${user.address}">
		</div>

		<h2 class="pm-page-title" style="font-size:20px;">펫의 정보</h2>

		<div class="pm-field">
			<label class="pm-label">이름</label>
			<input type="text" class="pm-input" name="name" value="${pet.name}">
		</div>

		<div class="pm-field">
			<label class="pm-label">성별</label>
			<div class="pm-radios">
			<%
			if(pet.getGender().equals("female")) {%>
				<label><input type="radio" name="pGender" value="female" checked /> 여성</label>
				<label><input type="radio" name="pGender" value="male"/> 남성</label>
			<%} else{%>
				<label><input type="radio" name="pGender" value="female"  /> 여성</label>
				<label><input type="radio" name="pGender" value="male" checked/> 남성</label>
			<%} %>
			</div>
		</div>

		<div class="pm-field">
			<label class="pm-label">나이</label>
			<input type="text" class="pm-input" name="age" value="${pet.age}">
		</div>

		<div class="pm-field">
			<label class="pm-label">건강상태</label>
			<input type="text" class="pm-input" name="health" value="${pet.health}">
		</div>

		<div class="pm-field">
			<label class="pm-label">접종상태</label>
			<input type="text" class="pm-input" name="vaccination" value="${pet.vaccination}">
		</div>

		<div class="pm-field">
			<label class="pm-label">종</label>
			<input type="text" class="pm-input" name="kind" value="${pet.kind}">
		</div>

		<div class="pm-field">
			<label class="pm-label">사진</label>
			<%if(pet.getFilename() == null){ %>
				<img class="pm-media" src="<c:url value='/images/logo_transparent.png' />" style="width:200px; height:200px;"/>
			<%}else{ %>
				<img class="pm-media" src="<c:url value='/image?file=${pet.filename}'/>" style="width:200px; height:200px;" />
			<%} %>
			<input type="file" class="pm-input" name="filename">
		</div>

		<div class="pm-actions">
			<input class="pm-btn" type="button" value="수정하기" onClick="userCreate()">
		</div>
	</form>
</div>
</body>
</html>