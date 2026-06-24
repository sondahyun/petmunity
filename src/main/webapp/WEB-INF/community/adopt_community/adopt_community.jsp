<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*" import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	@SuppressWarnings("unchecked")
	ArrayList<PostAdoption> p3List = (ArrayList<PostAdoption>)request.getAttribute("p3List");
	Collections.sort(p3List);
	System.out.println(p3List.size());

	if(session.getAttribute("postId")!=null)
		session.removeAttribute("postId");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>입양/임보 게시판 메인화면</title>
<style>
	.pm-cards{ display:grid; grid-template-columns:repeat(3,1fr); gap:18px; }
	@media(max-width:639px){ .pm-cards{ grid-template-columns:repeat(2,1fr); } }
	.pm-card{ display:block; background:#fff; border:1px solid var(--pm-hair); border-radius:14px; overflow:hidden; text-decoration:none; color:inherit; transition:transform .15s ease, box-shadow .15s ease; }
	.pm-card:hover{ transform:translateY(-2px); box-shadow:rgba(0,0,0,0.09) 0 6px 18px; }
	.pm-card-img{ width:100%; height:200px; background:var(--pm-parch); overflow:hidden; }
	.pm-card-img img{ display:block; width:100%; height:100%; object-fit:cover; }
	.pm-card-body{ padding:14px 16px 16px; }
	.pm-card-title{ font-size:16px; font-weight:600; letter-spacing:-0.01em; color:var(--pm-ink); margin-bottom:8px; }
	.pm-card-meta{ font-size:13.5px; color:var(--pm-muted); display:flex; gap:14px; flex-wrap:wrap; }
	.pm-card-meta span b{ font-weight:600; color:var(--pm-ink); }
</style>
</head>

<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page wide">
	<div class="pm-toolbar">
		<div>
			<h1 class="pm-page-title">입양·임보</h1>
			<p class="pm-page-sub">새 가족을 기다리는 아이들을 만나보세요.</p>
		</div>
		<% if(session.getAttribute("loginId") != null) {%>
			<a class="pm-btn" href="<c:url value='/community/adopt_community/adopt_community/add_content' />">글쓰기</a>
		
			<% } else { %>
				<a class="pm-btn" href="<c:url value='/user/login/form' />">글쓰기</a>
			<% } %>
	</div>

	<div class="pm-cards">
		<%int cnt=0; %>
		<% int index = 0; %>
		<c:forEach var="item" varStatus="i" items="${p3List}">
		<%
			String file = p3List.get(index).getAnimal().getFilename();
		%>
		<a class="pm-card" href="<c:url value='/community/adopt_community/adopt_info'>
				<c:param name='postId' value='${item.postId}'/></c:url>">
			<div class="pm-card-img">
				<%if(file != null) {%>
					<img src="<c:url value='/image?file=${item.animal.filename}'/>" alt="">
				<%} else{%>
					<img src="<c:url value='/images/logo_transparent.png'/>" alt="">
				<%} %>
			</div>
			<div class="pm-card-body">
				<div class="pm-card-title">${item.animal["kind"]}</div>
				<div class="pm-card-meta">
					<span><b>성별</b> ${item.animal["gender"]}</span>
					<span><b>나이</b> ${item.animal["age"]}</span>
				</div>
			</div>
		</a>
		<%index++; %>
		</c:forEach>
	</div>
</div>
</body>
</html>
