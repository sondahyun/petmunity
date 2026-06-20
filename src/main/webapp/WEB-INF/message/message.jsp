<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%
String check="Y";
if(request.getMethod().equals("POST")){
	check = request.getParameter("newMessgeChk");
	System.out.println(check);
}

List<Message> mList = (List<Message>)request.getAttribute("mList");
%>
<html>
<head>
<title>쪽지 목록</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page wide">
	<h1 class="pm-page-title">받은 쪽지함</h1>
	<p class="pm-page-sub">주고받은 쪽지를 확인하세요.</p>

	<div class="pm-toolbar">
		<div class="pm-inline">
			<a class="pm-link-more" href="<c:url value='/message/message' />">받은 쪽지함</a>
			<a class="pm-link-more" href="<c:url value='/message/message2' />">보낸 쪽지함</a>
		</div>
		<a class="pm-btn" href="<c:url value='/message/message_write' />">쪽지쓰기</a>
	</div>

	<table class="pm-list" summary="받은쪽지 목록(번호,제목,보낸사람,날짜 항목)">
		<thead>
			<tr>
				<th style="width:15%">번호</th>
				<th style="width:45%">제목</th>
				<th style="width:20%">보낸사람</th>
				<th style="width:20%">날짜</th>
			</tr>
		</thead>
		<tbody>
			<% int index = 0; %>
			<c:forEach var="message" items="${mList}" varStatus = "i">
				<% int findSender = mList.get(index).getSender();%>
				<tr>
					<td>${message.messageId}</td>
					<td>
						<a href="<c:url value='/message/message_content'>
							<c:param name='messageId' value='${message.messageId}'/>
						</c:url>">${message.mTitle}</a>
					</td>
					<td>
						<%
						String userNickName = UserSessionUtils.getUserNickName(findSender);
						%>
						<%=userNickName %>
					</td>
					<td>${message.sendDate}</td>
				</tr>
				<%index++; %>
			</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>
