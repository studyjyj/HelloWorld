<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${conPath }/css/style.css" rel="stylesheet">
<link href="${conPath }/css/header.css" rel="stylesheet">
</head>
<body>
	<div class="util">
		<div class="utill_inner">
			<div class="utill_inner_left">KOR▾</div>
			<div class="login">
				<c:if test="${empty member }">
					<ul>
						<li><a href="${conPath }/member/mJoin.do">회원가입</a></li>
						<li><a href="${conPath }/member/mLogin.do">로그인</a></li>
					</ul>
				</c:if>
				<c:if test="${not empty member }">
					<ul>
						<li><b>${member.mname }</b>님▾</li>
						<li><a href="${conPath }/member/mLogout.do">로그아웃</a></li>
					</ul>
				</c:if>
			</div>
		</div>
	</div>

	<nav>
		<div class=nav_inner>
			<div class="logo">
				<img alt="헬로월드 로고" src="${conPath }/img/logo.png"
					onclick="location.href='${conPath}/main.do'">
			</div>
			<ul class="menu_item">
				<li><a href="#">이용정보</a></li>
				<li><a href="#">요금/프로모션</a>
					<ul class="drop-menu">
						<li><a href="#">이용요금</a></li>
						<li><a href="#">이달의 혜택</a></li>
						<li><a href="#">연간이용</a></li>
						<li><a href="#">운영/운휴</a></li>
					</ul></li>
				<li><a href="#">즐길거리</a>
					<div class="mega-box">
						<div class="content">
							<div class="row">
								<img src="" alt="">
							</div>
							<div class="row">
								<header>어트랙션</header>
								<ul class="mega-items">
									<li><a href="#">어트랙션 소개</a></li>
									<li><a href="#">어트랙션 위치 확인</a></li>
									<li><a href="#">어트랙션 QnA</a></li>
									<li><a href="#">추천코스</a></li>
								</ul>
							</div>
							<div class="row">
								<header>공연</header>
								<ul class="mega-items">
									<li><a href="#">예약하기</a></li>
									<li><a href="#">스테이지</a></li>
									<li><a href="#">퍼레이드</a></li>
									<li><a href="#">공연후기</a></li>
								</ul>
							</div>
							<div class="row">
								<header>다이닝/쇼핑</header>
								<ul class="mega-items">
									<li><a href="#">레스토랑</a></li>
									<li><a href="#">기프트샵</a></li>
									<li><a href="#">온라인 굿즈샵</a></li>
								</ul>
							</div>
						</div>
					</div></li>
				<li><a href="#">소통서비스</a>
					<ul class="drop-menu">
						<li><a href="#">공지사항</a></li>
						<li><a href="#">1:1문의</a></li>
						<li><a href="#">고객소리함</a></li>
					</ul></li>
				<li><a href="#">더 알아보기</a></li>
			</ul>
			<div class="promotion">
				<img alt="할인프로모션" src="${conPath }/img/header_nPay.png">
			</div>
		</div>
	</nav>
</body>
</html>