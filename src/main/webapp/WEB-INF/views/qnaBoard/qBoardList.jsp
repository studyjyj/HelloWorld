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
<link href="${conPath }/css/board.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script>
	$(document).ready(function() {
		
	});
</script>
</head>
<body>
	<jsp:include page="../main/header.jsp" />
	<div id="wrap">
		<h1 class="center">QnA 질문게시판</h1>
		<div>
			<div class="board_left"></div>
			<div class="board_right"></div>
		</div>
		<table class="list_table">
			<tr>
				<th>번호</th>
				<th class="title">제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>날짜</th>
			</tr>
			<c:if test="${totCnt == 0}">
				<tr>
					<td colspan="5">
						<h4>등록된 게시글이 없습니다.</h4>
					</td>
				</tr>
			</c:if>
			<c:if test="${totCnt != 0}">
				<c:forEach var="review" items="${reviewList }">
					<tr>
						<td>${review.rno }</td>
						<td class="title left">
							<c:forEach var="i" begin="1" end="${review.rindent }">
								<c:if test="${i != review.rindent }">
									 &nbsp; &nbsp; 
								</c:if>
								<c:if test="${i == review.rindent }">
									 ㄴ
								</c:if>
							</c:forEach>
							${review.rtitle }
							<c:if test="${review.rhit > 10}">&#127752;<b class="red">인기글</b>
							</c:if>
							<!-- 인기글 -->
							<c:if test="${not empty review.rphoto}">&#128196;</c:if>
							<!-- 파일첨부 -->
						</td>
						<td>${review.name }</td>
						<td>${review.rhit }</td>
						<td>
							<fmt:formatDate value="${review.rrdate }" type="date" dateStyle="short" />
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>

	</div>
	<jsp:include page="../main/footer.jsp" />
</body>
</html>