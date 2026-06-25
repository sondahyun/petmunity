<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>게시글 작성</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
function applyAdopt() {
   alert("실행");

   if (form.postTitle.value == "") {
      alert("모임명을 입력하십시오.");
      form.postTitle.focus();
      return false;
   }
   if (form.postContent.value == "") {
	   alert("모임 설명을 입력하십시오.");
	   form.postContent.focus();
	   return false;
	}
   if (form.groupPurpose.value == "") {
	   alert("모임 목적을 입력하십시오.");
	   form.groupPurpose.focus();
	   return false;
	}
   if (form.region.value == "") {
	   alert("지역을 입력하십시오.");
	   form.region.focus();
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
   <h1 class="pm-page-title">모임 생성</h1>
   <p class="pm-page-sub">함께할 반려인을 모을 새 모임을 만들어 보세요.</p>

   <form name="form" method="POST" action="<c:url value='/community/group_community/add_content' />" enctype="multipart/form-data" class="pm-form">

      <!-- 등록 실패 시 exception 객체에 저장된 오류 메시지를 출력 -->
      <c:if test="${creationFailed}">
         <p class="pm-note" style="color:#d70015"><c:out value="${not empty errorMessage ? errorMessage : exception.getMessage()}" /></p>
      </c:if>

      <div class="pm-field">
         <label class="pm-label">모임명</label>
         <input type="text" name="postTitle" class="pm-input" placeholder="모임명을 입력하세요.">
      </div>
      <div class="pm-field">
         <label class="pm-label">모임 설명</label>
         <input type="text" name="postContent" class="pm-input" placeholder="모임 설명을 입력하세요.">
      </div>
      <div class="pm-field">
         <label class="pm-label">모임 목적</label>
         <input type="text" name="groupPurpose" class="pm-input" placeholder="모임 목적을 입력하세요.">
      </div>
      <div class="pm-field">
         <label class="pm-label">지역</label>
         <input type="text" name="region" class="pm-input" placeholder="지역을 입력하세요.">
      </div>
      <div class="pm-field">
         <label class="pm-label">모임 대표 배경 사진</label>
         <input type="file" name="fileName" class="pm-input">
      </div>

      <div class="pm-actions">
         <input class="pm-btn" type="button" value="모임 생성완료" onClick="applyAdopt()">
      </div>
   </form>
</div>
</body>
</html>
