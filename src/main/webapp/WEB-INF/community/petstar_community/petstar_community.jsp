<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*" import="model.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	@SuppressWarnings("unchecked")
	ArrayList<PostPetstargram> p2List = (ArrayList<PostPetstargram>)request.getAttribute("p2List");
	Collections.sort(p2List);
	System.out.println(p2List.size());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>펫스타그램 커뮤니티</title>
<style>
	.pm-cards{ display:grid; grid-template-columns:repeat(auto-fill,minmax(220px,1fr)); gap:22px; }
	.pm-card{ display:block; background:#fff; border:1px solid var(--pm-hair); border-radius:16px; overflow:hidden; text-decoration:none; color:var(--pm-ink); transition:transform .15s ease, box-shadow .2s ease; }
	.pm-card:hover{ transform:translateY(-2px); box-shadow:0 8px 24px rgba(0,0,0,0.08); }
	.pm-card-img{ width:100%; aspect-ratio:1/1; overflow:hidden; background:var(--pm-parch); }
	.pm-card-img img{ width:100%; height:100%; object-fit:cover; display:block; }
	.pm-card-body{ padding:14px 16px 18px; }
	.pm-card-title{ font-size:16px; font-weight:600; letter-spacing:-0.01em; margin:0 0 6px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
	.pm-card-meta{ font-size:13px; color:var(--pm-muted); }
	.pm-empty{ color:var(--pm-muted); font-size:15px; padding:40px 0; text-align:center; }
</style>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page wide">
	<div class="pm-toolbar">
		<div>
			<h1 class="pm-page-title">펫스타그램</h1>
			<p class="pm-page-sub">반려동물의 일상을 사진으로 공유해요.</p>
		</div>
		<% if(session.getAttribute("loginId") != null) {%>
			<a class="pm-btn" href="<c:url value='/community/petstar_community/add_content' />">글 작성</a>
		
			<% } else { %>
				<a class="pm-btn" href="<c:url value='/user/login/form' />">글 작성</a>
			<% } %>
	</div>

	<div class="pm-cards">
		<% int index = 0; %>
		<c:forEach var="item" varStatus="i" items="${p2List}">
			<%
				String findUser = p2List.get(index).getLoginId();
				String file = p2List.get(index).getFileName();
			%>
			<c:set var="userName" value="<%=UserSessionUtils.getUserNickName(findUser) %>"/>
			<a class="pm-card" href="<c:url value='/community/petstar_community/petstar_content'><c:param name='postId' value='${item.postId}'/></c:url>">
				<div class="pm-card-img">
					<%if(file != null) {%>
						<img src="<c:url value='/image?file=${item.fileName}'/>" alt="${item.postTitle}" />
					<%} else{%>
						<img src="<c:url value='/images/linkedin_profile_image.png'/>" alt="${item.postTitle}" />
					<%} %>
				</div>
				<div class="pm-card-body">
					<div class="pm-card-title">${item.postTitle}</div>
					<div class="pm-card-meta">${userName}</div>
				</div>
			</a>
			<%index++; %>
		</c:forEach>
	</div>
	<c:if test="${empty p2List}">
		<p class="pm-empty">아직 등록된 펫스타그램 게시글이 없습니다.</p>
	</c:if>
</div>
</body>
</html>
