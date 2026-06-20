<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>폼 작성</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
function applyInfo() {
   alert("실행");

   if (form.postTitle.value == "") {
      alert("제목을 입력하십시오.");
      form.postTitle.focus();
      return false;
   }

   if (form.postContent.value == "") {
	      alert("내용을 입력하십시오.");
	      form.postContent.focus();
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
<%@include file="/WEB-INF/navbar.jsp" %><!-- 화면 로드 시 서버로부터 커뮤니티 목록을 가져와 commSelect 메뉴 생성 -->

<div class="pm-page narrow">
	<h1 class="pm-page-title">폼 작성</h1>
	<p class="pm-page-sub">정보 커뮤니티에 글을 작성합니다.</p>

	<c:if test="${registerFailed}">
		<p class="pm-note" style="color:#d70015;"><c:out value="${exception.getMessage()}" /></p>
	</c:if>

	<form name="form" class="pm-form" method="POST" action="<c:url value='/community/info_community/add_content' />" enctype="multipart/form-data">

		<div class="pm-field">
			<label class="pm-label">제목</label>
			<input class="pm-input" type="text" name="postTitle">
		</div>

		<div class="pm-field">
			<label class="pm-label">사진</label>
			<input class="pm-input" type="file" name="fileName">
		</div>

		<div class="pm-field">
			<label class="pm-label">내용</label>
			<textarea class="pm-textarea" name="postContent"></textarea>
		</div>

		<div class="pm-field">
			<label class="pm-label">종</label>
			<input class="pm-input" type="text" name="kind">
		</div>

		<div class="pm-actions">
			<input class="pm-btn" type="button" value="폼 작성완료" onClick="applyInfo()">
		</div>
	</form>
</div>
</body>
</html>
