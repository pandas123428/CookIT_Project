<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ page import="com.cookit.user.vo.UserVO"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	UserVO sessionUser = (UserVO) session.getAttribute("userInfo");
%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="${contextPath}/resources/css/main.css" rel="stylesheet"
	type="text/css" media="screen">
<html>
<head>
<style>
body {
    font-family: Arial, sans-serif;
    justify-content: center;
    align-items: flex-start;
    margin: 0;
    padding: 20px;
    background-color: #f5f5f5;
}

.container {
    display: flex;
    width: 80%;
    max-width: 1200px;
}

/* 왼쪽 사이드바 스타일 */
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

/* 메인 컨텐츠 */
.main-content {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    gap: 20px;
}

/* 회원 정보 스타일 */
.section_info {
    width: 100%;
    max-width: 800px;
    background: #fff;
    padding: 25px;
    text-align: left;
}

.section_info h2 {
    font-size: 22px;
    margin-bottom: 15px;
    border-bottom: 2px solid black;
    padding-bottom: 5px;
}

.section_info p {
    font-size: 16px;
    margin: 10px 0;
    word-break: break-word;
}

.section_account {
    width: 100%;
    max-width: 800px;
    background: #fff;
    padding: 20px;
    border-radius: 10px;
    text-align: center;
}

.button-container {
    display: flex;
    justify-content: center;
    gap: 10px; 
}

.section_account a, .section_account button {
    display: inline-flex; 
    align-items: center;
    justify-content: center;
    width: 150px;
    height: 50px;
    background: #007bff;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-size: 16px;
    font-weight: bold;
    transition: background 0.3s ease;
    border: none;
    cursor: pointer;
}

.section_account a:hover {
    background: #0056b3;
}

.section_account button.danger {
    background: #dc3545;
}

.section_account button.danger:hover {
    background: #b02a37;
}

</style>

<script>
    function deleteUser() {
        if (!confirm("정말로 회원 탈퇴하시겠습니까?")) {
            return;
        }
        
        let userId = "<%= sessionUser.getUser_id() %>";  // 세션에서 현재 로그인한 사용자 ID 가져오기

        $.ajax({
            type: "POST",
            url: "${contextPath}/user/delete.do",
            data: { userId: userId },
            success: function(response) {
                alert(response);
                window.location.href = "${contextPath}/logout.do"; // 탈퇴 후 로그아웃 처리
            },
            error: function(xhr, status, error) {
                alert("회원 탈퇴 중 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    }
    
    function confirmDelete() {
        return confirm("정말로 회원 탈퇴를 하시겠습니까? 탈퇴 후에는 복구가 불가능합니다.");
    }
    
</script>

<meta charset="utf-8">
<title>회원 정보 페이지</title>
</head>

<body>
<div class="container">
    <div class="sidebar">
        <ul class="side-menu">
        	<h2><a href="${contextPath}/mypage/myPageMain.do" style="text-decoration: none; color: black;">마이페이지</a></h2>
            <li><a href="${contextPath}/mypage/orderDetail.do">주문 내역</a></li>
            <li><a href="${contextPath}/inquiry/inquiryList.do">문의 내역</a></li>
        </ul>
    </div>

    <div class="main-content">
        <div class="section_info">
            <h2>회원 정보</h2>
            <p><strong>아이디: ${userInfo.user_id}</strong></p>
            <p><strong>이메일: <%=sessionUser.getEmail1()%>@<%=sessionUser.getEmail2()%></strong></p>
            <p><strong>전화번호: <%=sessionUser.getPhone_num()%></strong></p>
            <p><strong>사용자이름: ${userInfo.username}</strong></p>
            <p><strong>우편번호: ${userInfo.zipcode}</strong></p>
            <p><strong>주소:<br> ${userInfo.roadAddress}<br> ${userInfo.jibunAddress}<br> ${userInfo.namujiAddress}</strong></p>
            <p><strong>보유 포인트: ${userInfo.cash_point}원</strong></p>
        </div>

			<div class="section_account">
				<div class="button-container">
					<a href="${contextPath}/user/updateForm.do">개인 정보 수정</a>

					<form action="${pageContext.request.contextPath}/user/delete.do"
						method="post" onsubmit="return confirmDelete();">
						<input type="hidden" name="userId"
							value="${sessionScope.userInfo.user_id}">
						<button type="submit" class="danger">회원 탈퇴</button>
					</form>
				</div>
			</div>

		</div>
</div>
</body>
</html>
