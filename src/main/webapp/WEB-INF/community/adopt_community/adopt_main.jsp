<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.util.*" import="model.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	AdoptionAnimal animal = (AdoptionAnimal)session.getAttribute("adoptAnimal");
%>
<% if (animal != null) { %>
	<table class="pm-detail">
		<tr><th>종</th><td><%=animal.getKind() %></td></tr>
		<tr><th>성별</th><td><%=animal.getGender() %></td></tr>
		<tr><th>나이</th><td><%=animal.getAge() %>살</td></tr>
	</table>
<% } else { %>
	<p class="pm-note">동물 정보를 불러올 수 없습니다. 입양 게시글에서 다시 신청해 주세요.</p>
<% } %>
