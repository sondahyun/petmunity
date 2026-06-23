<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%Message message = (Message) request.getAttribute("message"); %>
<!DOCTYPE html>
<html>
<head>
<title>쪽지 상세보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
	function userList(targetUri) {
	   form.action = targetUri;
	   form.submit();   //get
	}
</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page narrow">
	<h1 class="pm-page-title">쪽지 상세보기</h1>

	<form name="form" method="POST" action="<c:url value='/message/message_write' />">
		<table class="pm-detail">
			<tr>
				<th>제목</th>
				<td>${message.mTitle}</td>
			</tr>
			<tr>
				<th>보낸 사람</th>
				<td>
					<%
					int findSender = message.getSender();
					String senderNickName = UserSessionUtils.getUserNickName(findSender);
					%>
					<%=senderNickName %>
				</td>
			</tr>
			<tr>
				<th>받는 사람</th>
				<td>
					<%
					int findReceiver = message.getReceiver();
					String receiverNickName = UserSessionUtils.getUserNickName(findReceiver);
					%>
					<%=receiverNickName %>
				</td>
			</tr>
			<tr>
				<th>보낸 날짜</th>
				<td>${message.sendDate}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${message.content}</td>
			</tr>
		</table>
		<div class="pm-actions">
			<input class="pm-btn-line" type="button" value="목록보기" onClick="userList('<c:url value='/message/message' />')">
			<a class="pm-btn-danger" href="<c:url value='/message/message_delete'><c:param name='messageId' value='${message.messageId}'/></c:url>" onclick="return confirm('이 쪽지를 삭제하시겠습니까?');">삭제</a>
		</div>
	</form>
</div>
</body>
</html>
