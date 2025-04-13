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
<meta charset="utf-8">
<title>사용자 문의내역 확인 리스트</title>
</head>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f8f8f8;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1000px;
    margin: 40px auto;
    padding: 20px;
    background: white;
    border-radius: 8px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
}

/* 문의 내역 제목 */
h3 {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
}

/* 테이블 스타일 */
table {
    width: 100%;
    border-collapse: collapse;
    background-color: #ffffff;
    border-radius: 8px;
    overflow: hidden;
}

thead {
    background-color: #ff6600;
    color: white;
}

th, td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: center;
    font-size: 16px;
}

th {
    font-weight: bold;
}

/* 행 배경색 조정 */
tr:nth-child(even) {
    background-color: #f9f9f9;
}

/* 상태 컬러 강조 */
.status-waiting {
    color: red;
    font-weight: bold;
}

.status-completed {
    color: blue;
    font-weight: bold;
}

/* 답변하기 버튼 스타일 */
.answer-btn {
    display: inline-block;
    padding: 8px 15px;
    background-color: #ff6600;
    color: white;
    text-decoration: none;
    font-weight: bold;
    border-radius: 5px;
    transition: background-color 0.3s ease-in-out;
}

.answer-btn:hover {
    background-color: #e65c00;
}

</style>
<body>
<div class="container">
    <h3>고객 문의내역</h3>
    <table>
        <thead>
            <tr>
                <th>문의번호</th>
                <th>사용자ID</th>
                <th>문의유형</th>
                <th>제목</th>
                <th>작성일</th>
                <th>처리상태</th>
                <th>문의답변</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="inquiry" items="${inquiryList}">
                <tr>
                    <td>${inquiry.inquiry_id}</td>
                    <td>${inquiry.user_id}</td>
                    <td>${inquiry.inquiry_type}</td>
                    <td>
                        <a href="adminInquiryDetail.do?id=${inquiry.inquiry_id}">${inquiry.inquiry_title}</a>
                    </td>
                    <td><fmt:formatDate value="${inquiry.inquiry_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${inquiry.status eq '문의대기'}">
                                <span class="status-waiting">문의 대기중</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-completed">문의 완료</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="adminInquiryDetail.do?id=${inquiry.inquiry_id}" class="answer-btn">답변하기</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
