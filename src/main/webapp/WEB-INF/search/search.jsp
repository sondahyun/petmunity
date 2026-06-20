<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" import="controller.user.UserSessionUtils" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	int comm = Integer.parseInt((String)request.getAttribute("comm"));
	String word = request.getParameter("word");      // null이면 아직 검색 전
	boolean searched = (word != null);
	String wordVal = (word == null) ? "" : word;
	String ctx = request.getContextPath();

	ArrayList<PostInformation> p0List = (ArrayList<PostInformation>)request.getAttribute("p0List");
	ArrayList<PostGroup> p1List = (ArrayList<PostGroup>)request.getAttribute("p1List");
	ArrayList<PostPetstargram> p2List = (ArrayList<PostPetstargram>)request.getAttribute("p2List");
	ArrayList<PostAdoption> p3List = (ArrayList<PostAdoption>)request.getAttribute("p3List");
	if (p0List == null) p0List = new ArrayList<PostInformation>();
	if (p1List == null) p1List = new ArrayList<PostGroup>();
	if (p2List == null) p2List = new ArrayList<PostPetstargram>();
	if (p3List == null) p3List = new ArrayList<PostAdoption>();
	Collections.sort(p0List); Collections.sort(p1List); Collections.sort(p2List); Collections.sort(p3List);

	int total = 0;
	if (comm==0 || comm==1) total += p3List.size();
	if (comm==0 || comm==2) total += p2List.size();
	if (comm==0 || comm==3) total += p1List.size();
	if (comm==0 || comm==4) total += p0List.size();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>통합 검색</title>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page wide">
	<h1 class="pm-page-title">통합 검색</h1>
	<p class="pm-page-sub">키워드로 커뮤니티 글을 한 번에 찾아보세요.</p>

	<form name="searchForm" method="get" action="<c:url value='/search/search'/>">
		<div class="pm-inline" style="gap:10px;">
			<select class="pm-select" name="community" style="width:auto;">
				<option value="0" <%= comm==0?"selected":"" %>>전체</option>
				<option value="1" <%= comm==1?"selected":"" %>>입양·임보</option>
				<option value="2" <%= comm==2?"selected":"" %>>펫스타그램</option>
				<option value="3" <%= comm==3?"selected":"" %>>그룹</option>
				<option value="4" <%= comm==4?"selected":"" %>>정보</option>
			</select>
			<input class="pm-input" type="text" name="word" placeholder="검색어를 입력하세요" value="<%= wordVal %>" style="flex:1; min-width:220px;">
			<button class="pm-btn" type="submit">검색</button>
		</div>
		<details style="margin-top:12px;">
			<summary class="pm-note" style="cursor:pointer;">기간으로 좁히기 (선택)</summary>
			<div class="pm-inline" style="margin-top:12px;">
				<input class="pm-input" type="date" name="start" value="2000-01-01" style="width:auto;">
				<span>~</span>
				<input class="pm-input" type="date" name="end" value="3000-01-01" style="width:auto;">
			</div>
		</details>
	</form>

	<% if (searched) { %>
		<div class="pm-toolbar" style="margin-top:28px; border-bottom:1px solid var(--pm-hair); padding-bottom:12px;">
			<h2 class="pm-page-title" style="font-size:20px; margin:0;">검색 결과 <span style="color:var(--pm-muted); font-weight:400;"><%= total %>건</span></h2>
		</div>
		<% if (total == 0) { %>
			<p style="color:var(--pm-muted); font-size:15px; padding:36px 0; text-align:center;">검색 결과가 없습니다.</p>
		<% } else { %>
			<table class="pm-list">
				<colgroup>
					<col width="14%" /><col width="48%" /><col width="20%" /><col width="18%" />
				</colgroup>
				<thead>
					<tr><th>구분</th><th>제목</th><th>작성자</th><th>등록일자</th></tr>
				</thead>
				<tbody>
				<% if (comm==0 || comm==1) for (PostAdoption p : p3List) { %>
					<tr><td>입양·임보</td>
						<td><a href="<%= ctx %>/community/adopt_community/adopt_info?postId=<%= p.getPostId() %>"><%= p.getPostTitle() %></a></td>
						<td><%= UserSessionUtils.getUserNickName(p.getLoginId()) %></td>
						<td><%= p.getPostDate() %></td></tr>
				<% } %>
				<% if (comm==0 || comm==2) for (PostPetstargram p : p2List) { %>
					<tr><td>펫스타그램</td>
						<td><a href="<%= ctx %>/community/petstar_community/petstar_content?postId=<%= p.getPostId() %>"><%= p.getPostTitle() %></a></td>
						<td><%= UserSessionUtils.getUserNickName(p.getLoginId()) %></td>
						<td><%= p.getPostDate() %></td></tr>
				<% } %>
				<% if (comm==0 || comm==3) for (PostGroup p : p1List) { %>
					<tr><td>그룹</td>
						<td><a href="<%= ctx %>/community/group_community/group_content?postId=<%= p.getPostId() %>"><%= p.getPostTitle() %></a></td>
						<td><%= UserSessionUtils.getUserNickName(p.getLoginId()) %></td>
						<td><%= p.getPostDate() %></td></tr>
				<% } %>
				<% if (comm==0 || comm==4) for (PostInformation p : p0List) { %>
					<tr><td>정보</td>
						<td><a href="<%= ctx %>/community/info_community/info_content?postId=<%= p.getPostId() %>"><%= p.getPostTitle() %></a></td>
						<td><%= UserSessionUtils.getUserNickName(p.getLoginId()) %></td>
						<td><%= p.getPostDate() %></td></tr>
				<% } %>
				</tbody>
			</table>
		<% } %>
	<% } else { %>
		<p style="color:var(--pm-muted); font-size:15px; padding:40px 0; text-align:center;">검색어를 입력하면 결과가 여기에 표시됩니다.</p>
	<% } %>
</div>
</body>
</html>
