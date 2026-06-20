<%@page contentType="text/html; charset=utf-8" import="model.*"
	import="java.util.*" import="controller.user.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<PostInformation> p0List = (ArrayList<PostInformation>)request.getAttribute("p0List");
	ArrayList<PostPetstargram> p2List = (ArrayList<PostPetstargram>)request.getAttribute("p2List");
	ArrayList<PostAdoption> p3List = (ArrayList<PostAdoption>)request.getAttribute("p3List");
	if (p0List == null) p0List = new ArrayList<PostInformation>();
	if (p2List == null) p2List = new ArrayList<PostPetstargram>();
	if (p3List == null) p3List = new ArrayList<PostAdoption>();
	Collections.sort(p0List);
	Collections.sort(p2List);
	Collections.sort(p3List);
	String ctx = request.getContextPath();
	String defaultImg = ctx + "/images/linkedin_profile_image.png";
%>
<!DOCTYPE html>
<html>
<head>
<title>Petmunity</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
	/* ===== 컴팩트 히어로 ===== */
	.pm-hero{ background:var(--pm-parch); text-align:center; padding:52px 22px 44px; }
	.pm-hero h1{ font-size:32px; font-weight:700; letter-spacing:-0.02em; line-height:1.2; margin:0 0 10px; color:var(--pm-ink); }
	.pm-hero p{ font-size:16px; font-weight:400; color:var(--pm-muted); margin:0 0 20px; }

	.pm-wrap{ max-width:1040px; margin:0 auto; padding:0 22px; }

	/* ===== 카테고리 카드 ===== */
	.pm-cats{ display:grid; grid-template-columns:repeat(4,1fr); gap:16px; margin:34px auto 8px; }
	@media(max-width:833px){ .pm-cats{ grid-template-columns:repeat(2,1fr); } }
	@media(max-width:480px){ .pm-cats{ grid-template-columns:1fr; } }
	.pm-cat{ display:block; background:#fff; border:1px solid var(--pm-hair); border-radius:14px; padding:20px; text-decoration:none; color:inherit; transition:transform .15s ease, box-shadow .15s ease, border-color .15s ease; }
	.pm-cat:hover{ transform:translateY(-2px); box-shadow:rgba(0,0,0,0.07) 0 6px 18px; border-color:#cfcfd4; }
	.pm-cat-ico{ font-size:26px; line-height:1; }
	.pm-cat-name{ font-size:17px; font-weight:600; letter-spacing:-0.01em; margin:10px 0 5px; color:var(--pm-ink); }
	.pm-cat-desc{ font-size:13px; color:var(--pm-muted); line-height:1.5; }

	/* ===== 최근 글 섹션 ===== */
	.pm-block{ margin:40px auto 0; }
	.pm-block-head{ display:flex; align-items:center; justify-content:space-between; gap:12px; padding-bottom:12px; margin-bottom:18px; border-bottom:1px solid var(--pm-hair); }
	.pm-block-head h2{ font-size:20px; font-weight:700; letter-spacing:-0.01em; margin:0; color:var(--pm-ink); }
	.pm-link-more{ font-size:14px; }

	.pm-cards{ display:grid; grid-template-columns:repeat(5,1fr); gap:16px; }
	@media(max-width:1023px){ .pm-cards{ grid-template-columns:repeat(3,1fr); } }
	@media(max-width:639px){ .pm-cards{ grid-template-columns:repeat(2,1fr); } }
	.pm-card{ display:block; background:#fff; border:1px solid var(--pm-hair); border-radius:12px; overflow:hidden; text-decoration:none; color:inherit; transition:transform .15s ease, box-shadow .15s ease; }
	.pm-card:hover{ transform:translateY(-2px); box-shadow:rgba(0,0,0,0.09) 0 6px 18px; }
	.pm-card-img{ width:100%; height:140px; background:var(--pm-parch); overflow:hidden; }
	.pm-card-img img{ display:block; width:100%; height:100%; object-fit:cover; }
	.pm-card-body{ padding:11px 13px 14px; }
	.pm-card-title{ font-size:14.5px; font-weight:600; letter-spacing:-0.01em; color:var(--pm-ink); white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
	.pm-card-meta{ font-size:12.5px; color:var(--pm-muted); margin-top:4px; }

	/* ===== 빈 상태 ===== */
	.pm-empty{ display:flex; align-items:center; gap:14px; flex-wrap:wrap; background:var(--pm-parch); border-radius:12px; padding:22px 24px; color:var(--pm-muted); font-size:14px; }
	.pm-empty .pm-btn-sm{ display:inline-block; background:var(--pm-accent); color:#fff; font-size:13px; border-radius:980px; padding:8px 16px; text-decoration:none; }
	.pm-empty .pm-btn-sm:hover{ background:var(--pm-accent-hover); }

	.pm-bottom{ height:56px; }
	@media(max-width:640px){ .pm-hero h1{ font-size:26px; } }
</style>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>

<!-- ===== 컴팩트 히어로 ===== -->
<section class="pm-hero">
	<h1>반려동물과 함께하는 모든 순간, Petmunity</h1>
	<p>입양·임보부터 일상 공유까지, 반려인을 위한 커뮤니티</p>
	<% if(session.getAttribute("loginId") == null) { %>
		<a class="pm-btn" href="<c:url value='/user/register_person/form' />">지금 시작하기</a>
	<% } else { %>
		<a class="pm-btn" href="<c:url value='/myPage/myPage' />">마이페이지</a>
	<% } %>
</section>

<div class="pm-wrap">
	<!-- ===== 카테고리 ===== -->
	<div class="pm-cats">
		<a class="pm-cat" href="<c:url value='/community/adopt_community/adopt_community' />">
			<div class="pm-cat-ico">🐾</div>
			<div class="pm-cat-name">입양 · 임보</div>
			<div class="pm-cat-desc">새로운 가족을 기다리는 아이들을 만나보세요.</div>
		</a>
		<a class="pm-cat" href="<c:url value='/community/petstar_community/petstar_community' />">
			<div class="pm-cat-ico">📸</div>
			<div class="pm-cat-name">펫스타그램</div>
			<div class="pm-cat-desc">우리 아이의 귀여운 순간을 자랑해요.</div>
		</a>
		<a class="pm-cat" href="<c:url value='/community/group_community/group_community' />">
			<div class="pm-cat-ico">👥</div>
			<div class="pm-cat-name">그룹</div>
			<div class="pm-cat-desc">관심사가 같은 반려인들과 모임을 만들어요.</div>
		</a>
		<a class="pm-cat" href="<c:url value='/community/info_community/info_community' />">
			<div class="pm-cat-ico">📚</div>
			<div class="pm-cat-name">정보</div>
			<div class="pm-cat-desc">건강·돌봄·생활 정보를 함께 나눠요.</div>
		</a>
	</div>

	<%-- 최근 글 섹션 매크로 대신 직접 작성 --%>
	<!-- ===== 입양 · 임보 최근 글 ===== -->
	<div class="pm-block">
		<div class="pm-block-head">
			<h2>입양 · 임보 최근 글</h2>
			<a class="pm-link-more" href="<c:url value='/community/adopt_community/adopt_community' />">전체 보기 ›</a>
		</div>
		<% if (p3List.isEmpty()) { %>
			<div class="pm-empty">아직 작성된 글이 없어요. 첫 글을 남겨보세요!
				<a class="pm-btn-sm" href="<c:url value='/community/adopt_community/apply_form' />">글 작성하기</a></div>
		<% } else { %>
			<div class="pm-cards">
			<% int n3 = 0;
			   for (PostAdoption p3 : p3List) {
			       if (n3 >= 5) break; n3++;
			       String nick3 = UserSessionUtils.getUserNickName(p3.getLoginId());
			       String f3 = (p3.getAnimal() != null) ? p3.getAnimal().getFilename() : null;
			       String img3 = (f3 != null) ? ctx + "/upload/" + f3 : defaultImg;
			       String href3 = ctx + "/community/adopt_community/adopt_info?postId=" + p3.getPostId();
			%>
				<a class="pm-card" href="<%=href3%>">
					<div class="pm-card-img"><img src="<%=img3%>" alt=""></div>
					<div class="pm-card-body">
						<div class="pm-card-title"><%=p3.getPostTitle()%></div>
						<div class="pm-card-meta"><%=nick3%></div>
					</div>
				</a>
			<% } %>
			</div>
		<% } %>
	</div>

	<!-- ===== 펫스타그램 최근 글 ===== -->
	<div class="pm-block">
		<div class="pm-block-head">
			<h2>펫스타그램 최근 글</h2>
			<a class="pm-link-more" href="<c:url value='/community/petstar_community/petstar_community' />">전체 보기 ›</a>
		</div>
		<% if (p2List.isEmpty()) { %>
			<div class="pm-empty">아직 작성된 글이 없어요. 첫 글을 남겨보세요!
				<a class="pm-btn-sm" href="<c:url value='/community/petstar_community/add_content' />">글 작성하기</a></div>
		<% } else { %>
			<div class="pm-cards">
			<% int n2 = 0;
			   for (PostPetstargram p2 : p2List) {
			       if (n2 >= 5) break; n2++;
			       String nick2 = UserSessionUtils.getUserNickName(p2.getLoginId());
			       String f2 = p2.getFileName();
			       String img2 = (f2 != null) ? ctx + "/upload/" + f2 : defaultImg;
			       String href2 = ctx + "/community/petstar_community/petstar_content?postId=" + p2.getPostId();
			%>
				<a class="pm-card" href="<%=href2%>">
					<div class="pm-card-img"><img src="<%=img2%>" alt=""></div>
					<div class="pm-card-body">
						<div class="pm-card-title"><%=p2.getPostTitle()%></div>
						<div class="pm-card-meta"><%=nick2%></div>
					</div>
				</a>
			<% } %>
			</div>
		<% } %>
	</div>

	<!-- ===== 정보 최근 글 ===== -->
	<div class="pm-block">
		<div class="pm-block-head">
			<h2>정보 최근 글</h2>
			<a class="pm-link-more" href="<c:url value='/community/info_community/info_community' />">전체 보기 ›</a>
		</div>
		<% if (p0List.isEmpty()) { %>
			<div class="pm-empty">아직 작성된 글이 없어요. 첫 글을 남겨보세요!
				<a class="pm-btn-sm" href="<c:url value='/community/info_community/add_content' />">글 작성하기</a></div>
		<% } else { %>
			<div class="pm-cards">
			<% int n0 = 0;
			   for (PostInformation p0 : p0List) {
			       if (n0 >= 5) break; n0++;
			       String nick0 = UserSessionUtils.getUserNickName(p0.getLoginId());
			       String f0 = p0.getFileName();
			       String img0 = (f0 != null) ? ctx + "/upload/" + f0 : defaultImg;
			       String href0 = ctx + "/community/info_community/info_content?postId=" + p0.getPostId();
			%>
				<a class="pm-card" href="<%=href0%>">
					<div class="pm-card-img"><img src="<%=img0%>" alt=""></div>
					<div class="pm-card-body">
						<div class="pm-card-title"><%=p0.getPostTitle()%></div>
						<div class="pm-card-meta"><%=nick0%></div>
					</div>
				</a>
			<% } %>
			</div>
		<% } %>
	</div>

	<div class="pm-bottom"></div>
</div>

<footer class="pm-footer">
	<a href="<c:url value='/myPage/about' />">ABOUT</a>
</footer>
</body>
</html>
