<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*" import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   @SuppressWarnings("unchecked")
   ArrayList<PostGroup> p1List = (ArrayList<PostGroup>)request.getAttribute("p1List");
   Collections.sort(p1List);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>그룹 커뮤니티</title>
<style>
   .pm-cards{ display:grid; grid-template-columns:repeat(4,1fr); gap:18px; }
   @media(max-width:833px){ .pm-cards{ grid-template-columns:repeat(3,1fr); } }
   @media(max-width:639px){ .pm-cards{ grid-template-columns:repeat(2,1fr); } }
   .pm-card{ display:block; background:#fff; border:1px solid var(--pm-hair); border-radius:12px; overflow:hidden; text-decoration:none; color:inherit; transition:transform .15s ease, box-shadow .15s ease; }
   .pm-card:hover{ transform:translateY(-2px); box-shadow:rgba(0,0,0,0.09) 0 6px 18px; }
   .pm-card-img{ width:100%; height:160px; background:var(--pm-parch); overflow:hidden; }
   .pm-card-img img{ display:block; width:100%; height:100%; object-fit:cover; }
   .pm-card-body{ padding:13px 14px 16px; }
   .pm-card-title{ font-size:15px; font-weight:600; letter-spacing:-0.01em; color:var(--pm-ink); white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
   .pm-card-meta{ font-size:12.5px; color:var(--pm-muted); margin-top:4px; }
</style>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
<div class="pm-page wide">
   <div class="pm-toolbar">
      <div>
         <h1 class="pm-page-title">그룹</h1>
         <p class="pm-page-sub">관심사가 비슷한 반려인들과 모임을 만들어 보세요.</p>
      </div>
      <% if(session.getAttribute("loginId") != null) {%>
         <a class="pm-btn" href="<c:url value='/community/group_community/add_content' />">모임 생성</a>
      <%} %>
   </div>

   <div class="pm-cards">
      <% int index = 0; %>
      <c:forEach var="item" varStatus="i" items="${p1List}">
         <%
            String file = p1List.get(index).getFileName();
         %>
         <a class="pm-card" href="<c:url value='/community/group_community/group_content'><c:param name='postId' value='${item.postId}'/></c:url>">
            <div class="pm-card-img">
               <%if(file != null) {%>
                  <img src="<c:url value='/upload/${item.fileName}'/>" alt="모임 대표 이미지" />
               <%} else{%>
                  <img src="<c:url value='/images/linkedin_profile_image.png'/>" alt="모임 대표 이미지" />
               <%} %>
            </div>
            <div class="pm-card-body">
               <div class="pm-card-title">${item.postTitle}</div>
               <div class="pm-card-meta">모임 개설자 ${item.loginId}</div>
            </div>
         </a>
         <%index++; %>
      </c:forEach>
   </div>
</div>
</body>
</html>
