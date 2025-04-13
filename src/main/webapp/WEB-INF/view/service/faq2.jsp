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
<meta charset="UTF-8">
<title>자주묻는질문</title>
<style>
.container {
	display: flex;
	max-width: 1200px;
	margin: 20px auto;
	justify-content: flex-start;
	align-items: flex-start;
}

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

.side-menu li a.active, .side-menu li a:hover {
	color: #ff6600;
	font-weight: bold;
}

.search-box {
	text-align: center;
	background: #f8f8f8;
	padding: 20px;
	margin-bottom: 20px;
}

.search-box input {
	width: 60%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.search-box button {
	padding: 10px 20px;
	font-size: 16px;
	background: #000;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.search-box button:hover {
	background: #333;
}

.faq-header {
	border-bottom: 2px solid black;
	padding-bottom: 10px;
	margin-bottom: 20px;
}

.faq-subject {
	cursor: pointer;
	background-color: #f8f8f8;
	display: flex;
	align-items: center;
	justify-content: flex-start;
	gap: 40px;
}

.faq-subject .category {
	font-weight: bold;
	flex-shrink: 0;
}

.faq-subject .text {
	font-weight: bold;
	flex-grow: 1;
	text-align: left;
}

.faq-subject .date {
	color: #777;
	font-size: 14px;
	flex-shrink: 0;
}

.answer {
	max-height: 0;
	overflow: hidden;
	transition: max-height 0.3s ease-out;
	padding: 0 10px;
	background-color: #fff;
}

.answer.open {
	max-height: 500px;
	padding: 10px;
}

.toggle-icon {
	cursor: pointer;
	flex-shrink: 0;
}

.pagination {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}

.pagination a {
    text-decoration: none;
    padding: 8px 12px;
    margin: 0 5px;
    border: 1px solid #ddd;
    color: #333;
    border-radius: 5px;
}

.pagination a.active {
    color: #ff6600;
    font-weight: bold;
}


</style>
<script>
	function checkLogin(targetUrl) {
		var xhr = new XMLHttpRequest();
		xhr.open("GET", "${contextPath}/service/checkLogin", true);
		xhr.setRequestHeader("Content-Type", "application/json");
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				var response = JSON.parse(xhr.responseText);
				if (!response.isLoggedIn) {
					var confirmLogin = confirm("로그인 후 이용이 가능합니다. 로그인 하시겠습니까?");
					if (confirmLogin) {
						var adjustedUrl = targetUrl;
						if (targetUrl.startsWith("${contextPath}")) {
							adjustedUrl = targetUrl
									.substring("${contextPath}".length);
						}

						var saveUrlXhr = new XMLHttpRequest();
						saveUrlXhr
								.open(
										"GET",
										"${contextPath}/service/user/saveRedirectUrl?url="
												+ encodeURIComponent(adjustedUrl),
										true);
						saveUrlXhr.setRequestHeader("Content-Type",
								"application/json");
						saveUrlXhr.send();

						window.location.href = "${contextPath}/user/loginForm.do";
					}
				} else {
					var finalUrl = targetUrl;
					if (!targetUrl.startsWith("${contextPath}")) {
						finalUrl = "${contextPath}" + targetUrl;
					}
					window.location.href = finalUrl;
				}
			}
		};
		xhr.send();
	}

	$(document).ready(function() {
		$(".faq-subject").click(function() {
			var target = $(this).next(".answer");

			$(".answer").not(target).removeClass("open");
			$(".toggle-icon").text("▼");

			if (target.hasClass("open")) {
				target.removeClass("open");
				$(this).find(".toggle-icon").text("▼");
			} else {
				target.addClass("open");
				$(this).find(".toggle-icon").text("▲");
			}
		});
	});
</script>
</head>

