<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*" import="model.*" import="controller.user.UserSessionUtils" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	@SuppressWarnings("unchecked")
	ArrayList<PostInformation> p0List = (ArrayList<PostInformation>)request.getAttribute("p0List");
	Collections.sort(p0List);
%>
<c:set var="size" value="${p0List.size()}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>community</title>
</head>

<body>
<%@include file="/WEB-INF/navbar.jsp" %>

<div class="pm-page wide">
	<div class="pm-toolbar">
		<h1 class="pm-page-title">정보 커뮤니티</h1>
		<% if(session.getAttribute("loginId") != null) {%>
			<a class="pm-btn" href="<c:url value='/community/info_community/add_content' />">폼 작성</a>
		<%} %>
	</div>

	<div class="pm-toolbar" style="align-items:flex-start;">
		<div style="flex:0 0 auto;">
			<%@include file="/WEB-INF/myPage/myPage_include.jsp" %>
		</div>

		<div style="flex:1 1 480px; min-width:320px;">
			<table class="pm-list">
				<colgroup>
					<col width="15%" />
					<col width="45%" />
					<col width="20%" />
					<col width="20%" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>이름</th>
						<th>등록일자</th>
					</tr>
				</thead>
				<tbody>
				<% int index = 0; %>
				<c:forEach var="item" items="${p0List}" varStatus="i">
					<%String findUser = p0List.get(index).getLoginId();%>
					<c:set var="userName" value="<%=UserSessionUtils.getUserNickName(findUser) %>"/>
					<tr>
						<td>${size-i.index}</td>
						<td>
							<a href="<c:url value='/community/info_community/info_content'>
									<c:param name='postId' value='${item.postId}'/>
								</c:url>">${item.postTitle}</a>
						</td>
						<td>${userName}</td>
						<td>${item.postDate}</td>
					</tr>
					<%index++; %>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>

</html>
