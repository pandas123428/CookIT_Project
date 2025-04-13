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
    <title>1:1문의하기</title>
<style>

body {
    font-family: Arial, sans-serif;
    background-color: #ffffff;
    margin: 0;
    padding: 0;
}

.container {
    display: flex;
    max-width: 1200px;
    margin: 20px auto;
    align-items: flex-start;
}

.sidebar {
    width: 230px;
    background: #f8f8f8;
    padding: 20px;
    flex-shrink: 0;
}

.sidebar h2 {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 15px;
    padding-left: 10px;
}

.side-menu {
    list-style: none;
    padding: 0;
    margin: 0;
}

.side-menu li {
    padding: 12px 15px;
    font-size: 15px;
    border-bottom: 1px solid #ddd;
}

.side-menu li:last-child {
    border-bottom: none;
}

.side-menu li a {
    text-decoration: none;
    color: #333;
    display: block;
    transition: color 0.3s ease-in-out;
}

.side-menu li a:hover {
    color: #ff6600;
    font-weight: bold;
}

.content {
    flex-grow: 1;
    max-width: 850px;
    padding: 20px;
    background-color: #ffffff;
    margin-left: 30px; 
}

.detail-title {
    font-size: 22px;
    font-weight: bold;
    text-align: left;
    margin-bottom: 10px;
}

.separator {
    width: 100%;
    height: 2px;
    background-color: black;
    margin: 10px 0 20px 0;
}

table {
    width: 100%;
    border-collapse: collapse;
    background-color: #fff;
    margin-top: 10px;
}

th, td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: left;
}

th {
    background-color: #f2f2f2;
    font-weight: bold;
    width: 150px; 
}

td {
    background-color: #ffffff;
}

tr:nth-child(even) {
    background-color: #f9f9f9;
}

.back-btn-container {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

.back-btn {
    padding: 12px 20px;
    background-color: #ff6600;
    color: white;
    text-align: center;
    max-width: 250px;
    text-decoration: none;
    border-radius: 5px;
    font-size: 16px;
    font-weight: bold;
    border: none;
    transition: background-color 0.3s ease-in-out;
    display: inline-block;
}

.back-btn:hover {
    background-color: #e65c00;
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
	
    window.onload = function() {
        var answerContent = "${inquiry.answer_content}";
        if (answerContent.trim() !== "" && answerContent !== "null") {
            document.getElementById("answerRow").style.display = "table-row";
        }
    };
</script>
<body>
	<div class="container">
    <nav class="sidebar">
        <h2>고객센터</h2>
        <ul class="side-menu">
            <li><a href="${contextPath}/service/notice.do">공지사항</a></li>
            <li><a href="${contextPath}/service/faq.do">자주 묻는 질문</a></li>
            <li><a href="${contextPath}/service/guide.do">이용안내</a></li>
            <li><a href="#" onclick="checkLogin('${contextPath}/inquiry/inquiry.do')">1:1 문의하기</a></li>
            <li><a href="${contextPath}/service/delivery.do">배송안내</a></li>
        </ul>
    </nav>

    <div class="content">
        <h3 class="detail-title">문의 상세 내역</h3>
        <div class="separator"></div>

        <table>
            <tr>
                <th>작성일</th>
                <td><fmt:formatDate value="${inquiry.inquiry_date}" pattern="yyyy-MM-dd" /></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${inquiry.user_id}</td>
            </tr>
            <tr>
                <th>문의 유형</th>
                <td>${inquiry.inquiry_type}</td>
            </tr>
            <tr>
                <th>제목</th>
                <td>${inquiry.inquiry_title}</td>
            </tr>
            <tr>
                <th>문의 상품</th>
                <td>${inquiry.inquiry_product}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td class="content">${inquiry.inquiry_content}</td>
            </tr>
            <tr id="answerRow" style="display: none;">
                <th>관리자 답변</th>
                <td>${inquiry.answer_content}</td>
            </tr>
        </table>

        <div class="back-btn-container">
            <a href="${contextPath}/inquiry/inquiryList.do" class="back-btn">← 문의 목록으로</a>
        </div>
    </div>
</div>

</body>
</html>

