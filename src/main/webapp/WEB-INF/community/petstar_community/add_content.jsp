<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>게시글 작성</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
function Create() {
   //alert("실행");

   /* if (form.userNickname.value == "") {
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
	<h1 class="pm-page-title">펫스타그램 글 작성</h1>
	<p class="pm-page-sub">반려동물의 사진과 이야기를 남겨보세요.</p>

	<form name="form" class="pm-form" method="post" action="<c:url value='/community/petstar_community/add_content'/>" enctype="multipart/form-data">
		<div class="pm-field">
			<label class="pm-label" for="postTitle">제목</label>
			<input class="pm-input" type="text" id="postTitle" name="postTitle">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="fileName">사진</label>
			<input class="pm-input" type="file" id="fileName" name="fileName">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="postContent">내용</label>
			<textarea class="pm-textarea" id="postContent" name="postContent"></textarea>
		</div>
		<div class="pm-field">
			<label class="pm-label" for="kind">종</label>
			<input class="pm-input" type="text" id="kind" name="kind">
		</div>
		<div class="pm-actions">
			<input class="pm-btn" type="button" value="작성 완료" onClick="Create()">
		</div>
	</form>
</div>
</body>
</html>
