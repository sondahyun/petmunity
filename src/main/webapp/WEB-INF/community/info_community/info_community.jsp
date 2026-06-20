<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*" import="model.*" import="controller.user.UserSessionUtils" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<PostInformation> p0List = (ArrayList<PostInformation>)request.getAttribute("p0List");
	Collections.sort(p0List);
%>
<c:set var="size" value="${p0List.size()}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>정보 커뮤니티</title>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page wide">
	<div class="pm-toolbar">
		<h1 class="pm-page-title">정보 커뮤니티</h1>
		<% if(session.getAttribute("loginId") != null) {%>
			<a class="pm-btn" href="<c:url value='/community/info_community/add_content' />">글쓰기</a>
		
			<% } else { %>
				<a class="pm-btn" href="<c:url value='/user/login/form' />">글쓰기</a>
			<% } %>
	</div>

	<table class="pm-list">
		<colgroup>
			<col width="12%" />
			<col width="50%" />
			<col width="20%" />
			<col width="18%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일자</th>
			</tr>
		</thead>
		<tbody>
		<% int index = 0; %>
		<c:forEach var="item" items="${p0List}" varStatus="i">
			<%String findUser = p0List.get(index).getLoginId();%>
			<c:set var="userName" value="<%=UserSessionUtils.getUserNickName(findUser) %>"/>
			<tr>
				<td>${size - i.index}</td>
				<td>
					<a href="<c:url value='/community/info_community/info_content'>
						<c:param name='postId' value='${item.postId}'/></c:url>">${item.postTitle}</a>
				</td>
				<td>${userName}</td>
				<td>${item.postDate}</td>
			</tr>
			<%index++; %>
		</c:forEach>
		<c:if test="${size == 0}">
			<tr><td colspan="4" style="text-align:center; color:var(--pm-muted); padding:44px 0;">아직 등록된 글이 없습니다.</td></tr>
		</c:if>
		</tbody>
	</table>
</div>
</body>
</html>
