<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>쪽지쓰기</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
function messageCreate() {
	alert("보내기");
   if (form.mTitle.value == "") {
      alert("제목을 입력하십시오.");
      form.mTitle.focus();
      return false;
   }

   if (form.loginId.value == "") {
	   alert("수신자를 입력하십시오.");
	   form.loginId.focus();
	   return false;
	}
   if (form.content.value == "") {
	   alert("내용을 입력하십시오.");
	   form.content.focus();
	   return false;
	}
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
<div class="pm-page form">
	<h1 class="pm-page-title">쪽지쓰기</h1>
	<p class="pm-page-sub">받는 사람에게 쪽지를 보냅니다.</p>

	<form name="form" method="POST" action="<c:url value='/message/message_write' />" class="pm-form">
		<div class="pm-field">
			<label class="pm-label" for="wrtTitle">제목</label>
			<input id="wrtTitle" type="text" class="pm-input" name="mTitle" maxlength="256" value="">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="wrtReceiver">받는 사람</label>
			<input id="wrtReceiver" type="text" class="pm-input" name="loginId" maxlength="256">
		</div>
		<div class="pm-field">
			<label class="pm-label" for="wrtContent">내용</label>
			<textarea id="wrtContent" name="content" class="pm-textarea" style="min-height:280px"></textarea>
		</div>
		<div class="pm-actions">
			<input class="pm-btn" type="button" value="전송하기" onClick="messageCreate()">
			<input class="pm-btn-line" type="button" value="목록보기" onClick="userList('<c:url value='/message/message' />')">
		</div>
	</form>
</div>
</body>
</html>
