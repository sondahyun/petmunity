<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="model.*" import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
AdoptionAnimal adoptAnimal = (AdoptionAnimal) session.getAttribute("adoptAnimal");
ArrayList<Apply> aList = (ArrayList<Apply>) request.getAttribute("aList");
if (aList != null) Collections.sort(aList);
pageContext.setAttribute("adoptId", request.getAttribute("adoptId"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>신청자 모아보기</title>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp"%>
<div class="pm-page">
	<h1 class="pm-page-title">신청자 모아보기</h1>
	<p class="pm-page-sub">이 공고에 들어온 입양·임보 신청 목록입니다.</p>

	<div class="pm-panel" style="margin-bottom:24px;">
		<%@include file="/WEB-INF/community/adopt_community/adopt_main2.jsp"%>
	</div>

	<table class="pm-list">
		<thead>
			<tr><th>번호</th><th>이름</th><th>신청 타입</th><th>승인</th></tr>
		</thead>
		<tbody>
			<% boolean exist = false; %>
			<c:set var="size" value="${aList.size()}"/>
			<c:forEach var="item" varStatus="i" items="${aList}">
				<c:if test="${item.petId == adoptAnimal.petId}">
					<% exist = true; %>
					<tr>
						<td>${size - i.index}</td>
						<td>
							<a class="pm-link-more" href="<c:url value='/community/adopt_community/apply_result_closer'><c:param name='applyId' value='${item.applyId}'/><c:param name='adoptId' value='${adoptId}'/></c:url>">${item.name}</a>
						</td>
						<td><c:if test="${item.aType==0}">임보</c:if><c:if test="${item.aType==1}">입양</c:if></td>
						<td>
							<a class="pm-btn-line" href="<c:url value='/community/adopt_community/adopt_info'><c:param name='applyId' value='${item.applyId}'/><c:param name='adoptId' value='${adoptId}'/></c:url>">승인</a>
						</td>
					</tr>
				</c:if>
			</c:forEach>
			<% if (exist == false) out.println("<tr><td colspan='4' style='text-align:center; color:#86868b; padding:28px;'>아직 신청자가 없습니다.</td></tr>"); %>
		</tbody>
	</table>
</div>
</body>
</html>