<body>

	<div class="container">

		<nav class="sidebar">
			<h2>
				<a href="${contextPath}/service/center.do"
					style="text-decoration: none; color: black;">고객센터</a>
			</h2>
			<ul class="side-menu">
				<li><a href="${contextPath}/service/notice.do">공지사항</a></li>
				<li><a href="${contextPath}/service/faq.do">자주묻는 질문</a></li>
				<li><a href="${contextPath}/service/guide.do">이용안내</a></li>
				<li><a href="#"
					onclick="checkLogin('${contextPath}/inquiry/inquiry.do')">1:1
						문의하기</a></li>
				<li><a href="${contextPath}/service/delivery.do">배송안내</a></li>
			</ul>
		</nav>

		<div class="content">
			<div class="search-box">
				<h3>자주묻는 질문 검색</h3>
				<input type="text" placeholder="궁금하신 내용을 입력해 주세요.">
				<button>검색</button>
			</div>

			<div class="faq-header">
				<h2>자주묻는 질문</h2>
			</div>

			<div class="faq-subject">
				<span class="category">기타</span>
				<p class="text">환불/보상/반품 규정은 어떻게 되나요?</p>
				<span class="date">2025-01-26</span> <span class="toggle-icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">환불/보상/반품 규정은 [이용안내>환불/보상]에 구체적으로 나와 있으며,<br>
				각 상품 하단에 명시되어 있습니다. 파손, 누락 및 음식의 손상 등에 대해서는<br>
				환불이 이루어지지만, 단순한 맛과 구매의향의 변화에 따른 환불 및 반품, 교환은 불가합니다.<br><br>
				이는 제품의 특성상 반품이 불가한 음식이기 때문임으로<br>
				주문 전 꼭 희망하시는 상품을 꼼꼼히 확인하신 후 주문해 주시기 바랍니다.<br>
				배송준비중일 경우에는 취소가 불가합니다.</p>
			</div>
			
			<div class="faq-subject">
				<span class="category">기타</span>
				<p class="text">상품후기는 어떻게 작성하나요?</p>
				<span class="date">2025-01-25</span> <span class="toggle-icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">수령하신 상품을 수취확인하시면 상품후기를 작성할 수 있습니다.<br>
				마이페이지 - 나의 활동관리 - 리뷰에서 작성 가능한 상품 후기를 확인하실 수 있습니다.</p>
			</div>
			
			<div class="faq-subject">
				<span class="category">기타</span>
				<p class="text">원하는 상품을 찾으려면 어떻게 하나요?</p>
				<span class="date">2025-01-24</span> <span class="toggle-icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">마이셰프의 모든 상품은 검색기능을 통해 직접 검색하실 수 있습니다.<br>
				원하시는 상품명의 일부만 입력 시에도 검색이 가능하나 검색결과가 없는 경우 품절, 판매종료된 상품일 수 있습니다.<br><br>
				상품의 판매 여부 등 상세 확인이 필요하신 경우 마이셰프 고객센터(1668-3980 또는 1:1문의)로 문의해 주시면 신속하게 도움 드리겠습니다.</p>
			</div>
			
			<div class="faq-subject">
				<span class="category">기타</span>
				<p class="text">회원 아이디와 비밀번호를 분실시 어떻게 해야하나요?</p>
				<span class="date">2025-01-23</span> <span class="toggle-icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">고객님의 회원 아이디와 비빌번호는 절차에 따라 확인이 가능합니다.<br><br>
				1) 회원 ID를 잊어버린 경우에는 메인화면>로그인 클릭 후, 아이디/비밀번호 찾기를<br>
				활용하시면 됩니다.<br><br>
				2) 회원 비밀번호를 잊어버린 경우 메인화면>로그인 위치에서 비밀번호 찾기로 확인하시면 됩니다.<br>
				아이디/고객명으로 찾으실 수 있습니다.<br>
				핸드폰이나 이메일로 임시 비밀번호를 부여하고 있습니다.<br>
				임시비밀번호로 로그인 하신 후, 비밀번호를 변경하시면 됩니다.</p>
			</div>							
			
			<div class="pagination">
            <a href="#">〈</a>
            <a href="${contextPath}/service/faq.do" class="active">1</a>
            <a href="${contextPath}/service/faq2.do" class="active">2</a>
            <a href="#">〉</a>
        </div>
		</div>					
	</div>
</body>
</html>
