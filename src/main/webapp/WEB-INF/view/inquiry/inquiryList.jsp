<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
	request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
<meta charset="UTF-8">
<title>문의 목록</title>
</head>

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #ffffff;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 1000px;
	margin: 20px auto;
	display: flex;
	justify-content: flex-start;
	align-items: flex-start;
}

.sidebar {
	width: 250px;
	background: #f8f8f8;
	padding: 20px;
	height: auto;
	flex-shrink: 0;
}

.sidebar h2 {
	font-size: 20px;
	font-weight: bold;
	margin: 0 0 15px 0;
	padding-left: 15px;
}

.side-menu {
	list-style: none;
	padding: 0;
	margin: 0;
	width: 100%;
}

.side-menu li {
	padding: 12px 15px;
	font-size: 16px;
	width: 75%;
	border-bottom: 1px solid #ddd;
	text-align: left;
}

.side-menu li:last-child {
	border-bottom: none;
}

.side-menu li a {
	text-decoration: none;
	color: #333;
	display: block;
	width: 100%;
}

.side-menu li a.active, .side-menu li a:hover {
	color: #ff6600;
	font-weight: bold;
}

.content {
	flex-grow: 1;
	padding: 20px;
}

.content h3 {
    border-bottom: 2px solid black;
    padding-bottom: 10px;
    margin-bottom: 15px;
}

.faq-box ul, .notice-box ul {
	list-style: none;
	padding: 0;
	margin: 0;
}

.faq-box ul li, .notice-box ul li {
	padding: 8px 0;
	border-bottom: 1px solid #ddd;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.faq-box ul li:last-child, .notice-box ul li:last-child {
	border-bottom: none;
}

.faq-box ul li a, .notice-box ul li a {
	text-decoration: none;
	color: #333;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	display: inline-block;
	max-width: 90%;
}

.faq-box ul li a:hover, .notice-box ul li a:hover {
	color: #ff6600;
}

.date {
	font-size: 14px;
	color: #777;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

table, th, td {
	border: 1px solid #ddd;
	text-align: center;
}

th, td {
	padding: 10px;
}

th {
	background-color: #f4f4f4;
}

.pagination {
	margin-top: 20px;
	text-align: center;
}

.pagination a {
	padding: 8px 12px;
	margin: 0 5px;
	border: 1px solid #ddd;
	text-decoration: none;
	color: #333;
}

.pagination a.active {
	font-weight: bold;
	background-color: #007bff;
	color: white;
}
</style>
<script>
	function checkLogin(targetUrl) {
		var xhr = new XMLHttpRequest();
		xhr.open("GET", "${contextPath}/service/checkLogin", true);
		xhr.setRequestHeader("Content-Type", "application/json");
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				var response = JSON.parse(xhr.responseText);
				if (!response.isLoggedIn) {
					var confirmLogin = confirm("로그인 후 이용이 가능합니다. 로그인 하시겠습니까?");
					if (confirmLogin) {
						var adjustedUrl = targetUrl;
						if (targetUrl.startsWith("${contextPath}")) {
							adjustedUrl = targetUrl
									.substring("${contextPath}".length);
						}

						var saveUrlXhr = new XMLHttpRequest();
						saveUrlXhr
								.open(
										"GET",
										"${contextPath}/service/user/saveRedirectUrl?url="
												+ encodeURIComponent(adjustedUrl),
										true);
						saveUrlXhr.setRequestHeader("Content-Type",
								"application/json");
						saveUrlXhr.send();

						window.location.href = "${contextPath}/user/loginForm.do";
					}
				} else {
					var finalUrl = targetUrl;
					if (!targetUrl.startsWith("${contextPath}")) {
						finalUrl = "${contextPath}" + targetUrl;
					}
					window.location.href = finalUrl;
				}
			}
		};
		xhr.send();
	}
</script>
<body>
	
	<div class="container">

		<nav class="sidebar">
			<h2>
				<a href="${contextPath}/service/center.do"
					style="text-decoration: none; color: black;">고객센터</a>
			</h2>
			<ul class="side-menu">
				<li><a href="${contextPath}/service/notice.do">공지사항</a></li>
				<li><a href="${contextPath}/service/faq.do">자주 묻는 질문</a></li>
				<li><a href="${contextPath}/service/guide.do">이용안내</a></li>
				<li><a href="#"
					onclick="checkLogin('${contextPath}/inquiry/inquiry.do')">1:1
						문의하기</a></li>
				<li><a href="${contextPath}/service/delivery.do">배송안내</a></li>
			</ul>
		</nav>
		<div class="content">
		<h3> 문의 내역 </h3>
	<table>
		<thead>
			<tr>
				<th>작성일</th>
				<th>제목</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty inquiryList}">
					<c:forEach var="inquiry" items="${inquiryList}">
						<tr>
							<td><fmt:formatDate value="${inquiry.inquiry_date}"
									pattern="yyyy-MM-dd" /></td>
							<td><a href="inquiryDetail.do?id=${inquiry.inquiry_id}">
									${inquiry.inquiry_title} </a></td>
							<td><c:choose>
									<c:when test="${inquiry.status eq '문의완료'}">
										<span style="color: green;">문의 완료</span>
									</c:when>
									<c:otherwise>
										<span style="color: red;">문의 대기중</span>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="5">등록된 문의가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	</div>
	</div>
</body>
</html>