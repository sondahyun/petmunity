<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>폼 작성</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/user.css' />" type="text/css">
<link rel=stylesheet href="<c:url value='/css/btn.css' />" type="text/css">
<script>
function Create() {
   /* alert("실행");

   if (form.userNickname.value == "") {
      alert("이름을 입력하십시오.");
      form.userNickname.focus();
      return false;
   } */

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
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page narrow">
	<h1 class="pm-page-title">폼 작성</h1>
	<p class="pm-page-sub">입양·임보 글을 등록합니다.</p>

	<%-- <c:if test="${registerFailed}">
		<font color="red"><c:out value="${exception.getMessage()}" /></font>
	</c:if>   --%>

	<form name="form" method="POST" action="<c:url value='/community/adopt_community/adopt_community/add_content' />" enctype="multipart/form-data">
		<div class="pm-form">
			<div class="pm-field">
				<label class="pm-label">제목</label>
				<input class="pm-input" type="text" name="postTitle">
			</div>

			<div class="pm-field">
				<label class="pm-label">사진</label>
				<input class="pm-input" type="file" name="filename">
			</div>

			<div class="pm-field">
				<label class="pm-label">모집(임보/입양)</label>
				<div class="pm-radios">
					<label><input type="radio" name="aType" value="0"/> 임보</label>
					<label><input type="radio" name="aType" value="1"/> 입양</label>
					<label><input type="radio" name="aType" value="2"/> 입양(임보)</label>
				</div>
			</div>

			<input type="hidden" name="approval" value="0">

			<div class="pm-field">
				<label class="pm-label">동물 종</label>
				<input class="pm-input" type="text" name="kind">
			</div>

			<div class="pm-field">
				<label class="pm-label">동물 성별</label>
				<div class="pm-radios">
					<label><input type="radio" name="gender" value="male"/> 남성</label>
					<label><input type="radio" name="gender" value="female"/> 여성</label>
				</div>
			</div>

			<div class="pm-field">
				<label class="pm-label">동물 나이</label>
				<select class="pm-select" name="age">
					<option value=1 selected>1</option>
					<%
						for(int i=2;i<=100;i++){
							out.println("<option value="+i+">"+i+"</option>");
						}
					%>
				</select>
			</div>

			<div class="pm-field">
				<label class="pm-label">건강상태</label>
				<input class="pm-input" type="text" name="health">
			</div>

			<div class="pm-field">
				<label class="pm-label">백신 접종 여부</label>
				<input class="pm-input" type="text" name="vaccination">
			</div>

			<div class="pm-field">
				<label class="pm-label">작성자 희망 조건 사항</label>
				<input class="pm-input" type="text" name="postContent">
			</div>

			<div class="pm-actions">
				<input class="pm-btn" type="button" value="폼 작성완료" onClick="Create()">
			</div>
		</div>
	</form>
</div>
</body>
</html>
