<!--입양, 임보 펫 정보-->
<%@page contentType="text/html; charset=utf-8" import="model.*"
	import="java.util.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	@SuppressWarnings("unchecked")
	PostPetstargram p2 = (PostPetstargram) request.getAttribute("p2");
%>
<html>
<head>
<title>펫스타그램 폼</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel=stylesheet href="<c:url value='/css/user.css' />"
	type="text/css">
<link rel=stylesheet href="<c:url value='/css/btn.css' />"
	type="text/css">
<script>
function petstarUpdate() {
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
	<%@include file="/WEB-INF/navbar.jsp"%><!-- 화면 로드 시 서버로부터 커뮤니티 목록을 가져와 commSelect 메뉴 생성 -->
	<!-- registration form  -->
<form name="form" method="POST" action="<c:url value='/community/petstar_community/petstar_content_update' />" enctype="multipart/form-data">
	<input type="hidden" name="postId" value="${p2.postId}"/>	  
	
	<table style="width: 100%">
		<tr>
			<td style="width: 100%"><br>
				<h3>펫스타그램 폼</h3><br>
				
				<br>
				<table
					style="background-color: #848484; width: 100%; margin-top: 0px">
					<tr>
						<td
							style="height: 40%; width: 15%; align: center; background-color: #E6E6E6;">이미지</td>
						<td style="width: 50%">
							<% if(p2.getFileName()!=null){%>
								<img src="<c:url value='/image?file=${p2.fileName}'/>"
								style="width: 500px; height: 500px" />
							<%} %>
							<input type="file" style="width: 60%" name="fileName" >
						</td>
					</tr>
					<tr style="height: 40%; width: 100%">
						<td
							style="height: 40%; width: 15%; align: center; background-color: #E6E6E6;">제목</td>
						<td
							style="height: 40%; width: 100%; align: center; background-color: #ffffff; padding-left: 10">
							<input type="text" style="width: 240" name="postTitle" value="${p2.postTitle}">
						</td>
					</tr>
					<tr style="height: 40%; width: 100%">
						<td
							style="height: 40%; width: 15%; align: center; background-color: #E6E6E6;">작성자</td>
						<td
							style="height: 40%; width: 100%; align: center; background-color: #ffffff; padding-left: 10">
							<!-- 작성자 정보 가져오기 -->
							<% String logName = p2.getLoginId(); %>
							<c:set var="loginName" value="<%=UserSessionUtils.getUserNickName(logName) %>"/>
							${loginName}
						</td>
					</tr>
					<tr style="height: 40%; width: 100%">
						<td
							style="height: 40%; width: 15%; align: center; background-color: #E6E6E6;">종</td>
						<td
							style="height: 40%; width: 100%; align: center; background-color: #ffffff; padding-left: 10">
							<input type="text" style="width: 240" name="kind" value="${p2.kind}">
						</td>
					</tr>
					<tr style="height: 40%; width: 100%">
						<td
							style="height: 40%; width: 15%; align: center; background-color: #E6E6E6;">작성일자</td>
						<td
							style="height: 40%; width: 100%; align: center; background-color: #ffffff; padding-left: 10">
							<!-- 작성일자 정보 가져오기 --> ${p2.postDate}
						</td>
					</tr>
					<tr style="height: 40%; width: 100%">
						<td
							style="height: 40%; width: 15%; align: center; background-color: E6E6E6;">내용</td> 
						<td
							style="height: 40%; width: 100%; align: center; background-color: ffffff; padding-left: 10">
							<input type="text" style="width: 240" name="postContent" value="${p2.postContent}">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
		 	<td colspan=2>
		 	<br><br>
		 		<input class="btn" type="button" value="폼 수정완료" onClick="petstarUpdate()"> &nbsp;
			</td>
		 </tr>
	</table>
	</form>
</body>
</html>