<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" %> <!-- 변수 바꾸기 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	UserInfo user = (UserInfo)request.getAttribute("user");
	Pet pet = (Pet)request.getAttribute("pet");
%>
<html>
<head>
<title>사용자 관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
function userCreate() {
   alert("실행");

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
   if (form.userNickname.value == "") {
      alert("이름을 입력하십시오.");
      form.userNickname.focus();
      return false;
   }

   //프론트팀 전달
   /* var emailExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;   //""
   if(emailExp.test(form.email.value)==false) {
      alert("이메일 형식이 올바르지 않습니다.");
      form.email.focus();
      return false;
   }
   //동작?
   var phoneExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
   if(phoneExp.test(form.phone.value)==false) {
      alert("전화번호 형식이 올바르지 않습니다.");
      form.phone.focus();
      return false;
   } */
   //form.method="post";
   form.submit();
}

function userList(targetUri) {
   form.action = targetUri;
   form.submit();   //get
}

</script>
</head>
<body>

<form name="form" method="POST" action="<c:url value='/user/register' />">

	<!-- 회원가입이 실패한 경우 exception 객체에 저장된 오류 메시지를 출력 -->
	<c:if test="${registerFailed}">
		<p class="pm-note" style="color:#d70015;"><c:out value="${exception.getMessage()}" /></p>
	</c:if>

	<div class="pm-media" style="max-width:200px; margin:0 0 28px;">
		<%if(pet!=null && pet.getFilename() == null){ %>
			<img src="<c:url value='/images/linkedin_profile_image.png' />" style="width:200px; height:200px; border-radius:14px;"/>
		<%}else{ %>
			<img src="<c:url value='/image?file=${pet.filename}'/>" style="width:200px; height:200px; border-radius:14px;" />
		<%} %>
	</div>

	<h2 class="pm-page-title" style="font-size:22px;">마이페이지</h2>

	<table class="pm-detail" style="margin-bottom:32px;">
		<tr>
			<th>이름</th>
			<td>${user.userNickname}</td>
		</tr>
		<tr>
			<th>생일</th>
			<td>${user.userBirth}</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>${user.gender}</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>${user.phoneNumber}</td>
		</tr>
		<tr>
			<th>사용자 ID</th>
			<td>${user.loginId}</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>${user.loginPwd}</td>
		</tr>
		<tr>
			<th>이메일 주소</th>
			<td>${user.email}</td>
		</tr>
		<tr>
			<th>거주지 주소</th>
			<td>${user.address}</td>
		</tr>
	</table>

	<h2 class="pm-page-title" style="font-size:22px;">마이펫</h2>
	<% if(pet == null){ %>
		<p class="pm-note">pet이 등록되지 않았습니다.</p>
	<% }%>
	<% if(pet != null) {%>
		<table class="pm-detail">
			<tr>
				<th>이름</th>
				<td>${pet.name}</td>
			</tr>
			<tr>
				<th>나이</th>
				<td>${pet.age}</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>${pet.gender}</td>
			</tr>
			<tr>
				<th>건강상태</th>
				<td>${pet.health}</td>
			</tr>
			<tr>
				<th>접종여부</th>
				<td>${pet.vaccination}</td>
			</tr>
			<tr>
				<th>종</th>
				<td>${pet.kind}</td>
			</tr>
		</table>
	<%} %>
</form>
</body>
</html>