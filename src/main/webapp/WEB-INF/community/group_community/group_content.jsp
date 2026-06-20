<!--입양, 임보 펫 정보-->
<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   @SuppressWarnings("unchecked")
   PostGroup post = (PostGroup)request.getAttribute("post");
	int headCount = (int)request.getAttribute("headCount");
	List<Integer> joinUser = (List<Integer>)request.getAttribute("joinUser");
	int userId= UserSessionUtils.getLoginUserId(session);
	String lId=UserSessionUtils.getLoginId(session);

%>
<c:set var="pId" value="<%=post.getPostId() %>"/>
<c:set var="uId" value="<%= UserSessionUtils.getLoginUserId(session) %>"/>
<html>
<head>
<title>그룹 모임</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page">
	<div class="pm-toolbar">
		<div>
			<h1 class="pm-page-title">그룹 모임</h1>
			<p class="pm-page-sub">${post.postTitle}</p>
		</div>
		<%if(lId.equals(post.getLoginId())){ %>
			<div>
				<a class="pm-btn-line"
				href="<c:url value='/community/group_community/group_content_update'>
				<c:param name='postId' value='${post.postId}'/>
				</c:url>">모임 수정</a>
				<a class="pm-btn-danger" href="<c:url value='/community/group_community/group_content_delete'>
				<c:param name='postId' value='${post.postId}'/>
				</c:url>">모임 삭제</a>
			</div>
		<%} %>
	</div>

	<div class="pm-panel">
		<table class="pm-detail">
			<tr>
				<th>모임명</th>
				<td>${post.postTitle}</td>
			</tr>
			<tr>
				<th>모임 생성 일자</th>
				<td>${post.postDate}</td>
			</tr>
			<tr>
				<th>모임 설명</th>
				<td>${post.postContent}</td>
			</tr>
			<tr>
				<th>모임 목적</th>
				<td>${post.groupPurpose}</td>
			</tr>
			<tr>
				<th>지역</th>
				<td>${post.region}</td>
			</tr>
			<tr>
				<th>관리자 이름</th>
				<td>${post.loginId}</td>
			</tr>
			<tr>
				<th>인원수</th>
				<td>${post.headCount}</td>
			</tr>
		</table>

		<% int flag = 0;
			for(int joinId:joinUser){
				if(joinId==userId){
					flag = 1;
					break;
				}
			}
			if(flag == 0){%>
				<div class="pm-actions">
					<a class="pm-btn" href="<c:url value='/community/group_community/group_join'>
					<c:param name='headCount' value='${post.headCount}'/>
					<c:param name='postId' value='${post.postId}'/>
					<c:param name='postTitle' value='${post.postTitle}'/>
					</c:url>">모임 가입하기</a>
				</div>
			<%} %>
	</div>

	<% if(flag==1){%>
		<div class="pm-panel" style="margin-top:22px;">
			<table class="pm-detail">
				<tr>
					<th>모임 팀원</th>
					<td>
						<!-- 팀원 목록 보기
						-> 클릭하면 개인정보로 넘어감 -->
						<% int index = 0; %>
						<c:forEach var="jId" varStatus="i" items="${joinUser}">
							<%
							Integer idJoin = joinUser.get(index);
							String userNickName = UserSessionUtils.getUserNickName(idJoin);
							%>
							<a class="pm-link-more" href="<c:url value='/community/group_community/group_member_info'>
							<c:param name='userId' value='${jId}' /></c:url>">
							<%=userNickName%>
							</a>
						<%index++; %>
						</c:forEach>
					</td>
				</tr>
			</table>
		</div>
	<%} %>

	<%-- 모달 이용
	<div id="container">
		<button id="btn-modal">댓글 작성</button>
	</div>
	<div id="modal" class="modal-overlay">
		<div class="modal-window">
			<div class="title">
				<h2>댓글 작성</h2>
			</div>
			<div class="close-area">닫기</div>
			<div class="content">
			<form name="form" method="POST" action="<c:url value='/user/register' />">
				<c:if test="${registerFailed}">
				  <font color="red"><c:out value="${exception.getMessage()}" /></font>
				</c:if>
				<input type="text" style="width: 60%" name="userNickname" >
					 	<c:if test="${registerFailed}">value="${user.userNickname}"</c:if>
				<input class="btn" type="button" value="등록" onClick="userCreate()"> &nbsp;
			</form>
			</div>
		</div>
	</div>
	<script>
		const modal = document.getElementById("modal")
		function modalOn() {
			modal.style.display = "flex"
		}
		function isModalOn() {
			return modal.style.display === "flex"
		}
		function modalOff() {
			modal.style.display = "none"
		}
		const btnModal = document.getElementById("btn-modal")
		btnModal.addEventListener("click", e => {
			modalOn()
		})
		const closeBtn = modal.querySelector(".close-area")
		closeBtn.addEventListener("click", e => {
			modalOff()
		})
		modal.addEventListener("click", e => {
			const evTarget = e.target
			if(evTarget.classList.contains("modal-overlay")) {
				modalOff()
			}
		})
		window.addEventListener("keyup", e => {
			if(isModalOn() && e.key === "Escape") {
				modalOff()
			}
		})
	</script> --%>
</div>
</body>
</html>
