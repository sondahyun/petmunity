<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<CommentInformation> c0List = (ArrayList<CommentInformation>)request.getAttribute("c0List");
	ArrayList<String> p0List = (ArrayList<String>)request.getAttribute("p0List");
	ArrayList<CommentPetstargram> c2List = (ArrayList<CommentPetstargram>)request.getAttribute("c2List");
	ArrayList<String> p2List = (ArrayList<String>)request.getAttribute("p2List");
	String loginId = (String)request.getAttribute("loginId");
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
	<h1 class="pm-page-title">댓글 모아보기</h1>
	<p class="pm-page-sub">내가 작성한 댓글을 커뮤니티별로 모았습니다.</p>

	<div style="display:flex; gap:28px; align-items:flex-start; flex-wrap:wrap">
		<div style="flex:0 0 220px">
			<%@include file="/WEB-INF/myPage/myPage_info_mini.jsp"%>
		</div>
		<div style="flex:1; min-width:0">

			<div class="pm-panel" style="margin-bottom:22px">
				<h2 style="font-size:18px; margin:0 0 14px">정보 커뮤니티 댓글</h2>
				<%if (c0List.isEmpty()){%>
					<p class="pm-note">작성한 댓글이 없습니다</p>
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
						<c:forEach var="c0" items="${c0List}" varStatus = "status">
						<tr>
							<td>${c0.commentId}</td>
							<td>
								<a href="<c:url value='/community/info_community/info_content'>
								<c:param name='postId' value='${c0.postId}'/>
								</c:url>">${p0List[status.index]}</a>
							</td>
							<td>${loginId}</td>
							<td>${c0.commentDate}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<%}%>
			</div>

			<div class="pm-panel">
				<h2 style="font-size:18px; margin:0 0 14px">펫스타그램 커뮤니티 댓글</h2>
				<%if (c2List.isEmpty()){%>
					<p class="pm-note">작성한 댓글이 없습니다</p>
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
						<c:forEach var="c2" items="${c2List}" varStatus = "status">
						<tr>
							<td>${c2.commentId}</td>
							<td>
								<a href="<c:url value='/community/petstar_community/petstar_content'>
								<c:param name='postId' value='${c2.postId}'/>
								</c:url>">${p2List[status.index]}</a>
							</td>
							<td>${loginId}</td>
							<td>${c2.commentDate}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<%}%>
			</div>

		</div>
	</div>
</div>
</body>

</html>
