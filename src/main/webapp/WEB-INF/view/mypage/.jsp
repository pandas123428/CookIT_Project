<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>나의 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center; 
            align-items: center;    
            height: 100vh;          
            background-color: #f4f4f4; 
        }
        .container {
            width: 100%;
            max-width: 600px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-actions {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        .save-btn {
            background-color: #4CAF50;
            color: white;
        }
        .cancel-btn {
            background-color: #f44336;
            color: white;
        }
        .form-section {
            margin-bottom: 30px;
        }
        .form-section h2 {
            margin-bottom: 15px;
            font-size: 20px;
            color: #333;
        }
        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 15px;
        }
        .success-message {
            color: green;
            font-size: 14px;
            margin-bottom: 15px;
        }
    </style>
    <script>
        function validatePassword() {
            const password2 = document.querySelector('input[name="password2"]').value;
            const password3 = document.querySelector('input[name="password3"]').value;
            if (password2 !== password3) {
                alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>My Page</h1>
        

        <c:if test="${not empty message}">
            <p class="success-message">${message}</p>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <p class="error-message">${errorMessage}</p>
        </c:if>
        
        <form action="mypage/update" method="post" onsubmit="return validatePassword()">

            <div class="form-section">
                <h2>사용자 정보 수정</h2>
                <div class="form-group">
                    <label>아이디:</label>
                    <input type="text" name="name" value="${userInfo.name}" readonly>
                </div>
                <div class="form-group">
                    <label>사용자 이름:</label>
                    <input type="text" name="username" value="${userInfo.username}">
                </div>
                <div class="form-group">
                    <label>전화번호:</label>
                    <input type="text" name="phoneNum" value="${userInfo.phoneNum}">
                </div>
                <div class="form-group">
                    <label>이메일:</label>
                    <input type="email" name="email" value="${userInfo.email}">
                </div>
                <div class="form-group">
                    <label>주소:</label>
                    <input type="text" name="address" value="${userInfo.address}">
                </div>
            </div>
            
            <div class="form-section">
                <h2>비밀번호 변경</h2>
                <div class="form-group">
                    <label>기존 비밀번호:</label>
                    <input type="password" name="password1" required>
                </div>
                <div class="form-group">
                    <label>새 비밀번호:</label>
                    <input type="password" name="password2" minlength="8" required>
                </div>
                <div class="form-group">
                    <label>새 비밀번호 확인:</label>
                    <input type="password" name="password3" minlength="8" required>
                </div>
            </div>            
            
            <div class="form-actions">
                <button type="submit" class="save-btn">정보 수정</button>
                <button type="button" class="cancel-btn" onclick="window.location.href='/mypage';">취소</button>
            </div>
        </form>
    </div>
</body>
</html>