<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="myCartList" value="${cartMap.myCartList}" />
<c:set var="myProductList" value="${cartMap.myProductList}" />
<c:set var="totalProductNum" value="0" />
<!--주문 개수 -->
<c:set var="totalDeliveryPrice" value="3000" />
<!-- 총 배송비 -->
<c:set var="totalDiscountedPrice" value="0" />
<!-- 총 할인금액 -->
<title>장바구니</title>

<link rel="stylesheet" type="text/css"
	href="${contextPath}/resources/css/main.css">
<link rel="stylesheet" type="text/css"
	href="${contextPath}/resources/css/myCartList.css">
<head>
<script type="text/javascript">

document.addEventListener("DOMContentLoaded", function () {
    const checkboxes = document.querySelectorAll("input[name='checked_product']");

    function calcProductPrice() {
        let totalProductNum = 0;
        let totalProductPrice = 0;
        let totalDeliveryPrice = 3000;
        let totalDiscountedPrice = 0;

        checkboxes.forEach((checkbox) => {
            if (checkbox.checked) {
                let row = checkbox.closest("tr");
                let amountSpan = row.querySelector("[id^='amount_']"); // 수량이 들어 있는 span
                let price = parseInt(row.querySelector(".price span").innerText.replace(/[^0-9]/g, ""), 10);

                if (!amountSpan) {
                    console.error("❌ 'amount' span을 찾을 수 없습니다.", row);
                    return;
                }

                let amount = parseInt(amountSpan.innerText, 10); // span 내부 값 가져오기
                
                totalProductNum += amount;
                totalProductPrice += amount * price;
            }
        });

        if (totalProductPrice >= 40000) {
            totalDeliveryPrice = 0;
        }

        let finalTotalPrice = totalProductPrice + totalDeliveryPrice - totalDiscountedPrice;

        document.getElementById("h_totalProductNum").value = totalProductNum;
        document.getElementById("h_totalProductPrice").value = totalProductPrice;
        document.getElementById("h_totalDeliveryPrice").value = totalDeliveryPrice;
        document.getElementById("h_totalSalesPrice").value = totalDiscountedPrice;
        document.getElementById("h_final_totalPrice").value = finalTotalPrice;

        document.getElementById("p_totalProductNum").innerText = totalProductNum + "개";
        document.getElementById("p_totalProductPrice").innerText = totalProductPrice.toLocaleString() + "원";
        document.getElementById("p_totalDeliveryPrice").innerText = totalDeliveryPrice.toLocaleString() + "원";
        document.getElementById("p_final_totalPrice").innerText = finalTotalPrice.toLocaleString() + "원";
    }

    // 체크박스 변경 시 총 가격 업데이트
    checkboxes.forEach((checkbox) => {
        checkbox.addEventListener("change", calcProductPrice);
    });

    // 초기 계산 (페이지 로드 시 체크된 상품만 계산)
    calcProductPrice();
});


