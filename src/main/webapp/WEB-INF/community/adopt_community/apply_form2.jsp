<!--임보 신청-->
<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
int postId = Integer.parseInt(request.getParameter("postId"));
AdoptionAnimal adoptAnimal = (AdoptionAnimal)session.getAttribute("adoptAnimal");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>임보 신청</title>
<script>
function applyAdopt() {
	if(confirm("신청 후에는 수정이나 삭제가 불가능합니다. 신청하시겠습니까?")==true)
		form.submit();
	else
		return false;
}
</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>

<div class="pm-page">
	<h1 class="pm-page-title">임보 신청</h1>
	<p class="pm-page-sub">신청 후에는 수정이나 삭제가 불가능합니다. 신중히 작성해 주세요.</p>

	<c:if test="${registerFailed}">
		<p class="pm-note" style="color:#d70015;"><c:out value="${exception.getMessage()}" /></p>
	</c:if>

	<div class="pm-panel" style="margin-bottom:28px;">
		<%@include file="/WEB-INF/community/adopt_community/adopt_main2.jsp" %>
	</div>

	<form name="form" class="pm-form" method="POST" action="<c:url value='/community/adopt_community/adopt_info/createApply'><c:param name="postId" value="${param.postId}"></c:param></c:url>">

		<div class="pm-field">
			<label class="pm-label">이름</label>
			<input class="pm-input" type="text" name="name">
		</div>

		<div class="pm-field">
			<label class="pm-label">생년</label>
			<input class="pm-input" type="date" name="birth">
		</div>

		<div class="pm-field">
			<label class="pm-label">연락처</label>
			<div class="pm-inline">
				<select class="pm-select" name="phone1" style="width:auto;">
					<option value="0" selected>010</option>
					<option value="1">080</option>
					<option value="2">070</option>
					<option value="3">02</option>
				</select>
				<span>-</span>
				<input class="pm-input" type="text" name="phone2" value="" size="4" maxlength="4" style="width:auto;">
				<span>-</span>
				<input class="pm-input" type="text" name="phone3" value="" size="4" maxlength="4" style="width:auto;">
			</div>
		</div>

		<div class="pm-field">
			<label class="pm-label">거주지 주소</label>
			<input class="pm-input" type="text" name="address" placeholder="주소지">
		</div>

		<div class="pm-field">
			<label class="pm-label">작성자 희망 조건 사항</label>
			<input class="pm-input" type="text" name="hopeConditions">
		</div>

		<div class="pm-field">
			<label class="pm-label">임보에 대한 각오</label>
			<input class="pm-input" type="text" name="resolution">
		</div>

		<div class="pm-field">
			<label class="pm-label">알레르기 유무</label>
			<div class="pm-radios">
				<label><input type="radio" name="allergy" value="없음"/> 없음</label>
				<label><input type="radio" name="allergy" value="있음"/> 있음</label>
			</div>
		</div>

		<div class="pm-field">
			<label class="pm-label">거주지 형태</label>
			<input class="pm-input" type="text" name="housingType">
		</div>

		<div class="pm-field">
			<label class="pm-label">기타사항</label>
			<input class="pm-input" type="text" name="etc">
		</div>

		<input type="hidden" name="aType" value="0">
		<input type="hidden" name="petId" value="${adoptAnimal.petId}">
		<input type="hidden" name="postId" value="${postId}">

		<div class="pm-actions">
			<input class="pm-btn" type="button" value="신청하기" onClick="applyAdopt()">
		</div>
	</form>
</div>
</body>
</html>
