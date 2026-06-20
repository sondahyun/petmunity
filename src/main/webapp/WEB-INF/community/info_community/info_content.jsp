<!--입양, 임보 펫 정보-->
<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   @SuppressWarnings("unchecked")
   PostInformation post = (PostInformation)request.getAttribute("post");
	ArrayList<CommentInformation> c0List = (ArrayList<CommentInformation>)request.getAttribute("c0List");
	String lId=UserSessionUtils.getLoginId(session);
	Collections.sort(c0List);
%>
<c:set var="pId" value="<%=post.getPostId() %>"/>

<html>
<head>
<title>정보 게시글</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
	.pm-comment-form{ display:flex; gap:12px; align-items:flex-start; margin-bottom:14px; }
	.pm-comment-form .pm-comment-author{ flex:0 0 110px; font-size:14px; font-weight:600; color:var(--pm-ink); padding-top:12px; }
	.pm-comment-form .pm-input{ flex:1; }
	.pm-comments{ display:flex; flex-direction:column; gap:14px; }
	.pm-comment{ border:1px solid var(--pm-hair); border-radius:12px; padding:14px 16px; }
	.pm-comment-head{ display:flex; justify-content:space-between; align-items:center; gap:10px; margin-bottom:8px; }
	.pm-comment-name{ font-size:14px; font-weight:600; color:var(--pm-ink); }
	.pm-comment-date{ font-size:13px; color:var(--pm-muted); }
	.pm-comment-edit{ display:flex; gap:10px; align-items:center; flex-wrap:wrap; }
	.pm-comment-edit .pm-input{ flex:1; min-width:200px; }
	.pm-comment-edit form{ display:inline; }
	.pm-empty{ color:var(--pm-muted); font-size:15px; padding:24px 0; text-align:center; }
</style>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page">
	<div class="pm-toolbar">
		<div>
			<h1 class="pm-page-title">정보 게시글</h1>
			<p class="pm-page-sub">입양·임보 반려동물 정보</p>
		</div>
		<%if(lId.equals(post.getLoginId())){ %>
			<div class="pm-actions">
				<a class="pm-btn-line"
					href="<c:url value='/community/info_community/info_content_update'><c:param name='postId' value='${post.postId}'/></c:url>">수정</a>
				<a class="pm-btn-danger"
					href="<c:url value='/community/info_community/info_content_delete'><c:param name='postId' value='${post.postId}'/></c:url>">삭제</a>
			</div>
		<%} %>
	</div>

	<div class="pm-panel">
		<% if(post.getFileName() == null){%>
			<img class="pm-media" src="<c:url value='/images/linkedin_profile_image.png' />" alt="대표 이미지" />
		<%}
		else{%>
			<img class="pm-media" src="<c:url value='/image?file=${post.fileName}'/>" alt="${post.postTitle}" />
		<%} %>

		<table class="pm-detail">
			<tr>
				<th>제목</th>
				<td>${post.postTitle}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<% String logName = post.getLoginId(); %>
					<c:set var="loginName" value="<%=UserSessionUtils.getUserNickName(logName) %>"/>
					${loginName}
				</td>
			</tr>
			<tr>
				<th>작성일자</th>
				<td>${post.postDate}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${post.postContent}</td>
			</tr>
			<tr>
				<th>종</th>
				<td>${post.kind}</td>
			</tr>
		</table>
	</div>

	<h2 class="pm-page-title" style="font-size:22px; margin:40px 0 16px;">댓글 작성하기</h2>
	<form name="cmForm" class="pm-comment-form" method="post" action="<c:url value='/community/info_community/add_comment'><c:param name='postId' value='${post.postId}'/></c:url>">
		<%
		int loginUserId = UserSessionUtils.getLoginUserId(session);
		%>
		<c:set var="lui" value="<%=UserSessionUtils.getUserNickName(loginUserId) %>"/>
		<div class="pm-comment-author">${lui}</div>
		<input class="pm-input" type="text" name="commentContent" placeholder="댓글을 입력하세요.">
		<input class="pm-btn" type="submit" value="댓글 작성">
	</form>

	<h2 class="pm-page-title" style="font-size:22px; margin:40px 0 16px;">댓글 목록</h2>
	<div class="pm-comments">
		<% int index=0; %>
		<c:forEach var="item" items="${c0List}">
			<%
				int findUser = c0List.get(index).getUserId();
			%>
			<c:set var="userName" value="<%=UserSessionUtils.getUserNickName(findUser) %>"/>
			<c:if test="${item.postId == pId}">
				<div class="pm-comment">
					<div class="pm-comment-head">
						<span class="pm-comment-name">${userName}</span>
						<span class="pm-comment-date">작성일: ${item.commentDate}</span>
					</div>
					<c:if test="${uId != item.userId}">
						<input class="pm-input" type="text" value="${item.commentContent}" readonly>
					</c:if>
					<c:if test="${uId == item.userId}">
						<div class="pm-comment-edit">
							<form name="frmU" method="post" action="<c:url value='/community/info_community/update_comment'><c:param name="postId" value="${pId}"></c:param><c:param name='commentId' value='${item.commentId}'></c:param></c:url>">
								<input class="pm-input" name="commentContent" type="text" value="${item.commentContent}">
								<input class="pm-btn-line" type="submit" value="댓글 수정">
							</form>
							<form name="frmD" method="post" action="<c:url value='/community/info_community/delete_comment'><c:param name="postId" value="${pId}"></c:param><c:param name='commentId' value='${item.commentId}'></c:param></c:url>">
								<input class="pm-btn-danger" type="submit" value="댓글 삭제">
							</form>
						</div>
					</c:if>
				</div>
			</c:if>
			<%index++; %>
		</c:forEach>
	</div>
	<c:if test="${empty c0List}">
		<p class="pm-empty">아직 작성된 댓글이 없습니다.</p>
	</c:if>
</div>
</body>
</html>
