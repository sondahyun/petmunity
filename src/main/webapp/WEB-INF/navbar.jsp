<%@page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	:root{
		--pm-accent:#0066cc; --pm-accent-hover:#0077ed; --pm-accent-focus:#0071e3;
		--pm-ink:#1d1d1f; --pm-parch:#f5f5f7; --pm-muted:#6e6e73;
		--pm-hair:#e3e3e6;
	}
	*{ box-sizing:border-box; }
	html,body{ margin:0; padding:0; }
	body{
		font-family:-apple-system,BlinkMacSystemFont,system-ui,"SF Pro Text","SF Pro Display","Helvetica Neue",Arial,sans-serif;
		color:var(--pm-ink);
		background:#fff;
		-webkit-font-smoothing:antialiased;
		-moz-osx-font-smoothing:grayscale;
	}
	/* ===== Apple 스타일 슬림 글로벌 내비 ===== */
	.pm-nav{
		position:sticky; top:0; z-index:1000;
		background:rgba(22,22,23,0.92);
		backdrop-filter:saturate(180%) blur(20px);
		-webkit-backdrop-filter:saturate(180%) blur(20px);
	}
	.pm-nav-inner{
		max-width:1024px; margin:0 auto;
		display:flex; align-items:center; gap:28px;
		height:48px; padding:0 22px;
	}
	.pm-brand{ font-size:19px; font-weight:600; letter-spacing:-0.02em; color:#f5f5f7; white-space:nowrap; }
	.pm-nav-links{ display:flex; gap:28px; flex:1; justify-content:center; }
	.pm-nav-links a, .pm-nav-auth a{
		font-size:13px; font-weight:400; letter-spacing:-0.01em;
		color:#d2d2d7; transition:color .2s; white-space:nowrap;
	}
	.pm-nav-links a:hover, .pm-nav-auth a:hover{ color:#fff; }
	.pm-nav-auth{ display:flex; gap:18px; align-items:center; }
	@media(max-width:833px){
		.pm-nav-inner{ flex-wrap:wrap; height:auto; padding:10px 16px; gap:12px 18px; }
		.pm-nav-links{ order:3; width:100%; justify-content:flex-start; flex-wrap:wrap; gap:16px; }
		.pm-nav-auth{ margin-left:auto; }
	}
	/* ===== Apple 버튼 ===== */
	.pm-btn{
		display:inline-block; background:var(--pm-accent); color:#fff;
		font-size:17px; line-height:1; border:none; border-radius:980px;
		padding:13px 24px; cursor:pointer; text-decoration:none;
		transition:transform .15s ease, background .2s ease;
	}
	.pm-btn:hover{ background:var(--pm-accent-hover); }
	.pm-btn:active{ transform:scale(.96); }
	.pm-btn-ghost{ background:transparent; color:var(--pm-accent); border:1px solid var(--pm-accent); }
	.pm-link-more{ font-size:17px; color:var(--pm-accent); text-decoration:none; letter-spacing:-0.01em; }
	.pm-link-more:hover{ text-decoration:underline; }
	/* ===== Apple 풋터(카피라이트 없음) ===== */
	.pm-footer{ background:var(--pm-parch); color:var(--pm-muted); font-size:12px; padding:26px 22px; text-align:center; }
	.pm-footer a{ color:var(--pm-muted); margin:0 10px; text-decoration:none; }
	.pm-footer a:hover{ color:var(--pm-ink); }

	/* ===== 공용 페이지 컴포넌트 (내부 페이지 공통) ===== */
	.pm-page{ max-width:920px; margin:0 auto; padding:40px 22px 72px; }
	.pm-page.narrow{ max-width:520px; }
	.pm-page.form{ max-width:860px; }
	.pm-page.wide{ max-width:1040px; }
	.pm-page-title{ font-size:28px; font-weight:700; letter-spacing:-0.015em; margin:0 0 6px; color:var(--pm-ink); }
	.pm-page-sub{ font-size:15px; color:var(--pm-muted); margin:0 0 28px; }
	.pm-toolbar{ display:flex; justify-content:space-between; align-items:center; gap:12px; margin:0 0 22px; flex-wrap:wrap; }
	.pm-note{ color:var(--pm-muted); font-size:14px; }

	/* 폼 */
	.pm-form{ display:flex; flex-direction:column; gap:18px; }
	.pm-field{ display:flex; flex-direction:column; gap:7px; }
	.pm-label{ font-size:14px; font-weight:600; letter-spacing:-0.01em; color:var(--pm-ink); }
	.pm-input, .pm-textarea, .pm-select{
		width:100%; font-size:16px; font-family:inherit; color:var(--pm-ink); background:#fff;
		border:1px solid var(--pm-hair); border-radius:12px; padding:12px 14px; outline:none;
		transition:border-color .15s ease, box-shadow .15s ease;
	}
	.pm-input:focus, .pm-textarea:focus, .pm-select:focus{ border-color:var(--pm-accent); box-shadow:0 0 0 3px rgba(0,102,204,0.12); }
	.pm-textarea{ min-height:150px; resize:vertical; line-height:1.55; }
	.pm-radios{ display:flex; gap:18px; flex-wrap:wrap; font-size:15px; color:var(--pm-ink); align-items:center; }
	.pm-radios label{ display:inline-flex; align-items:center; gap:6px; cursor:pointer; }
	.pm-inline{ display:flex; gap:10px; align-items:center; flex-wrap:wrap; }
	.pm-actions{ display:flex; gap:10px; margin-top:10px; flex-wrap:wrap; }
	.pm-btn-line{ display:inline-block; background:#fff; color:var(--pm-ink); border:1px solid var(--pm-hair); border-radius:980px; padding:12px 22px; font-size:16px; text-decoration:none; cursor:pointer; transition:background .15s ease; }
	.pm-btn-line:hover{ background:var(--pm-parch); }
	.pm-btn-danger{ display:inline-block; background:#fff; color:#d70015; border:1px solid #f1c9cb; border-radius:980px; padding:12px 22px; font-size:16px; text-decoration:none; cursor:pointer; }
	.pm-btn-danger:hover{ background:#fff5f5; }

	/* 리스트(표) */
	.pm-list{ width:100%; border-collapse:collapse; font-size:15px; }
	.pm-list thead th{ text-align:left; font-size:13px; font-weight:600; color:var(--pm-muted); padding:0 14px 12px; border-bottom:1px solid var(--pm-hair); }
	.pm-list tbody td{ padding:14px; border-bottom:1px solid #f0f0f2; color:var(--pm-ink); }
	.pm-list tbody tr:hover{ background:var(--pm-parch); }
	.pm-list a{ color:var(--pm-ink); text-decoration:none; font-weight:500; }
	.pm-list a:hover{ color:var(--pm-accent); }

	/* 상세(키-값) */
	.pm-detail{ width:100%; border-collapse:collapse; font-size:15px; border:1px solid var(--pm-hair); border-radius:14px; overflow:hidden; }
	.pm-detail th{ width:150px; text-align:left; vertical-align:top; color:var(--pm-muted); font-weight:600; padding:14px 16px; background:var(--pm-parch); border-bottom:1px solid #fff; }
	.pm-detail td{ padding:14px 16px; border-bottom:1px solid var(--pm-hair); color:var(--pm-ink); }

	/* 콘텐츠 카드(상세 본문 등) */
	.pm-panel{ background:#fff; border:1px solid var(--pm-hair); border-radius:16px; padding:26px; }
	.pm-media{ width:100%; max-width:520px; max-height:560px; object-fit:contain; border-radius:14px; display:block; margin:0 auto 22px; }
</style>
<nav class="pm-nav">
	<div class="pm-nav-inner">
		<a class="pm-brand" href="<c:url value='/' />">Petmunity</a>
		<div class="pm-nav-links">
			<a href="<c:url value='/community/adopt_community/adopt_community' />">입양·임보</a>
			<a href="<c:url value='/community/petstar_community/petstar_community' />">펫스타그램</a>
			<a href="<c:url value='/community/group_community/group_community' />">그룹</a>
			<a href="<c:url value='/community/info_community/info_community' />">정보</a>
			<a href="<c:url value='/search/search' />">검색</a>
		</div>
		<div class="pm-nav-auth">
			<% if(session.getAttribute("loginId") == null) { %>
				<a href="<c:url value='/user/login/form' />">로그인</a>
				<a href="<c:url value='/user/register_person/form' />">회원가입</a>
			<% } else { %>
				<a href="<c:url value='/myPage/myPage' />">마이페이지</a>
				<a href="<c:url value='/message/message' />">쪽지</a>
				<a href="<c:url value='/user/logout' />">로그아웃</a>
			<% } %>
		</div>
	</div>
</nav>
