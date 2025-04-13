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

			<div class="faq-header">
				<h2>자주묻는 질문</h2>
			</div>

			<div class="faq-subject">
				<span class="category">상품관련</span>
				<p class="text">주문을 취소하고싶어요!. 배송 희망일을 변경하고싶어요!.</p>
				<span class="date">2025-02-04</span> <span class="toggle-icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">
					배송일이 지정되는 주문제작 신선식품으로 고객님께서 직접 취소나 변경 처리가 어렵습니다. <br> 배송지정일 전일
					08시 이전까지 1:1문의 게시판 요청하시면 영업시간 내에 <br>담당자가 취소와 변경 처리 해 드립니다.
				</p>
			</div>

			<div class="faq-subject">
				<span class="category">상품관련</span>
				<p class="text">상품 수령후, 바로 사용 가능한가요?</p>
				<span class="date">2025-02-03</span><span class="toggle-icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">제품별로 냉장 또는 냉동 보관하시고 소비기간내에 취식을 권장드립니다.</p>
			</div>

			<div class="faq-subject">
				<span class="category">배송관련</span>
				<p class="text">배송 방법은 어떻게 되나요?</p>
				<span class="date">2025-02-02</span><span class="toggle=icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">
					롯데택배로 발송되며, 택배배송은 발송 후, 다음날 도착을 원칙으로 합니다.<br>
					손님초대일 당일에 택배 도착 설정은 권장하지 않으며,<br>
					가급적 전날 수령 후, 냉장 보관하신 후, 다음날 음식을 사용하기를 권장합니다.
				</p>
			</div>

			<div class="faq-subject">
				<span class="category">배송관련</span>
				<p class="text">토요일 택배 수령이 가능한가요?</p>
				<span class="date">2025-02-01</span><span class="toggle=icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">
					화요일부터 토요일까지 수령이 가능합니다.<br>
					(주중 공휴일이 있을 경우, 공휴일과 공휴일다음날에는 일반택배 수령 불가)
				</p>
			</div>

			<div class="faq-subject">
				<span class="category">배송관련</span>
				<p class="text">택배 배송사고 발생시 어떻게 되나요?</p>
				<span class="date">2025-01-31</span><span class="toggle=icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">배송사고가 발생한 경우에는 주문하신 내용에 대해 100% 환불/보상해 드립니다.<br>
				먼저, 택배의 배송사고라 함은 요청일 내 24시 이전까지<br>
				상품이 도착하지 않는 것을 의미합니다.</p>
			</div>
			
			<div class="faq-subject">
				<span class="category">배송관련</span>
				<p class="text">주문하면 당일 수령이 가능한가요?</p>
				<span class="date">2025-01-30</span><span class="toggle=icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">CookIt은 고객님들께 신선한 제품을 최상의 상태로 배송해 드리고 있습니다.<br>
				주문접수 후 제조한 신선한 제품을 배송해 드리기 위해<br>
				부득이하게 하루 이상의 준비기간이 필요합니다.<br><br>
				주문하신 당일 수령은 어려우며, 오전 8시까지 주문/결제완료시 익일 수령 가능합니다.<br>
				단, 상품페이지 내 주문 마감시간에 따라 배송일 지정이 가능합니다.</p>
			</div>
				
			<div class="faq-subject">
				<span class="category">배송관련</span>
				<p class="text">배송 주소를 잘못 기재했는데 변경할 수 있나요?</p>
				<span class="date">2025-01-29</span><span class="toggle=icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">출고당일 08시 이전까지는 주소변경이 가능하나,<br>
					주문서 수집 후 생산이 진행되면 주소 변경이 불가합니다.<br>
					주소변경 요청은 CookIt 고객센터로 접수 부탁드립니다.</p>
			</div>	
				
			<div class="faq-subject">
				<span class="category">배송관련</span>
				<p class="text">배송은 몇시에 도착하나요?</p>
				<span class="date">2025-01-28</span><span class="toggle=icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">택배 배송(롯데택배) 고객님이 지정한 배송지정일 당일 오전부터 오후까지<br>
					택배사 운영시간 사이에 배송되며, 택배기사의 배달 동선에 따라 배송 도착시간이 상이합니다.<br><br>
					* 모든 배송은 시간지정이 불가하며, 주문 및 교통량에 따라 안내드린 시간보다<br>
					지연 혹은 조기배송 될 수 있습니다.</p>
			</div>	
					
			<div class="faq-subject">
				<span class="category">배송관련</span>
				<p class="text">제주/도서산간 지역도 배송되나요?</p>
				<span class="date">2025-01-27</span><span class="toggle=icon">▼</span>
			</div>
			<div class="answer">
				<p class="txt">제주, 도서산간지역은 배송 지연 및 상품 훼손의 우려가 있어 배송을 제한하고 있습니다.<br>
					고객님들의 양해 부탁 드립니다.</p>
			</div>
			
			
			<div class="pagination">
            <a href="${contextPath}/service/faq.do">〈</a>
            <a href="${contextPath}/service/faq.do" class="active">1</a>
            <a href="${contextPath}/service/faq2.do" class="active">2</a>
            <a href="${contextPath}/service/faq2.do">〉</a>
        </div>
		</div>					
	</div>
</body>
</html>
