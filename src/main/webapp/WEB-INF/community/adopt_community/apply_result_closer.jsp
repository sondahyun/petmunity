<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
Apply applyA = (Apply)request.getAttribute("applyA");
pageContext.setAttribute("adoptId", request.getAttribute("adoptId"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>신청서 상세</title>
<script>
function removeApply() {
	if(confirm("삭제를 하면 다시 복구할 수 없습니다. 삭제하시겠습니까?")==false) return false;
	else return frmD.submit();
}
</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page">
	<h1 class="pm-page-title">신청서 상세</h1>
	<p class="pm-page-sub">신청자가 제출한 입양·임보 신청 내용입니다.</p>

	<div class="pm-panel" style="margin-bottom:24px;">
		<%@include file="/WEB-INF/community/adopt_community/adopt_main2.jsp" %>
	</div>

	<table class="pm-detail">
		<tr><th>이름</th><td>${applyA.name}</td></tr>
		<tr><th>신청(입양/임보)</th><td><c:if test="${applyA.aType==0}">임보</c:if><c:if test="${applyA.aType==1}">입양</c:if></td></tr>
		<tr><th>생년</th><td>${applyA.birth}</td></tr>
		<tr><th>전화번호</th><td>${applyA.phoneNumber}</td></tr>
		<tr><th>주소</th><td>${applyA.address}</td></tr>
		<tr><th>작성자 희망 조건</th><td>${applyA.hopeConditions}</td></tr>
		<tr><th>입양·임보에 대한 각오</th><td>${applyA.resolution}</td></tr>
		<tr><th>알레르기 유무</th><td>${applyA.allergy}</td></tr>
		<tr><th>거주지 형태</th><td>${applyA.housingType}</td></tr>
		<tr><th>기타</th><td>${applyA.etc}</td></tr>
	</table>

	<div class="pm-actions" style="margin-top:20px;">
		<form name="frmU" action="<c:url value='/community/adopt_community/adopt_info'><c:param name='applyId' value='${applyA.applyId}'/><c:param name='adoptId' value='${param.adoptId}'/></c:url>" style="display:inline;">
			<input type="hidden" name="applyId" value="${applyA.applyId}">
			<input type="hidden" name="adoptId" value="${param.adoptId}">
			<input class="pm-btn" type="submit" value="승인">
		</form>
		<form name="frmD" action="<c:url value='/community/adopt_community/adopt_info/deleteApply'/>" style="display:inline;">
			<input type="hidden" name="applyId" value="${applyA.applyId}">
			<input class="pm-btn-danger" type="button" value="삭제" onClick="removeApply()">
		</form>
	</div>
</div>
</body>
</html>