function updateCartQty(product_id, index, change) {
    var amountSpan = document.getElementById("amount_" + index);
    var amountInput = document.querySelector("input[name='amount'][data-index='" + index + "']");
    var totalSalesPriceSpan = document.getElementById("total_sales_price_" + index);

    if (!amountSpan || !totalSalesPriceSpan || !amountInput) {
        console.error("ID가 'amount_" + index + "' 또는 'total_sales_price_" + index + "' 또는 'input[name=amount]' 요소를 찾을 수 없습니다.");
        return;
    }

    var currentAmount = parseInt(amountSpan.innerText, 10);
    if (isNaN(currentAmount)) {
        alert("수량이 잘못된 값입니다.");
        return;
    }

    var newAmount = currentAmount + change;
    if (newAmount < 1) {
        alert("수량은 1개 이상이어야 합니다.");
        return;
    }

    var pricePerUnit = parseInt(totalSalesPriceSpan.innerText.replace(/[^0-9]/g, ''), 10) / currentAmount;

    // 📌 화면 업데이트 (span + hidden input 동기화)
    amountSpan.innerText = newAmount;
    amountInput.value = newAmount;  // ✅ hidden input 업데이트
    var newTotalPrice = pricePerUnit * newAmount;
    totalSalesPriceSpan.innerText = newTotalPrice.toLocaleString() + "원"; // 개별 상품 총액 업데이트

    // 📌 총 상품 금액 및 수량 업데이트
    var totalProductNum = Number(document.getElementById("h_totalProductNum").value);
    var totalProductPrice = Number(document.getElementById("h_totalProductPrice").value);

    totalProductNum += change;
    totalProductPrice += pricePerUnit * change;

    document.getElementById("h_totalProductNum").value = totalProductNum;
    document.getElementById("h_totalProductPrice").value = totalProductPrice;
    document.getElementById("p_totalProductNum").innerText = totalProductNum + "개";
    document.getElementById("p_totalProductPrice").innerText = totalProductPrice.toLocaleString() + "원";

    // 📌 40,000원 이상이면 배송비 무료 처리
    var deliveryPrice = totalProductPrice >= 40000 ? 0 : 3000;
    document.getElementById("p_totalDeliveryPrice").innerText = deliveryPrice.toLocaleString() + "원";
    document.getElementById("h_totalDeliveryPrice").value = deliveryPrice;

    // 📌 무료 배송까지 남은 금액 표시
    var freeShippingNotice = document.getElementById("freeShippingNotice");
    if (freeShippingNotice) {
        var remainingAmount = totalProductPrice >= 40000 ? 0 : (40000 - totalProductPrice);
        if (remainingAmount > 0) {
            freeShippingNotice.innerText = "무료 배송까지 " + remainingAmount.toLocaleString() + "원 추가 구매하세요!";
            freeShippingNotice.style.color = "red";
        } else {
            freeShippingNotice.innerText = "🎉 무료 배송 적용!";
            freeShippingNotice.style.color = "green";
        }
    }

    // 📌 최종 결제 금액 업데이트
    var discountPrice = Number(document.getElementById("h_totalSalesPrice").value);
    var finalTotalPrice = totalProductPrice + deliveryPrice - discountPrice;

    document.getElementById("p_final_totalPrice").innerText = finalTotalPrice.toLocaleString() + "원";
    document.getElementById("h_final_totalPrice").value = finalTotalPrice;

    // 📌 서버에 변경된 수량 반영 (AJAX 요청)
    $.ajax({
        type: "post",
        async: true,
        url: "${contextPath}/cart/modifyCartQty.do",
        data: {
            product_id: product_id,
            amount: newAmount
        },
        dataType: "text",
        success: function (response) {
            console.log("AJAX 응답 데이터:", response);

            // JSON 형식의 문자열을 JavaScript 객체로 변환
            var data = JSON.parse(response);

            if (data.status !== 'modify_success') {
                alert("수량 변경 실패! 다시 시도해 주세요.");
                amountSpan.innerText = currentAmount;
                amountInput.value = currentAmount;  // ✅ AJAX 실패 시 hidden input 값도 복원
                totalSalesPriceSpan.innerText = (pricePerUnit * currentAmount).toLocaleString() + "원";
            }
        },
        error: function (xhr, status, error) {
            console.error("AJAX 요청 오류:", status, error);
            alert("서버와의 통신 중 오류가 발생했습니다.");
            amountSpan.innerText = currentAmount;
            amountInput.value = currentAmount;  // ✅ AJAX 실패 시 hidden input 값도 복원
            totalSalesPriceSpan.innerText = (pricePerUnit * currentAmount).toLocaleString() + "원";
        }
    });
}


function delete_cart_product(cart_id){
	var cart_id=Number(cart_id);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_id";
	i_cart.value=cart_id;
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/cart/removeCartProduct.do";
    formObj.submit();
}

