<!--입양, 임보 펫 정보-->
<%@page contentType="text/html; charset=utf-8" import="model.*"
	import="java.util.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
@SuppressWarnings("unchecked")
PostPetstargram p2 = (PostPetstargram) request.getAttribute("p2");

ArrayList<CommentPetstargram> c2List = (ArrayList<CommentPetstargram>) request.getAttribute("c2List");
if (c2List != null)
	Collections.sort(c2List);
String lId=UserSessionUtils.getLoginId(session);
%>
<c:set var="pId" value="${p2.postId}" />
<c:set var="uId" value="<%= UserSessionUtils.getLoginUserId(session) %>"/>
<html>
<head>
<title>펫스타그램 폼</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp"%>
<div class="pm-page">
	<h1 class="pm-page-title">펫스타그램</h1>
	<p class="pm-page-sub">반려동물의 일상을 함께 나눠요.</p>

	<!-- 작성자 == 방문자일때 폼 수정/삭제 버튼 뜸 -->
	<%if(lId.equals(p2.getLoginId())){ %>
	<div class="pm-actions" style="margin-bottom:22px">
		<a class="pm-btn-line"
			href="<c:url value='/community/petstar_community/petstar_content_update'><c:param name='postId' value='${p2.postId}'/></c:url>">폼 수정</a>
		<a class="pm-btn-danger"
			href="<c:url value='/community/petstar_community/petstar_content_delete'><c:param name='postId' value='${p2.postId}'/></c:url>">폼 삭제</a>
	</div>
	<%} %>

	<div class="pm-panel">
		<% if(p2.getFileName() == null){%>
			<img class="pm-media" src="<c:url value='/images/linkedin_profile_image.png' />" alt="펫스타 이미지" />
		<%} else{%>
			<img class="pm-media" src="<c:url value='/image?file=${p2.fileName}'/>" alt="펫스타 이미지" />
		<%} %>

		<table class="pm-detail">
			<tr>
				<th>제목</th>
				<td>${p2.postTitle}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<% String logName = p2.getLoginId(); %>
					<c:set var="loginName" value="<%=UserSessionUtils.getUserNickName(logName) %>"/>
					${loginName}
				</td>
			</tr>
			<tr>
				<th>종</th>
				<td>${p2.kind}</td>
			</tr>
			<tr>
				<th>작성일자</th>
				<td>${p2.postDate}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${p2.postContent}</td>
			</tr>
		</table>
	</div>

	<!-- 댓글 작성 -->
	<h2 class="pm-page-title" style="font-size:22px; margin:40px 0 16px">댓글 작성하기</h2>
	<%
		int loginUserId = UserSessionUtils.getLoginUserId(session);
	%>
	<c:set var="lui" value="<%=UserSessionUtils.getUserNickName(loginUserId) %>"/>
	<div class="pm-panel">
		<form name="cmForm" method="post"
			action="<c:url value='/community/petstar_community/add_comment'><c:param name='postId' value='${p2.postId}'/></c:url>"
			class="pm-form">
			<div class="pm-field">
				<label class="pm-label">${lui}</label>
				<input type="text" name="commentContent" class="pm-input" placeholder="댓글을 입력하세요.">
			</div>
			<div class="pm-actions">
				<input type="submit" class="pm-btn" value="댓글 작성">
			</div>
		</form>
	</div>

	<!-- 댓글 목록 -->
	<h2 class="pm-page-title" style="font-size:22px; margin:40px 0 16px">댓글 목록</h2>
	<table class="pm-list">
		<thead>
			<tr>
				<th style="width:140px">작성자</th>
				<th>내용</th>
				<th style="width:160px">관리</th>
			</tr>
		</thead>
		<tbody>
			<% int index=0; %>
			<c:forEach var="item" items="${c2List}">
				<%
					int findUser = c2List.get(index).getUserId();
				%>
				<c:set var="userName" value="<%=UserSessionUtils.getUserNickName(findUser) %>"/>
				<c:if test="${item.postId == pId}">
					<c:if test="${uId != item.userId}">
						<tr>
							<td>${userName}</td>
							<td>${item.commentContent}</td>
							<td><span class="pm-note">${item.commentDate}</span></td>
						</tr>
					</c:if>
					<c:if test="${uId == item.userId}">
						<tr>
							<td>${userName}</td>
							<td>
								<form name="frmU" method="post" action="<c:url value='/community/petstar_community/update_comment'><c:param name="postId" value="${pId}"></c:param><c:param name='commentId' value='${item.commentId}'></c:param></c:url>" class="pm-inline">
									<input name="commentContent" type="text" value="${item.commentContent}" class="pm-input">
									<input type="submit" class="pm-btn-line" value="댓글 수정">
								</form>
							</td>
							<td>
								<form name="frmD" method="post" action="<c:url value='/community/petstar_community/delete_comment'><c:param name="postId" value="${pId}"></c:param><c:param name='commentId' value='${item.commentId}'></c:param></c:url>">
									<input type="submit" class="pm-btn-danger" value="댓글 삭제">
								</form>
								<div class="pm-note" style="margin-top:6px">작성일: ${item.commentDate}</div>
							</td>
						</tr>
					</c:if>
				</c:if>
				<%index++; %>
			</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>
