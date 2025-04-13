<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String clientId = "8O_1bqGXuNneG4LZnXdZ";  // 네이버에서 발급받은 Client ID
    String redirectURI = java.net.URLEncoder.encode("http://localhost:8090/cookit_project/naverUser/UserNaverCallback.do", "UTF-8");
    
    // 랜덤한 state 값 생성 (UUID 사용)
    String state = java.util.UUID.randomUUID().toString();  
    
    // 세션에 저장하여 나중에 콜백에서 검증
    session.setAttribute("naverState", state);  
    
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=" + clientId + "&redirect_uri=" + redirectURI + "&state=" + state;
%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" media="screen">
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
		
		#signup-container {
		    width: 400px; /* 컨테이너 너비 */
		    padding: 20px; /* 내부 여백 */
		    background-color: #fff; /* 흰색 배경 */
		    border-radius: 10px; /* 모서리를 둥글게 */
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
		    text-align: center; /* 텍스트 가운데 정렬 */
		}

        /* 타이틀 스타일 */
        .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center; /* 텍스트를 가운데 정렬 */
        }

        /* 회원가입 박스 */
        .signup-box {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin: 0 auto;
            width: 100%;
            max-width: 400px;
        }

        /* 버튼 공통 스타일 */
        .signup-button {
            display: block;
            width: 90%;
            padding: 15px;
            margin: 10px 0;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            color: white;
            text-align: center;
        }

        /* 일반 회원가입 버튼 */
        .basic-signup {
            background-color: #ff6600;
        }

        /* SNS 간편회원가입 구분선 */
        .divider {
            margin: 20px 0;
            font-size: 14px;
            color: #333;
            font-weight: bold;
            border-bottom: 1px solid #ddd;
            line-height: 0.1em;
        }

        /* SNS 버튼들 */
        .sns-signup.kakao {
            background-color: #ffeb00;
            color: #3c1e1e;
        }

        .sns-signup.naver {
            background-color: #03c75a;
            color: white;
        }

        .sns-signup.apple {
            background-color: #333333;
            color: white;
        }

        /* 버튼 hover 효과 */
        .signup-button:hover {
            opacity: 0.9;
        }
    </style>
    <script>
        function goToSignup() {
            // 일반 회원가입 페이지로 이동
            window.location.href = "${contextPath}/user/userForm.do";
        }
	</script>
	
</head>
<body>
    <div class="signup-container">
        <h1 class="title">회원가입</h1>
        <div class="signup-box">
            <!-- 일반 회원가입 버튼 -->
            <button onclick="goToSignup()" class="signup-button basic-signup">일반 회원가입</button>
            
            <!-- 구분선 -->
            <div class="divider">SNS 간편회원가입</div>
            
            <!-- SNS 회원가입 버튼들 -->
            <button class="signup-button sns-signup kakao">카카오로 3초만에 회원가입</button>
            <button onclick="location.href='<%= apiURL %>'" class="signup-button sns-signup naver">네이버로 회원가입</button>
            <button class="signup-button sns-signup apple">애플로 회원가입</button>
                    <!-- 네이버 스크립트 -->

        </div>
    </div>
</body>
</html>

