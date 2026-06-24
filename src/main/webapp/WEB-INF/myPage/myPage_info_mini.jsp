<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav style="display:flex; flex-direction:column; gap:10px;">
	<a class="pm-btn-line" style="width:100%; text-align:center;" href="<c:url value='/myPage/content_zip' />">작성글 모아보기</a>
	<a class="pm-btn-line" style="width:100%; text-align:center;" href="<c:url value='/myPage/comment_zip' />">댓글 모아보기</a>
	<a class="pm-btn-line" style="width:100%; text-align:center;" href="<c:url value='/user/user_update' />">회원정보 수정</a>
	<a class="pm-btn-danger" style="width:100%; text-align:center;" href="<c:url value='/user/user_exit' />" onclick="return confirm('정말 탈퇴하시겠습니까?\n작성한 글·댓글은 보존됩니다.');">회원 탈퇴</a>
</nav>
