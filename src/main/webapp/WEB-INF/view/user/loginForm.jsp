<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String clientId = "8O_1bqGXuNneG4LZnXdZ"; // 네이버에서 발급받은 Client ID
String redirectURI = java.net.URLEncoder.encode("http://localhost:8090/cookit_project/naverUser/UserNaverCallback.do",
		"UTF-8");

// 랜덤한 state 값 생성 (UUID 사용)
String state = java.util.UUID.randomUUID().toString();

// 세션에 저장하여 나중에 콜백에서 검증
session.setAttribute("naverState", state);
String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=" + clientId + "&redirect_uri="
		+ redirectURI + "&state=" + state;
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link href="${contextPath}/resources/css/main.css" rel="stylesheet"
	type="text/css" media="screen">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<c:if test='${not empty message }'>
	<script>
		window.onload = function() {
			result();
		}

		function result() {
			alert("아이디나  비밀번호가 틀립니다. 다시 로그인해주세요");
		}
	</script>
</c:if>
<style>
#outer-container {
	display: flex;
	justify-content: center;
	align-items: center;

	background-color: #f0f0f0; /* 배경 색상 변경 가능 */
	margin: 0;
}

#login-form-container {
	background-color: #ffffff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	width: 300px;
	text-align: center;
}

h3 {
	color: #333;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 8px;
	margin: 10px 0;
	border: 1px solid #ccc;
	border-radius: 4px;
}

input[type="submit"], input[type="button"] {
	width: 48%;
	padding: 10px;
	margin-right: 4%;
	background-color: #ff7a00;
	color: white;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	cursor: pointer;
}

input[type="button"]:hover {
	background-color: #e66900;
}

.link-group {
	text-align: center;
	margin-top: 15px;
}

.link-group a {
	color: #555;
	text-decoration: none;
	margin: 0 5px;
}

.link-group a:hover {
	color: #ff7a00;
}

.social-login-buttons a {
	display: block;
	width: 100%;
	padding: 10px;
	margin: 5px 0;
	text-align: center;
	border-radius: 4px;
	text-decoration: none;
}

.kakao-login {
	background-color: #ffeb00;
	color: black;
}

.naver-login {
	background-color: #1ec800;
	color: white;
}

.apple-login {
	background-color: #333333;
	color: white;
}
</style>
</head>
<div id="outer-container">
	<div id="login-form-container">
		<h3>회원 로그인</h3>
		<form action="${contextPath}/user/login.do" method="post">
			<input name="user_id" type="text" placeholder="아이디를 입력하세요" required
				minlength="4" /> <input name="user_pwd" type="password"
				placeholder="비밀번호를 입력하세요" required minlength="6" />
			<div style="display: flex; justify-content: space-between;">
				<input type="submit" value="로그인" /> <input type="button"
					value="초기화" />
			</div>

			<div class="link-group">
				<a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a> | <a
					href="${contextPath}/user/loginSelectForm.do">회원가입</a>
			</div>

			<div class="social-login-buttons">
				<a href="#" class="kakao-login">카카오로 시작하기</a> <a
					onclick="location.href='<%=apiURL%>'" class="naver-login">네이버로
					시작하기</a> <a href="#" class="apple-login">애플로 시작하기</a>
			</div>
		</form>
	</div>
</div>
</html>