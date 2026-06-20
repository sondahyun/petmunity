<!--입양, 임보 펫 정보-->
<%@page contentType="text/html; charset=utf-8" import="java.util.*" import="model.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	PostGroup post1 = (PostGroup)request.getAttribute("post1");
%>
<html>
<head>
<title>그룹 모임 수정</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/user.css' />" type="text/css">
<link rel=stylesheet href="<c:url value='/css/btn.css' />" type="text/css">
<link rel=stylesheet href="<c:url value='/css/modal.css' />" type="text/css">
<script>
function applyInfo() {
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
   
   form.submit();
}

function userList(targetUri) {
   form.action = targetUri;
   form.submit();   //get
}
</script>
</head>
<body>   
<%@include file="/WEB-INF/navbar.jsp" %><!-- 화면 로드 시 서버로부터 커뮤니티 목록을 가져와 commSelect 메뉴 생성 -->
<!-- registration form  -->

<!--<h2>회원가입</h2>  -->
<form name="form" method="POST" action="<c:url value='/community/group_community/group_content_update' />" enctype="multipart/form-data">
  <input type="hidden" name="postId" value="${post1.postId}"/>	  

	<table style="width:100%">
		<tr>		
			<td style="width:100%">
			<br>
			<h3>그룹 모임 폼</h3>
			<br>
			   <table style="background-color: #848484; width: 100%; margin-top:0px">
				    <tr>
				    	<td style="height:40%; width:15%; align:center; background-color:#E6E6E6;" >모임 대표 배경 사진</td>
				    	<td style="width:50%">
				    		<%if(post1.getFileName() !=null){ %>
							<img src="<c:url value='/image?file=${post1.fileName}'/>" />
							<%} %>
							<input type="file" style="width: 60%" name="fileName" >			
						</td>
					</tr>
					<tr style="height:40%; width:100%">
				      <td style="height:40%; width:15%; align:center; background-color:E6E6E6;" >모임명</td>
				      <td style="height:40%; width:100%; align:center; background-color:#ffffff; padding-left: 10">
				        <input type="text" style="width: 60%" name="postTitle" value="${post1.postTitle}">			      
				      </td>
				    </tr>
				    <tr style="height:40%; width:100%">
				      <td style="height:40%; width:15%; align:center; background-color:E6E6E6;" >모임 설명</td>
				      <td style="height:40%; width:100%; align:center; background-color:#ffffff; padding-left: 10">
				        <input type="text" style="width: 60%" name="postContent" value="${post1.postContent}">			      
				      </td>
				    </tr>
				    <tr style="height:40%; width:100%">
				      <td style="height:40%; width:15%; align:center; background-color:E6E6E6;" >모임 목적</td>
				      <td style="height:40%; width:100%; align:center; background-color:#ffffff; padding-left: 10">
				        <input type="text" style="width: 60%" name="groupPurpose" value="${post1.groupPurpose}">			      
				      </td>
				    </tr>
				    <tr style="height:40%; width:100%">
				      <td style="height:40%; width:15%; align:center; background-color:E6E6E6;" >지역</td>
				      <td style="height:40%; width:100%; align:center; background-color:#ffffff; padding-left: 10">
				        <input type="text" style="width: 60%" name="region" value="${post1.region}">			      
				      </td>
				    </tr>
			    </table>
			 </td>
		</tr>
		<tr>
			<td>
				<br><input type="submit" class="btn" value="게시글 수정" onClick= "applyInfo()">
			</td>
		</tr>
	 </table>
</form>
</body>
</html>