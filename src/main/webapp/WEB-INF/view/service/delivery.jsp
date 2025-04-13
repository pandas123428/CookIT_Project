<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
    request.setCharacterEncoding("UTF-8");
%> 

<html>
<head>
    <meta charset="UTF-8">

<title>배송안내</title>
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

.content h3 {
    border-bottom: 2px solid black;
    padding-bottom: 10px;
    margin-bottom: 15px;
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

.side-menu li a.active,
.side-menu li a:hover {
    color: #ff6600;
    font-weight: bold;
}

.content {
	flex-grow: 1;
	padding: 20px;
}

.pagination {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

.pagination a {
    text-decoration: none;
    padding: 8px 12px;
    margin: 0 5px;
    border: 1px solid #ddd;
    color: #333;
    border-radius: 5px;
}

.pagination a.active {
    color: #ff6600;
    font-weight: bold;
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
				<li><a href="#" onclick="checkLogin('${contextPath}/inquiry/inquiry.do')">1:1
						문의하기</a></li>
				<li><a href="${contextPath}/service/delivery.do">배송안내</a></li>
			</ul>
		</nav>
		<div class="content">
			<div class="section-title">
				<h3>배송안내</h3>
			</div>
			<p>
				<img src="${contextPath}/resources/image/delivery_info.png">
			</p>

			<div class="pagination">
				<a href="#">〈</a>
				<a href="#" class="active">1</a>
				<a href="#">〉</a>
			</div>
		</div>
	</div>
</body>
</html>
