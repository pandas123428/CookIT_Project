<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" media="screen">

<style>

	
   
   .sidebar ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .sidebar ul li {
        padding: 8px;
        display: flex;
        align-items: center;
        cursor: pointer;
        border-radius: 5px;
        transition: background 0.2s ease-in-out;
        
    }
    a {
        text-decoration: none;
        color: black;
    }
    .sidebar ul li:hover {
        background: #e0e0e0;
    }
</style>

</head>
<body>

    <div class="container">
        <!-- 왼쪽 메뉴 -->
        <div class="sidebar">
            <ul>
                <li><a href="${contextPath}/admin/goForm.do">상품 등록</a></li>
                <li><a href="${contextPath}/admin/productList.do">상품 리스트</a></li>
            </ul>
        </div>

</body>
</html>
