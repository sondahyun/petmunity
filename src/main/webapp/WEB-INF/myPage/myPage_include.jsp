<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	@font-face {
		font-family: 'Y_Spotlight';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts-20-12@1.0/Y_Spotlight.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	.adopt_main_table{
		border : 1px solid black;
	  	border-collapse : collapse;
		border-radius : 10px;
	    margin:auto;
	    text-align:center;
	    width:300px;
	    height:440px;
	    font-family: 'Y_Spotlight';
		src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts-20-12@1.0/Y_Spotlight.woff') format('woff');
		font-weight: normal;
		font-style: normal; 
		font-size: 12pt; 
		color: Black; 
		background-color: White;
		line-height: 22px;
	}
	.pic {
	
	}
	.name, .ABOUT{
		border : 1px solid black;
	  	border-collapse : collapse;
	    margin:auto;
	}
</style>
<table class="adopt_main_table">
	<%
	if(session.getAttribute("loginId") != null) {// 입양일 경우
	%>
	<tr class="name">
	    <td>
			<%out.print(session.getAttribute("loginId") + "님 환영합니다!");%> 
		</td>
	</tr>
	<tr>
		<td>
			<a href="<c:url value='/myPage/myPage' />">마이페이지</a>
		</td>
	</tr> 
	<%
	} 
	%>
			
	<tr class="ABOUT">
		<td>
			<!-- <input class="btn" type="button" value="ABOUT" onClick="location.href='/myPage/about.jsp';"> -->
			<a class="nav-link" href="<c:url value='/myPage/about' />">ABOUT</a>
		</td>
	</tr>
</table>