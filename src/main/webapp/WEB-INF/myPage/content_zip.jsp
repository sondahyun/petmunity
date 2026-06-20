<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<PostInformation> p0List = (ArrayList<PostInformation>)request.getAttribute("p0List");
	ArrayList<PostGroup> p1List = (ArrayList<PostGroup>)request.getAttribute("p1List");
	ArrayList<PostPetstargram> p2List = (ArrayList<PostPetstargram>)request.getAttribute("p2List");
	ArrayList<PostAdoption> p3List = (ArrayList<PostAdoption>)request.getAttribute("p3List");

%>

<!DOCTYPE html>
<html>
<head>
<title>myPage</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %><!-- 화면 로드 시 서버로부터 커뮤니티 목록을 가져와 commSelect 메뉴 생성 -->
<div class="pm-page wide">
	<h1 class="pm-page-title">작성글 모아보기</h1>
	<p class="pm-page-sub">내가 작성한 게시글을 커뮤니티별로 모았습니다.</p>

	<div style="display:flex; gap:28px; align-items:flex-start; flex-wrap:wrap">
		<div style="flex:0 0 220px">
			<%@include file="/WEB-INF/myPage/myPage_info_mini.jsp"%>
		</div>
		<div style="flex:1; min-width:0">

			<div class="pm-panel" style="margin-bottom:22px">
				<h2 style="font-size:18px; margin:0 0 14px">정보 커뮤니티</h2>
				<%if (p0List.isEmpty()){%>
					<p class="pm-note">작성글이 없습니다</p>
				<% }else{ %>
				<table class="pm-list">
					<thead>
						<tr>
							<th style="width:15%">번호</th>
							<th style="width:45%">작성글</th>
							<th style="width:20%">이름</th>
							<th style="width:20%">등록일자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p0" items="${p0List}">
							<tr>
								<td>${p0.postId}</td>
								<td>
									<a href="<c:url value='/community/info_community/info_content'>
									<c:param name='postId' value='${p0.postId}'/>
									</c:url>">${p0.postTitle}</a>
								</td>
								<td>${p0.loginId}</td>
								<td>${p0.postDate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<%} %>
			</div>

			<div class="pm-panel" style="margin-bottom:22px">
				<h2 style="font-size:18px; margin:0 0 14px">그룹 커뮤니티</h2>
				<%if (p1List.isEmpty()){%>
					<p class="pm-note">작성글이 없습니다</p>
				<% }else{ %>
				<table class="pm-list">
					<thead>
						<tr>
							<th style="width:15%">번호</th>
							<th style="width:45%">작성글</th>
							<th style="width:20%">이름</th>
							<th style="width:20%">등록일자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p1" items="${p1List}">
							<tr>
								<td>${p1.postId}</td>
								<td>
									<a href="<c:url value='/community/group_community/group_content'>
									<c:param name='postId' value='${p1.postId}'/>
									</c:url>">${p1.postTitle}</a>
								</td>
								<td>${p1.loginId}</td>
								<td>${p1.postDate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<%} %>
			</div>

			<div class="pm-panel" style="margin-bottom:22px">
				<h2 style="font-size:18px; margin:0 0 14px">펫스타그램 커뮤니티</h2>
				<%if (p2List.isEmpty()){%>
					<p class="pm-note">작성글이 없습니다</p>
				<% }else{ %>
				<table class="pm-list">
					<thead>
						<tr>
							<th style="width:15%">번호</th>
							<th style="width:45%">작성글</th>
							<th style="width:20%">이름</th>
							<th style="width:20%">등록일자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p2" items="${p2List}">
							<tr>
								<td>${p2.postId}</td>
								<td>
									<a href="<c:url value='/community/petstar_community/petstar_content'>
									<c:param name='postId' value='${p2.postId}'/>
									</c:url>">${p2.postTitle}</a>
								</td>
								<td>${p2.loginId}</td>
								<td>${p2.postDate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<%} %>
			</div>

			<div class="pm-panel">
				<h2 style="font-size:18px; margin:0 0 14px">입양/임보 커뮤니티</h2>
				<%if (p3List.isEmpty()){%>
					<p class="pm-note">작성글이 없습니다</p>
				<% }else{ %>
				<table class="pm-list">
					<thead>
						<tr>
							<th style="width:15%">번호</th>
							<th style="width:45%">작성글</th>
							<th style="width:20%">이름</th>
							<th style="width:20%">등록일자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p3" items="${p3List}">
							<tr>
								<td>${p3.postId}</td>
								<td>
									<a href="<c:url value='/community/adopt_community/adopt_info'>
									<c:param name='postId' value='${p3.postId}'/>
									</c:url>">${p3.postTitle}</a>
								</td>
								<td>${p3.loginId}</td>
								<td>${p3.postDate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<%} %>
			</div>

		</div>
	</div>
</div>
</body>

</html>
