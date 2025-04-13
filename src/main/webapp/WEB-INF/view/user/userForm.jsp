<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" media="screen">
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<title>회원 가입 창</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
    }
    h3 {
        color: #333;
    }
    #detail_table {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    table td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }
    .fixed_join {
        width: 150px;
        font-weight: bold;
    }
    input[type="text"], input[type="password"], select {
        width: 200px;
        padding: 8px;
        margin: 5px 0;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    input[type="submit"], input[type="reset"], input[type="button"] {
        background-color: #5cb85c;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    input[type="submit"]:hover, input[type="reset"]:hover, input[type="button"]:hover {
        background-color: #4cae4c;
    }
    .dot_line {
        border-bottom: 1px dotted #ddd;
    }
    .clear {
        clear: both;
    }
</style>
<script>
function updateEmailDomain() {
    var emailSelect = document.getElementById("email_select");
    var email2 = document.getElementById("email2");

    if (emailSelect.value !== "non") {
      email2.value = emailSelect.value;
    } else {
      email2.value = "";
    }
  }
function execDaumPostcode() {
	  var postcode = new daum.Postcode({
	    oncomplete: function(data) {
	      var fullRoadAddr = data.roadAddress;
	      var extraRoadAddr = '';

	      if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
	        extraRoadAddr += data.bname;
	      }
	      if (data.buildingName !== '' && data.apartment === 'Y') {
	        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	      }
	      if (extraRoadAddr !== '') {
	        extraRoadAddr = ' (' + extraRoadAddr + ')';
	      }
	      if (fullRoadAddr !== '') {
	        fullRoadAddr += extraRoadAddr;
	      }

	      document.getElementById('zipcode').value = data.zonecode;
	      document.getElementById('roadAddress').value = fullRoadAddr;
	      document.getElementById('jibunAddress').value = data.jibunAddress;

	      if (data.autoRoadAddress) {
	        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	      } else if (data.autoJibunAddress) {
	        var expJibunAddr = data.autoJibunAddress;
	        document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	      } else {
	        document.getElementById('guide').innerHTML = '';
	      }

	      postcode.close();
	    }
	  });

	  postcode.open();
	};

function fn_overlapped(){
    var _id=$("#_user_id").val();
    if(_id==''){
   	 alert("ID를 입력하세요");
   	 return;
    }
    $.ajax({
       type:"post",
       async:false,  
       url:"${contextPath}/user/overlapped.do",
       dataType:"text",
       data: {id:_id},
       success:function (data,textStatus){
          if(data=='false'){
       	    alert("사용할 수 있는 ID입니다.");
       	    $('#user_id').val(_id);
          }else{
        	  alert("사용할 수 없는 ID입니다.");
          }
       },
       error:function(data,textStatus){
          alert("에러가 발생했습니다.");ㅣ
       },
       complete:function(data,textStatus){
          //alert("작업을완료 했습니다");
       }
    });  //end ajax	 
 }	
</script>
</head>
<body>
<h3>필수입력사항</h3>
	<form action="${contextPath}/user/addUser.do" method="post">	
	<div id="detail_table">
		<table>
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">아이디</td>
					<td>
					  <input type="text" name="user_id"  id="_user_id"  size="20" required/>					  
					  <input type="button"  id="btnOverlapped" value="중복체크" onClick="fn_overlapped()" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">비밀번호</td>
					<td><input name="user_pwd" type="password" size="20" required/></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이름</td>
					<td><input name="username" type="text" size="20" required/></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">성별</td>
					<td><input type="radio" name="gender" value="female" required/>
						여성<span style="padding-left:120px"></span>
						 <input type="radio" name="gender" value="male" checked />남성
					</td>
				</tr>			
				<tr class="dot_line">
					<td class="fixed_join">휴대폰번호</td>
					<td><select  name="phone_num">
							<option>없음</option>
							<option selected value="010">010</option>							
					</select> - <input size="10px"  type="text" name="phone_num" required minlength="4"> - <input size="10px"  type="text"name="phone_num" required minlength="4"><br> <br> 
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이메일<br>(e-mail)</td>
					<td><input size="10px"   type="text" name="email1" required/> @ <input  size="10px"  type="text" name="email2" id="email2" required/> 
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
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">주소</td>
					<td>
					   <input type="text" id="zipcode" name="zipcode" size="10" required> <a href="javascript:execDaumPostcode()">우편번호검색</a>
					  <br>
					  <p> 
					  도로명 주소: <input type="text" id="roadAddress" name="roadAddress" size="50" required><br><br>
					  지번 주소:<br><input type="text" id="jibunAddress"  name="jibunAddress" size="50" required><br><br>
					  나머지 주소: <input type="text"  name="namujiAddress" size="50" required/>
					 <!--   <span id="guide" style="color:#999"></span> -->
					   </p>
					</td>
				</tr>
			</tbody>
		</table>
		</div>
		<div class="clear">
		<br><br>
		<table align=center>
		<tr >
			<td >
				<input type="submit"  value="회원 가입">
				<input  type="reset"  value="다시입력">
			</td>
		</tr>
	</table>
	</div>
</form>	
</body>
</html>