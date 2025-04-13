<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!-- 개별 상품 주문 금액(상품 * 수량) -->
<c:set var="order_price" value="0" />

<!-- 사용 포인트 -->
<c:set var="use_point" value="0" />

<!-- 기타 할인 금액 -->
<c:set var="other_discount_price" value="0" />

<!-- 총주문 금액 -배송비 제외 -->
<c:set var="total_order_price" value="0" />

<!-- 총할인금액 -->
<c:set var="total_discount_price" value="0" />

<!-- 총 배송비 -->
<c:set var="delivery_price" value="3000" />

<!-- 최종 결제 금액 -->
<c:set var="final_total_order_price" value="0" />
<head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function execDaumPostcode() {
    // Daum 주소 검색 API 객체 생성
    new daum.Postcode({
        oncomplete: function(data) {
            // 주소 선택 후 실행될 로직
            
            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가
            if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가
            if (data.buildingName !== '' && data.apartment === 'Y') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우 괄호 추가
            if (extraRoadAddr !== '') {
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명 주소와 추가 주소 조합
            if (fullRoadAddr !== '') {
                fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 입력 필드에 삽입
            document.getElementById('addr1').value = data.zonecode; // 5자리 새 우편번호
            document.getElementById('addr2').value = fullRoadAddr;

            // 예상 주소 안내 표시
            if (data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
            } 
            else {
                document.getElementById('guide').innerHTML = '';
            }
        }
    }).open();
}

      
function reset_all() {
	var r_receiver_name = document.getElementById("receiver");
	var r_zipcode = document.getElementById("addr1");
	var r_road_address = document.getElementById("addr2");
	var r_namuji_address = document.getElementById("addr3");
	var r_phone_num = document.getElementById("phone_num");
	
	r_receiver_name.value = "";
	r_zipcode.value = "";
	r_road_address.value = "";
	r_namuji_address.value = "";
	r_phone_num.value = "";
}

function restore_all() {
	var r_receiver_name = document.getElementById("receiver");
	var r_zipcode = document.getElementById("addr1");
	var r_road_address = document.getElementById("addr2");
	var r_namuji_address = document.getElementById("addr3");
	var r_phone_num = document.getElementById("phone_num");
	
	var h_receiver_name = document.getElementById("h_receiver");
	var h_zipcode = document.getElementById("h_addr1");
	var h_road_address = document.getElementById("h_addr2");
	var h_namuji_address = document.getElementById("h_addr3");
	var h_phone_num = document.getElementById("h_phone_num");

	r_receiver_name.value = h_receiver_name.value;
	r_zipcode.value = h_zipcode.value;
	r_road_address.value = h_road_address.value;
	r_namuji_address.value = h_namuji_address.value;
	r_phone_num.value = h_phone_num.value;
}

var payment_method;
function getValue(element) {
	payment_method = element.value;
}


function fn_process_pay_order() {
    var desired_delivery_date = document.getElementById("desired_delivery_date").value;

    if (!desired_delivery_date) { // 날짜가 입력되지 않았을 경우
        alert("배송희망일을 선택해주세요!"); 
    	return;
    }
    
    var formObj = document.createElement("form");
    formObj.method = "post";
    formObj.action = "${contextPath}/order/payToOrderProduct.do";
    
    document.body.appendChild(formObj);
    
	var receiver_name = document.getElementById("receiver").value;
 	var zipcode = document.getElementById("addr1").value;
	var road_address = document.getElementById("addr2").value;
	var namuji_address = document.getElementById("addr3").value;
	var phone_num = document.getElementById("phone_num").value;
	var payment = payment_method;
	var desired_delivery_date = document.getElementById("desired_delivery_date").value;
	var delivery_method = document.getElementById("delivery_method").value;
	var delivery_request = document.getElementById("delivery_request").value;
 	var order_price = document.getElementById("h_order_price").value;
	var delivery_price = document.getElementById("delivery_price").innerText.replace(/\D/g, "");
	var t_order_price = document.getElementById("total_order_price").innerText.replace(/\D/g, "");
 	var cash_point = Math.round(t_order_price * 0.01); 
	var use_point = document.getElementById("use_point").value;
	var other_discount_price = Math.round(document.getElementById("other_discount_price").value);
	var t_discount_price = document.getElementById("t_discount_price").innerText.replace(/\D/g, "");
	var f_t_order_price = document.getElementById("f_t_order_price").innerText.replace(/\D/g, "");
	
 	var i_receiver_name = createHiddenInput("receiver_name", receiver_name);
 	var i_zipcode = createHiddenInput('zipcode', zipcode);
	var i_road_address = createHiddenInput('road_address', road_address);
	var i_namuji_address = createHiddenInput('namuji_address', namuji_address);
	var i_phone_num = createHiddenInput('phone_num', phone_num);
	var i_payment = createHiddenInput('payment', payment);
	var i_desired_delivery_date = createHiddenInput('desired_delivery_date', desired_delivery_date);
	var i_delivery_method = createHiddenInput('delivery_method', delivery_method);
	var i_delivery_request = createHiddenInput('delivery_request', delivery_request);
	var i_order_price = createHiddenInput('order_price', order_price);
	var i_delivery_price = createHiddenInput('delivery_price', delivery_price);
	var i_t_order_price = createHiddenInput('t_order_price', t_order_price);
	var i_cash_point = createHiddenInput('cash_point', cash_point);
	var i_use_point = createHiddenInput('use_point', use_point);
	var i_other_discount_price = createHiddenInput('other_discount_price', other_discount_price);
	var i_t_discount_price = createHiddenInput('t_discount_price', t_discount_price);
	var i_f_t_order_price = createHiddenInput('f_t_order_price', f_t_order_price);

 	formObj.appendChild(i_receiver_name);
    formObj.appendChild(i_zipcode);
    formObj.appendChild(i_road_address);
    formObj.appendChild(i_namuji_address);
    formObj.appendChild(i_phone_num);
    formObj.appendChild(i_payment);
    formObj.appendChild(i_desired_delivery_date);
    formObj.appendChild(i_delivery_method);
    formObj.appendChild(i_delivery_request);
    formObj.appendChild(i_order_price);
    formObj.appendChild(i_delivery_price);
    formObj.appendChild(i_t_order_price);
    formObj.appendChild(i_cash_point);
    formObj.appendChild(i_use_point);
    formObj.appendChild(i_other_discount_price);
    formObj.appendChild(i_t_discount_price);
    formObj.appendChild(i_f_t_order_price);

    
    alert("결제가 완료되었습니다.");
    
    formObj.submit(); 
}

function createHiddenInput(name, value) {
    var input = document.createElement("input");
    input.type = "hidden";
    input.name = name;
    input.value = value;
    return input;
}
</script>
</head>
<body>
   <style>
	h1 {
	  margin-left: 20px;
	}
	/* ------------------주문자---------------- */
    .orderer {
      margin-top: 30px;
    }
    .orderer h2 {
      font-weight: lighter; 
    }
	.orderer table {
      width: 80%;
      border-collapse: collapse;
      margin: 20px 0;
      font-size: 18px;
      text-align: left;
     }
     .orderer th, td {
	   border-top: 1px solid black;
	   border-bottom: 1px solid #ddd;
	   padding: 10px;
     }
     .orderer th {
       font-weight: bold;
     }
     /* --------------배송지 정보------------------- */
     
    .delivery_inform {
      margin-top: 30px;
    }
    .delivery_inform_1 {
      display: flex;
      justify-content: space-between;
      border-bottom: 1px solid black;
    }
    .delivery_inform_1 button {
      border-radius: 8px; /* 테두리를 둥글게 */
      width: 10%;
      height: 1%;
      margin-top:50px;
    }
    .delivery_inform h2 {
      font-weight: lighter;
      padding-bottom: 15px;
      width: 100%;
    }
	.delivery_inform .delivery_inform_2 {
	  margin-top: 20px;
      width: 100%;
      display: flex;
      flex-direction: column; /* 세로 배치 */
      gap: 20px; /* 그룹 간의 간격 */
     } 
    .delivery_inform {
        width: 80%;   
    }
    .inf {
    display: flex;
    flex-direction: row; /* 라벨과 첫 번째 input 요소 가로 배치 */
    align-items: flex-start; /* 라벨과 첫 번째 input 상단 정렬 */
    gap: 10px; /* 라벨과 input 간의 간격 */
    margin-bottom: 15px;
    }
    .inf label {
    font-weight: bold;
    min-width: 100px; /* 라벨의 최소 너비 */
    text-align: left; /* 라벨 텍스트 좌측 정렬 */
    margin-top: 10px; /* 라벨 상단 간격 */
	}
	.addr {
    display: flex;
    flex-direction: column; /* 두 번째 input 요소를 세로로 배치 */
    gap: 10px; /* 필드 간 간격 */
    flex: 1; /* 주소 입력 필드 너비 균등 분배 */
	    
	}
	.inf input[type="text"], [type="date"]  {
    width: 100%; /* 입력 필드 너비를 100%로 설정 */
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 8px; /* 테두리를 둥글게 */
    box-sizing: border-box;
    flex: 1; /* 입력 필드가 남은 공간을 차지 */
    font-size: 14px;
	}
	.inf span{
	font-size: 13px;
	} 
	/* ----------------배송지 요청사항--------------------- */
	 .delivery_request {
      margin-top: 30px;
    }
    .delivery_request h2 {
      font-weight: lighter;
      border-bottom: 1px solid black;
      padding-bottom: 15px;
      width: 80%;
    }
    .delivery_request label {
     font-weight: bold;
     min-width: 100px; /* 라벨의 최소 너비 */
     text-align: left; /* 라벨 텍스트 좌측 정렬 */
     margin-top: 10px; /* 라벨 상단 간격 */
	}  
   .dr {
     display: flex;
     flex-direction: row; /* 라벨과 첫 번째 input 요소 가로 배치 */
     border-bottom: 1px solid #ddd;
     padding: 0 0 20px;
     width: 80%;
     gap: 1px; /* 라벨과 input 간의 간격 */
    }   
   
   .dr input[type="text"] {
    border: 1px solid #ccc;
    border-radius: 8px; /* 테두리를 둥글게 */  
    width: 87%;  
    padding: 10px;              
    margin-left: 5px;       
    }   
    /* ------------------주문상품 정보-------------------------- */ 
   .order_inform {
      margin-top: 30px;
      gap: 10px; /* 요소 간 간격 조정 */
    }
   .order_inform h2 {
      font-weight: lighter;
      border-bottom: 1px solid black;
      padding-bottom: 15px;
      width: 80%;
    }   
   .order_product {
      width: 80%;
      margin-top: 30px;
      display: flex; /* Flexbox 사용 */
      gap: 10px; /* 요소 간 간격 조정 */
      justify-content:space-between;
    } 
   .inform1 {
      display: flex; /* Flexbox 사용 */
      gap: 10px; /* 요소 간 간격 조정 */
    }
   .inform1-2 {
      display: flex; /* Flexbox 사용 */
      flex-direction: column; /* 세로 배치 */
      text-align: left;
    }      
    .inform2 {
      display: flex; /* Flexbox 사용 */
      flex-direction: column; /* 세로 배치 */
      text-align: right;
    }   
    /* -----------------포인트 사용----------------------- */
   .cash_point {
      margin-top: 30px;
      gap: 10px; /* 요소 간 간격 조정 */
    }
   .cash_point h2 {
      font-weight: lighter;
      border-bottom: 1px solid black;
      padding-bottom: 15px;
      width: 80%;
    }    
	.point {
	    border-bottom: 1px solid #ddd;
	    padding: 0 0 20px;
	    width: 80%;
	    display: flex; 
	    align-items: center;
	    gap: 10px;
	}
	
	.label-wrapper {
	    display: flex;
	    align-items: center;
	    gap: 10px; 
	    white-space: nowrap;
	    flex-shrink: 0;
	}
	
	.point input {
	    flex: 1;
	    padding: 10px;
	    border: 1px solid #ccc;
	    border-radius: 8px;
	    box-sizing: border-box;
	    font-size: 14px;
	    height: 40px;
	}
	
	#o_cash_point {
	    font-size: 13px;
	    color: #555;
	    white-space: nowrap;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    max-width: 150px;
	    display: inline-block;
	}    
    /* -----------------결제 방법----------------------- */	
.payment-option {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px; /* 이미지와 텍스트 간 간격 */
	width: 100px;
	height: 50px;
	padding: 10px;
	border: 2px solid #d0d0d0;
	border-radius: 10px;
	text-align: center;
	cursor: pointer;
	transition: border-color 0.3s ease, box-shadow 0.3s ease;
	background-color: white;
}

.payment-option img {
	width: 60px;
	height: 60px;
	object-fit: contain;
}

.payment-option span {
	font-size: 13px;
	font-weight: bold;
	color: #333;
}

.payment-option:hover {
	border-color: #ff7a00;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

input[type="radio"] {
	display: none;
}

input[type="radio"]:checked+.payment-option {
	border-color: #ff7a00;
	background-color: #fff5e6;
}

.type {
	display: flex;
	gap: 15px;
	justify-content: flex-start;
}
     /* -------------------------------------- */
      .order-summary {
        width: 76%;
        background-color: white;
        border: 1px solid #e0e0e0;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-top: 30px;
        }

       .order-summary h2 {
         font-size: 18px;
         font-weight: bold;
         margin-bottom: 20px;
       }

       .order-summary .item {
           display: flex;
           justify-content: space-between;
           margin-bottom: 10px;
           font-size: 14px;
       }
       
       .order-summary .item span:last-child {
           font-weight: bold;
       }

       .order-summary .total {
           display: flex;
           justify-content: space-between;
           font-size: 18px;
           font-weight: bold;
           margin: 20px 0;
           color: #ff6b00;
       }
       .order-summary button {
           width: 100%;
           padding: 12px;
           font-size: 16px;
           font-weight: bold;
           color: white;
           background-color: #ff6b00;
           border: none;
           border-radius: 8px;
           cursor: pointer;
           transition: background-color 0.3s ease;
       }

       .order-summary button:hover {
           background-color: #e65a00;
       }
       
    </style>
</head>
<body>
	&nbsp&nbsp<H1>주문/결제하기</H1>
	<div class="orderer">	
	  <h2>주문자</h2>
	   <table>
	    <tr>
	     <th>${orderer.user_id}</th>
	     <td>${orderer.phone_num}</td>
	     <td>${orderer.email1 }@${orderer.email2}</td>
	    </tr>
	   </table>
	</div>
	<div class="delivery_inform">
	 <div class="delivery_inform_1">
	  <h2>배송지 정보</h2>
	  <button id="btn1" onclick="reset_all()" style="padding: 2px 4px; font-size: 10px;">새 배송지</button>&nbsp&nbsp
	  <button id="btn2" onclick="restore_all()" style="padding: 2px 4px; font-size: 10px;">원래 배송지</button>
	 </div>
	 <div class="delivery_inform_2">
	  <div class="inf">
        <label for="receiver">받는 분</label>
        <input type="text" id="receiver" name="receiver_name" placeholder="받는 분" value="${orderer.username }" required>
        <input type="hidden" id="h_receiver" name="receiver_name" placeholder="받는 분" value="${orderer.username }" >
      </div>
      <div class="inf">
        <label for="addr">주소</label><button onclick="execDaumPostcode()">우편번호 찾기</button>
        <div class="addr">
         <input type="text" id="addr1" name="zipcode" placeholder="우편주소" value="${orderer.zipcode }" readonly required>
         <input type="text" id="addr2" name="road_address" placeholder="도로명주소" value="${orderer.roadAddress }" readonly required>
         <input type="text" id="addr3" name="namuji_address" placeholder="상세주소" value="${orderer.namujiAddress }" required>
         <input type="hidden" id="h_addr1" name="zipcode" placeholder="우편주소" value="${orderer.zipcode }">
         <input type="hidden" id="h_addr2" name="road_address" placeholder="도로명주소" value="${orderer.roadAddress }">
         <input type="hidden" id="h_addr3" name="namuji_address" placeholder="상세주소" value="${orderer.namujiAddress }" >
        </div>
      </div>
      <div class="inf">
        <label for="phone_num">휴대폰</label>
        <input type="text" id="phone_num" name="phone_num" value="${orderer.phone_num }"required>
        <input type="hidden" id="h_phone_num" name="phone_num" value="${orderer.phone_num }">
      </div>
      <div class="inf">
        <label for="delivery_method ">배송방법</label>
        <input type="radio" id="delivery_method" name="delivery_method" value="택배배송" checked>
        <span>택배배송</span>
      </div>
      <div class="inf">
        <label for="receiver">배송희망일</label>
        <input type="date" id="desired_delivery_date" name="desired_delivery_date"  required>
      </div>
	 </div>
	</div>
	<div class="delivery_request">	
	  <h2>배송요청사항</h2>
	  <div class="dr">
	   <label for="delivery_request">요청사항</label>
	   <input type="text" id="delivery_request" name="delivery_request" placeholder="배송요청 사항을 입력하세요." required>
	  </div>
	 </div>
	<div class="order_inform">	
	  <h2>주문상품</h2>
      <c:forEach var="myOrder" items="${myOrderList}">
        <c:set var="order_price" value="${myOrder.product_price * myOrder.quantity}" />
	    <c:set var="total_order_price" value="${total_order_price + order_price}" />
		  <div class="order_product">
		   <div class="inform1">
		    <img>
		    <div class="inform1-1">
		     <img class="product-image" width="75" alt=""
	          src="${contextPath}/thumbnails.do?product_id=${myOrder.product_id}&imageName=${myOrder.product_image}">
			 <input type="hidden" id="h_product_id" name="h_product_id" value="${myOrder.product_id}" />
		     <input type="hidden" id="h_product_image" name="h_product_image" value="${myOrder.product_image}" />
		    </div>
		    <div class="inform1-2">
		     <div class="product-name">${myOrder.product_name}</div>
		     <div class="product-price"><fmt:formatNumber value="${myOrder.product_price}" pattern="#,###" />원</div>
		     <input type="hidden" id="h_product_name" name="h_product_name" value="${myOrder.product_name}" />
		     <input type="hidden" id="h_product_price" name="h_product_price" value="${myOrder.product_price}" />
		    </div>
		   </div>
		   <div class="inform2">
			 <div class ="quantity">${myOrder.quantity}개</div>
		     <div id ="order_price" class="order_price"><fmt:formatNumber value="${order_price}" pattern="#,###" />원</div>
		     <input type="hidden" id="h_quantity" name="h_quantity" value="${myOrder.quantity}" />
		     <input type="hidden" id="h_order_price" name="h_order_price" value="${order_price}" />
		   </div>
		  </div>
      </c:forEach>  
      	  <c:set var="other_discount_price" value="${total_order_price * 0}" />
		  <input type="hidden" id="other_discount_price" name="other_discount_price" value="${other_discount_price}" />
	</div> 
	<div class="cash_point">	
	  <h2>포인트 사용</h2>
	  <div class="point">
        <label for="cash_point">포인트 사용 <span id="o_cash_point">${orderer.cash_point}P</span></label>
        <input type="text" id="cash_point" name="cash_point"  placeholder="입력           P">
      </div>
	</div> 
	<div class="pay_type">
		<h2>결제방법</h2>
		<div class="type">
			<!-- 신용카드 -->
			<input type="radio" id="type1" name="payment_method" value="신용카드"
				onclick="getValue(this)"> <label for="type1"
				class="payment-option"> <span>신용카드</span>
			</label>

			<!-- 실시간 계좌이체 -->
			<input type="radio" id="type2" name="payment_method" value="실시간계좌이체"
				onclick="getValue(this)"> <label for="type2"
				class="payment-option"> <span>실시간 계좌이체</span>
			</label>

			<!-- 카카오페이 -->
			<input type="radio" id="kakao" name="payment_method" value="KakaoPay"
				onclick="getValue(this)"> <label for="kakao"
				class="payment-option"> <img
				src="${contextPath}/resources/image/kakao_pay.png" alt="카카오페이">
			</label>

			<!-- 네이버페이 -->
			<input type="radio" id="naver" name="payment_method" value="NaverPay"
				onclick="getValue(this)"> <label for="naver"
				class="payment-option"> <img
				src="${contextPath}/resources/image/naver_pay.png" alt="네이버페이">
			</label>

			<!-- 토스페이 -->
			<input type="radio" id="toss" name="payment_method" value="TossPay"
				onclick="getValue(this)"> <label for="toss"
				class="payment-option"> <img
				src="${contextPath}/resources/image/toss_pay.png" alt="토스페이">
			</label>
		</div>
	</div>
   <div class="order-summary">
        <h2>주문결제 금액</h2>
        <div class="item">
            <span>상품금액</span>
            <span id="total_order_price"><fmt:formatNumber value="${total_order_price }" pattern="#,###" />원</span>
        </div>
        <div class="item">
        	<input type="hidden" id="use_point" name="use_point" value="${use_point }" >
            <c:set var="total_discount_price" value="${use_point + other_discount_price}" />
            <span>할인금액</span>
            <span id="t_discount_price">
            <fmt:formatNumber value="${total_discount_price}" type="number" maxFractionDigits="0"/>원</span>
            
        </div>
        <c:choose>
		    <c:when test="${total_order_price >= 40000}">
		        <c:set var="delivery_price" value="${delivery_price - 3000}" />
		    </c:when>
		    <c:otherwise>
		        <c:set var="delivery_price" value="${delivery_price}" />
		    </c:otherwise>
		</c:choose>
        <div class="item">
            <span>배송비</span>
            <span id="delivery_price"><fmt:formatNumber value="${delivery_price}" pattern="#,###" />원</span>
        </div>
        <div class="total">
            <span>총 결제금액</span>
            <c:set var="final_total_order_price" value="${total_order_price + delivery_price - total_discount_price}" />
            <span id=f_t_order_price><fmt:formatNumber value="${final_total_order_price}" pattern="#,###" />원</span>
    </div>
        <button onclick="fn_process_pay_order()">결제하기</button>
   <script>
	   document.getElementById("cash_point").addEventListener("input", function(event) {
		   var o_cash_point = document.getElementById("o_cash_point"); // 고객의 보유 포인트
		   var total_order_price = parseInt("${total_order_price}") || 0; // 배송비를 제외한 총 주문 금액
		   var delivery_price = parseInt("${delivery_price}") || 0; // 배송비
		   var sum_t_order_de_price = total_order_price + delivery_price; // 배송비를 포함한 총 주문 금액
		   var other_discount_price = parseInt("${other_discount_price}") || 0; // 포인트 사용외 상품 할인 금액
		   var total_discount_price; // 총 할인 금액
		   /* var total_price; */

		   var i_cash_point = parseInt(event.target.value) || 0; // 고객이 입력한 포인트
		   var use_point = i_cash_point;// 고객이 실질적 사용할 포인트
		   
 		   /* var discount_value = parseInt(event.target.value) || 0; */
		   var o_cash_value = parseInt(o_cash_point.innerText) || 0;
		   /* var product_price_value = parseInt(product_price) || 0; */
		   /* var delivery_price_value = parseInt(delivery_price) || 0; */
		   /* total_price = product_price_value + delivery_price_value; */
		   
		   if (o_cash_value <= i_cash_point) {
			   use_point = o_cash_value;
		   }
		   
		   total_discount_price = use_point + other_discount_price;
		   if(use_point >= (sum_t_order_de_price - other_discount_price)) {
			   use_point = (sum_t_order_de_price - other_discount_price);
			   total_discount_price = use_point + other_discount_price;
		   }
		   var final_total_order_price = sum_t_order_de_price - total_discount_price; //최종 결제 금액 	

		   
		   document.getElementById("t_discount_price").innerText = total_discount_price.toLocaleString('ko-KR') + '원';
		   document.getElementById("use_point").value = use_point;
		   document.getElementById("delivery_price").innerText = delivery_price.toLocaleString('ko-KR') + '원';
		   document.getElementById("f_t_order_price").innerText = final_total_order_price.toLocaleString('ko-KR') + '원';
	   });
	  
   </script>
</body>
	

			