<!--입양, 임보 펫 정보-->
<%@page contentType="text/html; charset=utf-8" import="model.*" import="java.util.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	@SuppressWarnings("unchecked")
	PostAdoption pA = (PostAdoption)request.getAttribute("pA");
	System.out.println("aType : "+pA.getaType());
	
	session.setAttribute("adoptAnimal", pA.getAnimal());
%>
<html>
<head>
<title>임보/입양 정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/user.css' />" type="text/css">
<link rel=stylesheet href="<c:url value='/css/btn.css' />" type="text/css">
<script>
function adoptUpdate() {
   alert("실행");

   if (form.postTitle.value == "") {
      alert("제목을 입력하십시오.");
      form.postTitle.focus();
      return false;
   }
   
   if (form.postContent.value == "") {
	      alert("내용을 입력하십시오.");
	      form.postContent.focus();
	      return false;
	}
   
   if (form.gender.value == "") {
	      alert("성별을 입력하십시오.");
	      form.gender.focus();
	      return false;
	}
   
   if (form.age.value == "") {
	      alert("나이를 입력하십시오.");
	      form.age.focus();
	      return false;
	}
   
   if (form.health.value == "") {
	      alert("건강상태를 입력하십시오.");
	      form.health.focus();
	      return false;
	}
   
   if (form.vaccination.value == "") {
	      alert("백신접종여부를 입력하십시오.");
	      form.vaccination.focus();
	      return false;
	}
   
   if (form.kind.value == "") {
	      alert("종을 입력하십시오.");
	      form.kind.focus();
	      return false;
	}
   
   form.submit();
}

</script>
</head>
<body>   
<%@include file="/WEB-INF/navbar.jsp" %><!-- 화면 로드 시 서버로부터 커뮤니티 목록을 가져와 commSelect 메뉴 생성 -->
<!-- registration form  -->

<!--<h2>회원가입</h2>  -->
<form name="form" method="POST" action="<c:url value='/community/adopt_community/adopt_info_update' />" enctype="multipart/form-data" >
   	<input type="hidden" name="postId" value="${pA.postId}"/>	  
    <input type="hidden" name="petId" value="${pA.animal['postId']}"/>	  
   
   <!-- 회원가입이 실패한 경우 exception 객체에 저장된 오류 메시지를 출력 -->
         <c:if test="${registerFailed}">
         <font color="red"><c:out value="${exception.getMessage()}" /></font>
       </c:if>  
<table>
	<tr>
	<td style="width:300px">
	<!-- <a href="<c:url value='/main/main' />"> -->
		<img src="<c:url value='/images/favicon.png' />" style="width:200px; height:200px"/>		
	</td>
	
	<td style="width:900px">
	<br>
	<h3>임보/입양 정보</h3><br>
	<% String logId = (String)session.getAttribute("loginId"); %>
	<c:set var="lui" value="<%=logId%>"/>
	
	
	<table style="background-color: #848484; width: 100%">
	    <!--<center>-->
		<tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">사진</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	         	<% if (pA.getAnimal().getFilename() == null){%>
					<img src="<c:url value='/images/linkedin_profile_image.png' />"
					style="width: 500px; height: 500px" />
				<%} 
				else{%>
					<img src="<c:url value='/image?file=${p2.fileName}'/>"
					style="width: 500px; height: 500px" />
				<%} %>
			<input type="file" style="width: 60%" name="filename" >
	      </td>
	    </tr>
	    <tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">제목</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	         <!-- 정보 가져오기${post.animal["name"]} -->
	         <input type="text" style="width: 240" name="postTitle" value="${pA.postTitle}">
	      </td>
	    </tr>
	    <tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">작성일</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	         ${pA.postDate}
	      </td>
	    </tr>
	    <tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">신청(임보/입양)</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	         <c:if test="${pA.aType==0}">입양</c:if>
	         <c:if test="${pA.aType==1}">임보</c:if>
	      </td>
	    </tr>
	    <tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">현 상태</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	      	 <c:if test="${pA.approval==0}">신청 진행 중</c:if>
	         <c:if test="${pA.approval==1}">입양(임보) 완료</c:if>
	      </td>
	    </tr>
	    <%-- 
	    <tr height="40">
	       <td width="150" align="center" bgcolor="#E6E6E6">전화번호</td>
	       <td width="250" bgcolor="ffffff" style="padding-left: 10">
	         <input type="text" style="width: 240" name="phone" 
	               <c:if test="${registerFailed}">value="${user.phone}"</c:if>>
	         </td>
	    </tr> --%>
	    <tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">입양(임보)완료일</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	      	<c:if test="${pA.approval==1}">${pA.approvalDate}</c:if>
	         <%-- <c:if test="${registerFailed}">value="${user.phone}"</c:if> --%>
	      </td>
	    </tr>
	    <tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">동물 종</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	         <input type="text" style="width: 240" name="kind" value="${pA.animal['kind']}">
	      </td>
	    </tr>
	    <tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">동물 성별</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	         <input type="text" style="width: 240" name="gender" value="${pA.animal['gender']}">
	      </td>
	    </tr>
	    <tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">동물 나이</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	         <input type="text" style="width: 240" name="age" value="${pA.animal['age']}">
	      </td>
	    </tr>
	    <tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">건강상태</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	         <input type="text" style="width: 240" name="health" value=" ${pA.animal['health']}">
	      </td>
	    </tr>
	    <tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">백신 접종 여부</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	         <input type="text" style="width: 240" name="vaccination" value="${pA.animal['vaccination']}">
	      </td>
	    </tr>
	    <tr height="40">
	      <td width="150" align="center" bgcolor="#E6E6E6">작성자 희망 조건 사항</td>
	      <td width="250" bgcolor="ffffff" style="padding-left: 10">
	         <input type="text" style="width: 240" name="postContent" value="${pA.postContent}">
	      </td>
	     </tr>
	    </table>
	 </td>
    </tr>
     <tr>
	 	<td colspan=2>
	 	<br><br>
	 		<input class="btn" type="button" value="폼 수정완료" onClick="adoptUpdate()"> &nbsp;
		</td>
	 </tr>
 </table>
</form>
</body>
</html>