document.addEventListener("DOMContentLoaded", function () {
    const selectAllCheckbox = document.getElementById("check-1"); // "전체선택" 체크박스
    const itemCheckboxes = document.querySelectorAll("input[name='checked_product']"); // 개별 상품 체크박스

    // 전체 선택 체크박스 변경 시 개별 체크박스 상태 업데이트
    selectAllCheckbox.addEventListener("change", function () {
        itemCheckboxes.forEach((checkbox) => {
            checkbox.checked = selectAllCheckbox.checked; // 전체 선택 상태에 따라 개별 체크박스 변경
        });

        calcProductPrice(); // 체크 상태 변경 후 가격 다시 계산
    });

    // 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
    itemCheckboxes.forEach((checkbox) => {
        checkbox.addEventListener("change", function () {
            const allChecked = [...itemCheckboxes].every((box) => box.checked); // 모든 체크박스 체크 여부 확인
            selectAllCheckbox.checked = allChecked; // 모든 체크박스가 선택되면 "전체 선택" 체크

            calcProductPrice(); // 개별 선택 변경 시 가격 다시 계산
        });
    });

    // 초기 계산 (페이지 로드 시 체크된 상품만 계산)
    calcProductPrice();
});

function fn_order_each_product(product_id,product_name,price,product_image){
	var total_price,final_total_price,_product_qty;
	var amount=document.getElementById("amount");
	
	_order_product_qty=amount.value; //장바구니에 담긴 개수 만큼 주문한다.
	var formObj=document.createElement("form");
	var i_product_id = document.createElement("input"); 
    var i_product_name = document.createElement("input");
    var i_product_price=document.createElement("input");
    var i_product_image=document.createElement("input");
    var i_order_product_qty=document.createElement("input");
    
    i_product_id.name="product_id";
    i_product_name.name="product_name";
    i_product_price.name="price";
    i_product_image.name="product_image";
    i_order_product_qty.name="order_product_qty";
    
    i_product_id.value=product_id;
    i_order_product_qty.value=_order_product_qty;
    i_product_name.value=product_name;
    i_product_price.value=price;
    i_product_image.value=product_image;
    
    formObj.appendChild(i_product_id);
    formObj.appendChild(i_product_name);
    formObj.appendChild(i_product_price);
    formObj.appendChild(i_product_image);
    formObj.appendChild(i_order_product_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="${contextPath}/order/orderEachProduct.do";
    formObj.submit();
}



</script>
<style type="text/css">
.list_view {
	width: 100%;
	border-collapse: collapse;
	margin: 20px 0;
}

.list_view td {
	padding: 15px;
	vertical-align: middle;
	text-align: center;
}

.product_image img {
	width: 80px;
	height: 80px;
	border-radius: 8px;
	object-fit: cover;
}

.product-name h2 {
	font-size: 18px;
	margin: 0;
}

.product-name a {
	text-decoration: none;
	color: #333;
}

.product-name a:hover {
	color: #ff6600;
	text-decoration: underline;
}

.price {
	font-weight: bold;
	color: #ff6600;
}

.quantity-control button {
	padding: 5px 10px;
	font-size: 14px;
	background-color: #ff6600;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.quantity-control button:hover {
	background-color: #e55b00;
}

.quantity-control span {
	margin: 0 10px;
	font-size: 16px;
}

/* 체크박스 기본 숨김 */
.custom-checkbox .checkbox {
	position: absolute;
	opacity: 0;
	z-index: -1;
}

/* 체크박스 라벨 스타일 (이미지 체크박스) */
.custom-checkbox input[type="checkbox"]+label {
	display: inline-block;
	position: relative;
	cursor: pointer;
	vertical-align: top;
	padding-left: 26px;
	min-height: 18px;
}

/* 체크박스 이미지 스타일 */
.custom-checkbox .checkbox+label:before {
	border-radius: 100%;
	background: #dfdada url(${contextPath}/resources/image/check-box.png);
	display: block;
	content: '';
	position: absolute;
	left: 0;
	top: 0;
	width: 22px; /* 체크박스 크기 조절 */
	height: 22px;
	text-align: center;
	box-sizing: border-box;
}

/* 체크되었을 때의 체크박스 이미지 */
.custom-checkbox .checkbox:checked+label:before {
	background: #FF6001 url(${contextPath}/resources/image/check-box.png)
		no-repeat center;
	border: 1px solid #FF6001;
	background-size: cover;
}

/* 장바구니 옵션 영역 스타일 */
.renewal-cart {
	display: flex;
	justify-content: space-between;
	padding-bottom: 20px;
	border-bottom: 1px solid #000;
}

/* 삭제 버튼 컨테이너 (간격 조정) */
.cart-delete {
	display: flex;
	gap: 20px; /* 버튼 간격 증가 */
}

/* 삭제 버튼 스타일 */
.btn-cart-delete {
	background: none; /* 배경 제거 */
	border: none; /* 테두리 제거 */
	padding: 0; /* 기본 패딩 제거 */
	font-size: 16px; /* 글씨 크기 조정 */
	color: #000; /* 글씨 색상 */
	cursor: pointer; /* 클릭 가능하도록 설정 */
}

/* 버튼 내부 텍스트 스타일 */
.btn-cart-delete span {
	display: inline-block;
	padding: 8px 12px; /* 텍스트 주변 여백 추가 */
}

.delete-btn {
	display: inline-block;
	padding: 8px 12px;
	background-color: #ff4d4d;
	color: white;
	font-size: 14px;
	border: none;
	border-radius: 4px;
	text-align: center;
	cursor: pointer;
	text-decoration: none;
	font-weight: bold;
}

.delete-btn:hover {
	background-color: #e60000;
}
</style>
</head>
<body>
	<h2>장바구니</h2>
	<div class="cart-option renewal-cart">
		<div class="custom-checkbox">
			<input type="checkbox" id="check-1" class="checkbox checkboxGroup"
				name="checkD00000100"> <label for="check-1"
				class="renewal-cart-label">전체선택</label>
		</div>
		<div class="cart-delete">
			<button type="button"
				class="btn-cart-delete deleteUserCartGroupAllList">
				<span>전체삭제</span>
			</button>
			<button type="button"
				class="btn-cart-delete deleteUserCartGroupSelectedList">
				<span>선택삭제</span>
			</button>
		</div>
	</div>
	<table class="list_view">
		<tbody align=center>
			<c:choose>
				<c:when test="${ empty myCartList }">
					<tr>
						<td colspan=7 class="fixed"><strong>장바구니에 상품이 없습니다.</strong>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<form name="frm_order_all_cart">
							<c:forEach var="item" items="${myProductList }" varStatus="cnt">
								<c:set var="amount" value="${myCartList[cnt.count-1].amount}" />
								<c:set var="cart_id" value="${myCartList[cnt.count-1].cart_id}" />
								<c:set var="totalProductNum" value="${totalProductNum+amount}" />
								<c:set var="totalProductPrice"
									value="${totalProductPrice + (item.price * amount)}" />

								<tr>
									<!-- 체크박스 -->
									<td>
										<div class="custom-checkbox">
											<input type="checkbox" id="checkbox-${item.product_id}"
												class="checkbox" name="checked_product" checked
												value="${item.product_id }"
												onclick="calcProductPrice(${item.price}, this)"> <label
												for="checkbox-${item.product_id}"></label>
										</div>
									</td>

									<!-- 상품 이미지 -->
									<td class="product_image"><a
										href="${contextPath}/product/detailProduct.do?product_id=${item.product_id}">
											<img
											src="${contextPath}/thumbnails.do?product_id=${item.product_id}&imageName=${item.product_image}"
											alt="${item.product_name}" />
									</a></td>

									<!-- 상품명 -->
									<td class="product-name">
										<h2>
											<a
												href="${contextPath}/product/detailProduct.do?product_id=${item.product_id}">
												${item.product_name} </a>
										</h2>
									</td>

									<!-- 가격 -->
									<td class="price"><span>${item.price}원</span></td>

									<!-- 수량 -->
									<td class="quantity-control">
										<button type="button"
											onclick="updateCartQty(${item.product_id}, ${cnt.count-1}, -1)">-</button>
										<span id="amount_${cnt.count-1}">${amount}</span> 
										<input type="hidden" id="amount_${cnt.count-1}" name="amount" data-index="${cnt.count-1}" value="${amount}">
										<button type="button"
											onclick="updateCartQty(${item.product_id}, ${cnt.count-1}, 1)">+</button>
									</td>

									<!-- 총 금액 -->
									<td><strong> <fmt:formatNumber
												value="${item.price * amount}" type="number"
												var="total_sales_price" /> <span
											id="total_sales_price_${cnt.count-1}">${total_sales_price}원</span>
									</strong></td>

									<!-- 삭제 버튼 -->
									<td>
										<button type="button" class="delete-btn"
											onclick="delete_cart_product('${cart_id}')">X</button>
									</td>
								</tr>
							</c:forEach>
		</tbody>
	</table>

	<div class="clear"></div>
	</c:otherwise>
	</c:choose>
	<br>
	<br>

	<table width=80% class="list_view">
		<tbody>
			<tr align=center class="fixed">
				<td class="fixed">총 상품수</td>
				<td>총 상품금액</td>
				<td></td>
				<td>총 배송비</td>
				<td></td>
				<td>총 할인 금액</td>
				<td></td>
				<td>최종 결제금액</td>
			</tr>
			<tr cellpadding=40 align=center>
				<td id="">
					<p id="p_totalProductNum">${totalProductNum}개</p> <input
					id="h_totalProductNum" type="hidden" value="${totalProductNum}" />
				</td>
				<td>
					<p id="p_totalProductPrice">
						<fmt:formatNumber value="${totalProductPrice}" type="number"
							var="total_product_price" />
						${total_product_price}원
					</p> <input id="h_totalProductPrice" type="hidden"
					value="${totalProductPrice}" />
				</td>
				<td><img width="25" alt=""
					src="${contextPath}/resources/image/plus.jpg"></td>
				<td>
					<p id="p_totalDeliveryPrice">${totalDeliveryPrice }원</p> <input
					id="h_totalDeliveryPrice" type="hidden"
					value="${totalDeliveryPrice}" />
				</td>
				<td><img width="25" alt=""
					src="${contextPath}/resources/image/minus.jpg"></td>
				<td>
					<p id="p_totalSalesPrice">${totalDiscountedPrice}원</p> <input
					id="h_totalSalesPrice" type="hidden" value="${totalSalesPrice}" />
				</td>
				<td><img width="25" alt=""
					src="${contextPath}/resources/image/equal.jpg"></td>
				<td>
					<p id="p_final_totalPrice">
						<fmt:formatNumber
							value="${totalProductPrice+totalDeliveryPrice-totalDiscountedPrice}"
							type="number" var="total_price" />
						${total_price}원
					</p> <input id="h_final_totalPrice" type="hidden"
					value="${totalProductPrice+totalDeliveryPrice-totalDiscountedPrice}" />
				</td>
			</tr>
			<tr>
				<td colspan="8" align="center">
					<p id="freeShippingNotice"
						style="font-size: 16px; font-weight: bold;"></p>
				</td>
			</tr>
		</tbody>
	</table>
	<center>
		<br> <br> <a href="javascript:fn_order_all_cart_product()">
			<img width="75" alt=""
			src="${contextPath}/resources/image/btn_order_final.jpg">
		</a> <a href="${contextPath}/main/main.do"> <img width="75" alt=""
			src="${contextPath}/resources/image/btn_shoping_continue.jpg">
		</a>
		<center>
			<script type="text/javascript">
			function fn_order_all_cart_product() {
			    var objForm = document.frm_order_all_cart;
			    var checkedProducts = document.querySelectorAll("input[name='checked_product']:checked");

			    if (checkedProducts.length === 0) {
			        alert("선택된 상품이 없습니다.");
			        return;
			    }

			    for (var i = 0; i < checkedProducts.length; i++) {
			        var checkbox = checkedProducts[i]; // 현재 체크된 상품
			        var row = checkbox.closest("tr"); // 체크된 상품이 속한 <tr> 찾기
			        var amountInput = row ? row.querySelector("input[name='amount']") : null; // 같은 행에서 amount 필드 찾기
			        var order_product_id = checkbox.value;
			        var order_product_qty = amountInput ? amountInput.value : null;

			        if (!order_product_qty) {
			            console.error("수량 정보를 찾을 수 없습니다.", row);
			            alert("수량 정보를 가져올 수 없습니다.");
			            return;
			        }

			        amountInput.value = order_product_id + ":" + order_product_qty;
			    }

			    objForm.method = "post";
			    objForm.action = "${contextPath}/order/orderAllCartProduct.do";
			    objForm.submit();
			}

		</script>
			</form>