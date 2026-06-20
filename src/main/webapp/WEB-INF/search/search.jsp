<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	int comm = Integer.parseInt((String)request.getAttribute("comm"));
	ArrayList<PostInformation> p0List = (ArrayList<PostInformation>)request.getAttribute("p0List");
	ArrayList<PostGroup> p1List = (ArrayList<PostGroup>)request.getAttribute("p1List");
	ArrayList<PostPetstargram> p2List = (ArrayList<PostPetstargram>)request.getAttribute("p2List");
	ArrayList<PostAdoption> p3List = (ArrayList<PostAdoption>)request.getAttribute("p3List");

	if(p0List != null) Collections.sort(p0List);
	if(p1List != null) Collections.sort(p1List);
	if(p2List != null) Collections.sort(p2List);
	if(p3List != null) Collections.sort(p3List);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>search</title>
<script>
function search()
{
	/* if(searchForm.word.value==""){
		alert("검색어를 입력하세요");
		return false;
	}
	else if(searchForm.start.value=="" || searchForm.end.value==""){
		alert("날짜조건을 입력하세요");
		return false;
	} */
	else searchForm.submit();

}

</script>
</head>

<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page wide">
	<h1 class="pm-page-title">통합 검색</h1>
	<p class="pm-page-sub">기간과 검색어로 커뮤니티 글을 찾아보세요.</p>

	<form name="searchForm" action="<c:url value='/search/search'/>">
		<div class="pm-toolbar">
			<div class="pm-inline">
				<input class="pm-input" type="date" name="start" value="2022-12-01">
				<span>-</span>
				<input class="pm-input" type="date" name="end" value="3000-01-01">
			</div>
			<div class="pm-inline">
				<input class="pm-input" type="text" placeholder="검색어를 입력하세요." name="word">
				<button class="pm-btn" onClick="search()">검색</button>
			</div>
		</div>
	</form>

	<div class="pm-panel" style="margin-bottom:18px;">
		<%@include file="/WEB-INF/myPage/myPage_include.jsp" %>
	</div>

	<!-- 정보 커뮤니티 -->
	<h2 class="pm-page-sub" style="font-weight:600; color:var(--pm-ink); margin:28px 0 14px;">정보 커뮤니티</h2>
	<%if (p0List == null || (p0List!=null && p0List.size()==0) || (comm!=0&&comm!=4)){%>
		<p class="pm-page-sub">작성글이 없습니다</p>
	<% }else if(comm==0 || comm==4){ %>
	<table class="pm-list">
		<colgroup>
			<col width="15%" />
			<col width="45%" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>작성글</th>
				<th>이름</th>
				<th>등록일자</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="topN" value="false"/>
		<c:set var="size" value="${p0List.size()}"/>
			<c:forEach var="p0" items="${p0List}" varStatus="i">
				<c:if test="${i.index > 9}"><c:set var="topN" value="true"/></c:if>
				<c:if test="${topN==false}">
					<tr>
						<td>${size-i.index}</td>
						<td>
				          	<a href="<c:url value='/community/info_community/info_content'>
				          	<c:param name='postId' value='${p0.postId}'/>
				          	</c:url>">
				          	${p0.postTitle}</a>
			           	</td>
						<td>${p0.loginId}</td>
						<td>${p0.postDate}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<%}%>

	<!-- 그룹 커뮤니티 -->
	<h2 class="pm-page-sub" style="font-weight:600; color:var(--pm-ink); margin:28px 0 14px;">그룹 커뮤니티</h2>
	<%if (p1List == null || (p1List != null && p1List.size()==0) || (comm!=0&&comm!=3)){%>
		<p class="pm-page-sub">작성글이 없습니다</p>
	<% }else if (comm==0||comm==3){ %>
	<table class="pm-list">
		<colgroup>
			<col width="15%" />
			<col width="45%" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>작성글</th>
				<th>이름</th>
				<th>등록일자</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="topN" value="false"/>
		<c:set var="size" value="${p1List.size()}"/>
			<c:forEach var="p1" items="${p1List}" varStatus="i">
				<c:if test="${i.index > 9}"><c:set var="topN" value="true"/></c:if>
				<c:if test="${topN==false}">
					<tr>
						<td>${size-i.index}</td>
						<td>
				          	<a href="<c:url value='/community/group_community/group_content'>
				          	<c:param name='postId' value='${p1.postId}'/>
				          	</c:url>">
				          	${p1.postTitle}</a>
			           	</td>
						<td>${p1.loginId}</td>
						<td>${p1.postDate}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<%}%>

	<!-- 펫스타그램 커뮤니티 -->
	<h2 class="pm-page-sub" style="font-weight:600; color:var(--pm-ink); margin:28px 0 14px;">펫스타그램 커뮤니티</h2>
	<%if (p2List == null || (p2List == null && p2List.size()==0) || (comm!=0&&comm!=2)){%>
		<p class="pm-page-sub">작성글이 없습니다</p>
	<% }else if (comm==0||comm==2){ %>
	<table class="pm-list">
		<colgroup>
			<col width="15%" />
			<col width="45%" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>작성글</th>
				<th>이름</th>
				<th>등록일자</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="topN" value="false"/>
		<c:set var="size" value="${p2List.size()}"/>
			<c:forEach var="p2" items="${p2List}" varStatus="i">
				<c:if test="${i.index > 4}"><c:set var="topN" value="true"/></c:if>
				<c:if test="${topN==false}">
					<tr>
						<td>${size-i.index}</td>
						<td>
				          	<a href="<c:url value='/community/petstar_community/petstar_content'>
				          	<c:param name='postId' value='${p2.postId}'/>
				          	</c:url>">
				          	${p2.postTitle}</a>
			           	</td>
						<td>${p2.loginId}</td>
						<td>${p2.postDate}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<%}%>

	<!-- 입양/임보 커뮤니티 -->
	<h2 class="pm-page-sub" style="font-weight:600; color:var(--pm-ink); margin:28px 0 14px;">입양/임보 커뮤니티</h2>
	<%if (p3List == null || (p3List == null && p3List.size()==0) || (comm!=1)){%>
		<p class="pm-page-sub">작성글이 없습니다</p>
	<% }else if (comm==0||comm==1){ %>
	<table class="pm-list">
		<colgroup>
			<col width="15%" />
			<col width="45%" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>작성글</th>
				<th>이름</th>
				<th>등록일자</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="topN" value="false"/>
		<c:set var="size" value="${p3List.size()}"/>
			<c:forEach var="p3" items="${p3List}" varStatus="i">
				<c:if test="${i.index > 9}"><c:set var="topN" value="true"/></c:if>
				<c:if test="${topN==false}">
					<tr>
						<td>${size-i.index}</td>
						<td>
				          	<a href="<c:url value='/community/adopt_community/adopt_info'>
				          	<c:param name='postId' value='${p3.postId}'/>
				          	</c:url>">
				          	${p3.postTitle}</a>
			           	</td>
						<td>${p3.loginId}</td>
						<td>${p3.postDate}</td>
					</tr>
				</c:if>
			</c:forEach>
		</tbody>
	</table>
	<%}%>
</div>
<!-- 테이블 종료 -->

</body>
</html>
