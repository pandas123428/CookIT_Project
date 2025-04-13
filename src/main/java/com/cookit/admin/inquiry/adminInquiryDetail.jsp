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
<title>문의 상세 및 답변</title>
</head>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f8f8f8;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 800px;
	margin: 40px auto;
	padding: 20px;
	background: white;
	border-radius: 8px;
	box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
}

/* 제목 스타일 */
h2, h3 {
	text-align: center;
	font-size: 22px;
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

th, td {
	border: 1px solid #ddd;
	padding: 12px;
	text-align: left;
	font-size: 16px;
}

th {
	background-color: #f8f8f8;
	font-weight: bold;
	width: 180px;
	text-align: center;
}

td {
	background-color: white;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

/* 관리자 답변 폼 스타일 */
.reply-form {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 20px;
}

.reply-form textarea {
	width: 90%;
	max-width: 700px;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ddd;
	border-radius: 5px;
	resize: none;
	background-color: #f9f9f9;
}

/* 버튼 스타일 */
.submit-btn {
	margin-top: 15px;
	padding: 10px 20px;
	background-color: #ff6600;
	color: white;
	border: none;
	font-size: 16px;
	font-weight: bold;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease-in-out;
}

.submit-btn:hover {
	background-color: #e65c00;
}
</style>
<body>
	<div class="container">
		<h2>문의 상세</h2>
		<table>
			<tr>
				<th>작성자</th>
				<td>${inquiry.user_id}</td>
			</tr>
			<tr>
				<th>문의 유형</th>
				<td>${inquiry.inquiry_type}</td>
			</tr>
			<tr>
				<th>문의 상품</th>
				<td>${inquiry.inquiry_product}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${inquiry.inquiry_title}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td><fmt:formatDate value="${inquiry.inquiry_date}"
						pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td class="content">${inquiry.inquiry_content}</td>
			</tr>
		</table>

		<h3>관리자 답변</h3>
		<form action="submitInquiryAnswer.do" method="POST" class="reply-form">
			<input type="hidden" name="inquiry_id" value="${inquiry.inquiry_id}">
			<textarea name="answer_content" rows="5" required></textarea>
			<button type="submit" class="submit-btn">답변 등록</button>
		</form>
	</div>

</body>
</html>
