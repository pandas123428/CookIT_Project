<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%> 
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" media="screen">
<html>
<head>
<meta charset="utf-8">
<title>나의 페이지</title>
    
    <script>
        function validatePassword() {
            const password2 = document.querySelector('input[name="password2"]').value;
            const password3 = document.querySelector('input[name="password3"]').value;
            console.log("새 비밀번호:", password2);
            console.log("비밀번호 확인:", password3);
            if (password2 !== password3) {
                alert("새 비밀번호가 일치하지 않습니다.");
                return false;
            }
            return true;
        }
        function updateEmailDomain() {
            var emailSelect = document.getElementById("email_select");
            var email2 = document.getElementById("email2");

            if (emailSelect.value !== "non") {
              email2.value = emailSelect.value;
            } else {
              email2.value = "";
            }
          }
    </script>
    
    <script type="text/javascript">
        window.onload = function() {
            var message = "<%= request.getAttribute("message") %>";
            var redirectUrl = "<%= request.getAttribute("redirectUrl") %>";
            if (message != "null" && message !== "null" && message.trim() !== "") {
                alert(message);
                if (redirectUrl != "null" && redirectUrl !== "null" && redirectUrl.trim() !== "") {
                    location.href = redirectUrl;
                }
            }
        };
    </script>

</head>
<body>
    <div class="container">
        
        <form action="${contextPath}/user/updateUser" method="post">
            <div class="form-section">
                <h2>사용자 정보 수정</h2>
                
                <div class="form-group">
                    <label>아이디:</label>
                    <input type="text" name="user_id" value="${userInfo.user_id}" readonly>
                </div>
                
                 <div class="form-group">
                    <label>이메일:</label>
                    <input size="10px"   type="text" name="email1" value="${userInfo.email1}" required/> @ <input  size="10px"  type="text" name="email2" id="email2" value="${userInfo.email2}" required/> 
						  <select name="email_select" id="email_select" onChange="updateEmailDomain()">
									<option value="non">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="daum.net">daum.net</option>
									<option value="gmail.com">gmail.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="paran.com">paran.com</option>
									<option value="nate.com">nate.com</option>
									<option value="google.com">google.com</option>
									<option value="empal.com">empal.com</option>
									<option value="korea.com">korea.com</option>
									<option value="freechal.com">freechal.com</option>
							</select>
                </div>
                
                <div class="form-group">
                    <label>연락처:</label>
                    <input type="text" name="phonenum" value="${userInfo.phone_num}">
                </div>
                
                <div class="form-group">
                    <label>사용자 이름:</label>
                    <input type="text" name="username" value="${userInfo.username}">
                </div>
                
                <div class="form-group">
                    <label>도로명주소:</label>
                    <input type="text" name="roadAddress" value="${userInfo.roadAddress}">
                </div>
                
                  <div class="form-group">
                    <label>지번 주소:</label>
                    <input type="text" name="jibunAddress" value="${userInfo.jibunAddress}">
                </div>
                
                 <div class="form-group">
                    <label>나머지 주소:</label>
                    <input type="text" name="namujiAddress" value="${userInfo.namujiAddress}">
                </div>
            <div class="form-actions">
                <button type="submit" class="save-btn">정보 수정</button>
                <button type="button" class="cancel-btn" onclick="window.location.href='${contextPath}/mypage/myPageMain.do';">취소</button>
            </div>
            </div>
            </form>
            
            <form action="${contextPath}/user/updatePassword" method="post" onsubmit="return validatePassword()">
            <div class="form-section">
            
                <h2>비밀번호 변경</h2>
                
                <div class="form-group">
                    <label>새 비밀번호:</label>
                    <input type="password" name="password2" minlength="6" required>
                </div>
                
                <div class=	"form-group">
                    <label>새 비밀번호 확인:</label>
                    <input type="password" name="password3" minlength="6" required>
                </div>
                
            <div class="form-actions">
                <button type="submit" class="save-btn">비밀번호 변경</button>
            </div>
            
            </div>            
            </form>

    </div>
</body>
</html>