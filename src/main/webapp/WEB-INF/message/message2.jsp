<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	List<Message> mList = (List<Message>)request.getAttribute("mList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>보낸 쪽지함</title>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page wide">
	<h1 class="pm-page-title">보낸 쪽지함</h1>
	<p class="pm-page-sub">내가 보낸 쪽지를 확인하세요.</p>

	<div class="pm-toolbar">
		<div class="pm-inline">
			<a class="pm-link-more" href="<c:url value='/message/message' />">받은 쪽지함</a>
			<a class="pm-link-more" href="<c:url value='/message/message2' />">보낸 쪽지함</a>
		</div>
		<a class="pm-btn" href="<c:url value='/message/message_write' />">쪽지쓰기</a>
	</div>

	<table class="pm-list" summary="보낸쪽지 목록(번호,제목,받는사람,날짜)">
		<thead>
			<tr>
				<th style="width:12%">번호</th>
				<th style="width:50%">제목</th>
				<th style="width:20%">받는 사람</th>
				<th style="width:18%">날짜</th>
			</tr>
		</thead>
		<tbody>
			<% int index = 0; %>
			<c:forEach var="message" items="${mList}" varStatus="i">
				<% int findReceiver = mList.get(index).getReceiver(); %>
				<tr>
					<td>${message.messageId}</td>
					<td>
						<a href="<c:url value='/message/message_content'>
							<c:param name='messageId' value='${message.messageId}'/></c:url>">${message.mTitle}</a>
					</td>
					<td><%= UserSessionUtils.getUserNickName(findReceiver) %></td>
					<td>${message.sendDate}</td>
				</tr>
				<%index++; %>
			</c:forEach>
			<c:if test="${empty mList}">
				<tr><td colspan="4" style="text-align:center; color:var(--pm-muted); padding:44px 0;">보낸 쪽지가 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
</div>
</body>
</html>
