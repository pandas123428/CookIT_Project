<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
/* 기본 스타일 */
body {
    font-family: 'Arial', sans-serif;
    background-color: #f8f9fa;
    margin: 20px;
    padding: 20px;
}

h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
}

/* 테이블 스타일 */
table {
    width: 100%;
    border-collapse: collapse;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    overflow: hidden;
}

thead {
    background-color: #007bff;
    color: white;
    text-align: left;
}

th, td {
    padding: 12px;
    border-bottom: 1px solid #ddd;
}

tbody tr:hover {
    background-color: #f1f1f1;
    transition: background-color 0.3s ease-in-out;
}

/* 반응형 테이블 */
@media (max-width: 768px) {
    table {
        display: block;
        overflow-x: auto;
        white-space: nowrap;
    }
}

//* 버튼 스타일 */
.edit-btn, .delete-btn {
    padding: 6px 12px;
    margin: 2px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
}

.edit-btn {
    background-color: #ffc107;
    color: black;
}

.edit-btn:hover {
    background-color: #e0a800;
}
.detail-btn {
    background-color: #ffc107;
    color: black;
}

.detail-btn:hover {
    background-color: #e0a800;
}

.delete-btn {
    background-color: #dc3545;
    color: white;
}

.delete-btn:hover {
    background-color: #c82333;
}
</style>
</head>
<body>
    <h2>회원 관리</h2>
    
    <!-- 회원 리스트 테이블 -->
    <table border="1">
        <thead>
            <tr>
                <th>회원 ID</th>
                <th>회원 타입</th>                
                <th>회원 이름</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>주소</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${user_list}">
                <tr>
                    <td>${user.user_id}</td> 
                    <td>${user.user_type}</td> 
                    <td>${user.username}</td> 
                    <td>${user.phone_num}</td> 
                    <td>${user.email1}@${user.email2}</td> 
                    <td>${user.roadAddress}${user.jibunAddress}${user.namujiAddress}</td> 
                    <td>
		                <button class="edit-btn" onclick="editUser('${user.user_id}')">수정</button>
		                <button class="detail-btn" onclick="detailUser('${user.user_id}')">상세</button>
		                <button class="delete-btn" onclick="deleteUser('${user.user_id}')">탈퇴</button>
		            </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>