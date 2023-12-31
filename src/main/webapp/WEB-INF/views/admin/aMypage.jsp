<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="conPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello World</title>
<link href="${conPath }/css/style.css" rel="stylesheet">
<link href="${conPath }/css/member/member.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
	$(document).ready(function() {
		
	});
</script>
</head>
<body>
	<c:if test="${empty admin }">
		<script>
			loation.href = '${conPath }/admin/adLogin.do';
		</script>
	</c:if>

	<jsp:include page="../main/header.jsp" />
	<div class="background-color">
		<div id="wrap">
			<div id="myPage">

				<!-- left: myContent -->
				<div class="myContent">
					<ul>
						<li>
							<h3>안녕하세요!</h3>
							<h1><a href="${conPath }/admin/AMypage.do">${admin.adname } 님</a></h1> <br>
						</li>
						<li>
							<ul>
								<li><h4>회원관리</h4></li>
								<li><a href="${conPath }/admin/allView.do">회원 현황 확인</a></li>
								<li><a href="">블랙회원 관리</a></li>
								<li><a href="">등급관리</a></li>
							</ul>

							<ul>
								<li><h4>티켓 관리</h4></li>
								<li><a href="">티켓 목록</a></li>
								<li><a href="">티켓 등록</a></li>
								<li><a href="">티켓 예매 현황</a></li>
								<li><a href="">입장 티켓 확인</a></li>
							</ul>

							<ul>
								<li><h4>공연 관리</h4></li>
								<li><a href="">공연 목록</a></li>
								<li><a href="">공연 등록</a></li>
								<li><a href="">공연 예매 현황</a></li>
							</ul>

							<ul>
								<li><h4>어트랙션 관리</h4></li>
								<li><a href="">어트랙션 목록</a></li>
								<li><a href="">어트랙션 등록</a></li>
							</ul>

							<ul>
								<li><h4>후기 관리</h4></li>
								<li><a href="">공연 후기 확인</a></li>
								<li><a href="">어트랙션 후기 확인</a></li>
							</ul>

							<ul>
								<li><h4>고객센터</h4></li>
								<li><a href="">1:1 문의내역</a></li>
								<li><a href="">공지사항</a></li>
								<li><a href="">FAQ</a></li>
								<li><a href="">고객의 소리</a></li>
							</ul>
						</li>
					</ul>
				</div><!-- myContent -->

				<div class="myPage_right">
					<!-- main_item -->
					<div class="item_box">
						<div class="sub_item item1" onclick="location.href='${conPath}/member/tOrderList.do'">
							<h2>티켓 예매확인/취소</h2>
						</div>
						<div class="sub_item item2">
							<div class="normal_box">
								<h2>공연 예매확인/취소</h2>
							</div>
						</div>
						<div class="sub_item item3">
							<div class="normal_box">
								<h2>1:1 문의내역</h2>
							</div>
						</div>
						<div class="sub_item item4">
							<div class="normal_box">
								<h2>나의 후기</h2>
							</div>
						</div>
					</div>
					<!-- main_item -->
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="../main/footer.jsp" />
</body>
</html>
