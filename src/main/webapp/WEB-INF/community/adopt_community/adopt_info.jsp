<!--입양, 임보 펫 정보-->
<%@page contentType="text/html; charset=utf-8" import="model.*" import="java.util.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	@SuppressWarnings("unchecked")
	PostAdoption pA = (PostAdoption)request.getAttribute("pA");
	System.out.println("aType : "+pA.getaType());

	session.setAttribute("adoptAnimal", pA.getAnimal());
	pageContext.setAttribute("apv", request.getAttribute("apId"));
%>
<!DOCTYPE html>
<html>
<head>
<title>임보/입양 정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<form name="form" method="POST" action="<c:url value='/community/adopt_community/adopt_info' />">
<div class="pm-page">
	<% String logId = (String)session.getAttribute("loginId"); %>
	<c:set var="lui" value="<%=logId%>"/>

	<div class="pm-toolbar">
		<div>
			<h1 class="pm-page-title">임보·입양 정보</h1>
			<p class="pm-page-sub">${pA.postTitle}</p>
		</div>
		<div class="pm-inline">
			<!-- 작성자 ==방문자일경우에 모임 수정 버튼 보임 -->
			<%if(logId.equals(pA.getLoginId())){ %>
				<a class="pm-btn-line"
				href="<c:url value='/community/adopt_community/adopt_info_update'>
				<c:param name='postId' value='${pA.postId}'/>
				</c:url>">폼 수정</a>

				<a class="pm-btn-danger"
				href="<c:url value='/community/adopt_community/adopt_info_delete'>
				<c:param name='postId' value='${pA.postId}'/>
				</c:url>">폼 삭제</a>
			<%} %>

			<c:if test="${lui == pA.loginId and pA.approval == 0}">
				<a class="pm-btn-ghost" href="<c:url value='/community/adopt_community/apply_result'><c:param name="postId" value="${pA.postId}"></c:param></c:url>">모아보기</a>
			</c:if>
		</div>
	</div>

	<c:if test="${registerFailed}">
		<p class="pm-note" style="color:#d70015"><c:out value="${exception.getMessage()}" /></p>
	</c:if>

	<div class="pm-panel">
		<img class="pm-media" src="<c:url value='/images/favicon.png' />" alt="대표 이미지" style="max-width:240px"/>

		<table class="pm-detail">
			<tr>
				<th>제목</th>
				<td>${pA.postTitle}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${pA.postDate}</td>
			</tr>
			<tr>
				<th>모집(임보/입양)</th>
				<td>
					<c:if test="${pA.aType==1}">입양</c:if>
					<c:if test="${pA.aType==0}">임보</c:if>
					<c:if test="${pA.aType==2}">입양(임보)</c:if>
				</td>
			</tr>
			<tr>
				<th>현 상태</th>
				<td>
					<c:if test="${pA.approval==0}">신청 진행 중</c:if>
					<c:if test="${pA.approval==1}">입양(임보) 완료</c:if>
				</td>
			</tr>
			<tr>
				<th>입양(임보)완료일</th>
				<td><c:if test="${pA.approval==1}">${pA.approvalDate}</c:if></td>
			</tr>
			<tr>
				<th>동물 종</th>
				<td>${pA.animal['kind']}</td>
			</tr>
			<tr>
				<th>동물 성별</th>
				<td>${pA.animal['gender']}</td>
			</tr>
			<tr>
				<th>동물 나이</th>
				<td>${pA.animal['age']}</td>
			</tr>
			<tr>
				<th>건강상태</th>
				<td>${pA.animal['health']}</td>
			</tr>
			<tr>
				<th>백신 접종 여부</th>
				<td>${pA.animal['vaccination']}</td>
			</tr>
			<tr>
				<th>작성자 희망 조건 사항</th>
				<td>${pA.postContent}</td>
			</tr>
		</table>

		<c:if test="${pA.approval==0}">
			<div class="pm-actions">
				<%
				if(session.getAttribute("loginId") != null) {// 입양일 경우 %>
					<c:if test="${pA.aType==1 || pA.aType==2}">
						<a class="pm-btn" href="<c:url value='/community/adopt_community/apply_form'><c:param name="postId" value="${pA.postId}"></c:param></c:url>">입양 신청</a>
					</c:if>
				<%}%>
				<%	if(session.getAttribute("loginId") != null) //임보일 경우
				{
				%>
					<c:if test="${pA.aType==0 || pA.aType==2}">
						<a class="pm-btn-line" href="<c:url value='/community/adopt_community/apply_form2'><c:param name="postId" value="${pA.postId}"></c:param></c:url>">임보 신청</a>
					</c:if>
				<%}%>
			</div>
		</c:if>
	</div>
</div>
</form>
</body>
</html>
