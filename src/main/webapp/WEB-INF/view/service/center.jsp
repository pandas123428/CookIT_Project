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
<title>고객센터</title>
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


.faq-section {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	max-width: 1000px;
	margin: auto;
}

.faq-box, .notice-box {
	width: 48%;
	padding: 20px;
}

.faq-box h3, .notice-box h3 {
	font-size: 18px;
	margin-bottom: 10px;
	border-bottom: 2px solid black;
	padding-bottom: 5px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.view-all {
	text-decoration: none;
	color: black;
	font-size: 14px;
	padding: 5px 10px;
	border: 1px solid #ddd;
	border-radius: 15px;
	font-weight: normal;
}

.view-all:hover {
	background: #f5f5f5;
	color: #ff6600;
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
</head>

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

			<div class="faq-section">
				<div class="faq-box">
					<h3>
						자주 묻는 질문 <a href="${contextPath}/service/faq.do" class="view-all">전체보기</a>
					</h3>
					<ul>
						<li><a href="${contextPath}/service/faq.do"> 주문을 취소하고
								싶어요! 배송 희망일 변경하고 싶어요!</a></li>
						<li><a href="${contextPath}/service/faq.do">상품을 수령 후, 다음날
								사용해도 되나요?</a></li>
						<li><a href="${contextPath}/service/faq.do">택배 배송사고 발생시
								어떻게 되나요?</a></li>
						<li><a href="${contextPath}/service/faq.do">제주/도서산간 지역도
								배송되나요?</a></li>
						<li><a href="${contextPath}/service/faq.do">배송 주소를 잘못
								기재했는데 변경할 수 있나요?</a></li>
					</ul>
				</div>

				<div class="notice-box">
					<h3>
						공지사항 <a href="${contextPath}/service/notice.do" class="view-all">전체보기</a>
					</h3>
					<ul>
						<li><a href="${contextPath}/service/notice_view.do">회원
								등급별 혜택</a> <span class="date">2024.03.12</span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
