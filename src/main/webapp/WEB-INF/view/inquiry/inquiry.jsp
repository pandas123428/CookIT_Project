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
.container {
    display: flex;
    max-width: 1200px;
    margin: 20px auto;
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

.section-title {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 20px;
    border-bottom: 2px solid black;
    padding-bottom: 10px;
}

.inquiry-form {
    width: 100%;
    max-width: 700px;
    margin-top: 20px;
}

.inquiry-form table {
    width: 100%;
    border-collapse: collapse;
}

.inquiry-form th {
    text-align: left;
    padding: 10px;
    width: 150px;
    font-weight: bold;
}

.inquiry-form td {
    padding: 10px;
}

.inquiry-form input, .inquiry-form select, .inquiry-form textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
}

.inquiry-form textarea {
    height: 150px;
    resize: none;
}

.button-container {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}

.button-container {
    display: flex;
    justify-content: center;
    gap: 20px; 
    margin-top: 20px;
}

.submit-btn, .cancel-btn {
    display: inline-block;
    width: 150px;  
    height: 50px;  
    font-size: 18px;  
    padding: 10px 0; 
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.submit-btn {
    background: #ff6600;
    color: white;
}

.cancel-btn {
    background: #ccc;
    color: black;
}

.submit-btn:hover {
    background: #cc5500;
}

.cancel-btn:hover {
    background: #999;
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
                        adjustedUrl = targetUrl.substring("${contextPath}".length);
                    }

                    var saveUrlXhr = new XMLHttpRequest();
                    saveUrlXhr.open("GET",
                            "${contextPath}/service/user/saveRedirectUrl?url=" + encodeURIComponent(adjustedUrl),
                            true);
                    saveUrlXhr.setRequestHeader("Content-Type", "application/json");
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
	<h2><a href="${contextPath}/service/center.do" style="text-decoration:none;color:black;">고객센터</a></h2>
        <ul class="side-menu">
            <li><a href="${contextPath}/service/notice.do">공지사항</a></li>
            <li><a href="${contextPath}/service/faq.do">자주묻는 질문</a></li>
            <li><a href="${contextPath}/service/guide.do">이용안내</a></li>
            <li><a href="#" onclick="checkLogin('${contextPath}/service/inquiry.do')">1:1 문의하기</a></li>
            <li><a href="${contextPath}/service/delivery.do">배송안내</a></li> 
        </ul>
    </nav>
        
    <div class="content">
        <div class="section-title">1:1 문의하기</div>

        <form action="${contextPath}/inquiry/submitInquiry.do" method="post" class="inquiry-form">
            <table>
                <tr>
                    <th>문의 유형</th>
                    <td>
                        <select name="inquiry_type">
                            <option value="">문의 유형을 선택해 주세요</option>
                            <option value="주문/결제">주문/결제</option>
                            <option value="취소/반품">취소/반품</option>
                            <option value="상품">상품관련</option>
                            <option value="베송">배송관련</option>
                            <option value="포인트">포인트</option>
                            <option value="기타">기타</option>

                        </select>
                    </td>
                </tr>
                <tr>
                    <th>주문 상품</th>
                    <td>
                        <input type="text" name="inquiry_product" placeholder="문의하실 상품을 입력해 주세요">
                    </td>
                </tr>
                <tr>
                    <th>문의 제목</th>
                    <td>
                        <input type="text" name="inquiry_title" placeholder="문의 제목을 입력해 주세요">
                    </td>
                </tr>
                <tr>
                    <th>문의 내용</th>
                    <td>
                        <textarea name="inquiry_content" id="inquiry_content" placeholder="문의 내용을 입력해 주세요"></textarea>
                        <div style="text-align: right; font-size: 12px; color: gray;">
                        </div>
                    </td>
                </tr>
            </table>
            <div class="button-container">
            <button type="submit" class="submit-btn">문의</button>
            <button type="submit" class="cancel-btn" onclick="location.href='${contextPath}/main/main.do'">취소</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>

