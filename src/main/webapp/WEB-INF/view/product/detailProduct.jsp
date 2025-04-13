<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품 상세 페이지</title>
</head>
   <style>
      html {
       scroll-behavior: smooth;
      }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .product-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .product-header h1 {
            font-size: 24px;
            margin: 0;
        }
        
        .product-price {
            display: flex;
            justify-content: space-between;
        }

       .product-price span {
            font-size: 24px;
            font-weight: bold;
            color: #f36a1d;
        }

        .product {
            display: flex;
            margin-top: 20px;
        }

        .product-image {
            flex: 1;
            max-width: 400px;
            padding: 10px;
        }

        .product-image img {
            width: 450px;
            border-radius: 8px;
        }

        .product-details {
            flex: 2;
            padding: 20px;
            margin-left: 100px;
        }

        .details-section {
            margin-bottom: 20px;
        }

        .details-section h2 {
            font-size: 30px;
            margin-bottom: 10px;
        }
        
        span {
            font-size: 20px;
            font-weight: bold;
        }
        
        .details-section p {
            margin: 0;
        }
        
        .price h3 {
            font-size: 25px;
            margin-bottom: 10px;
        }
        
        .delivery-section {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .delivery-section .a {
            display: flex;
            align-items: center;
        }
        
        .delivery-section .a .a-1 {
           color: #A9A9A9;
        }
        
        .delivery-section .a .a-2 {
           font-weight: bold;
        }
        
          .delivery-section .b {
           font-size: 15px;
        }

        .buy-section {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            gap: 20px;
        }
        
        .quantity-section {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px 20px;
            width: 400px;
            gap:20px;
        }
        .control-section {
           display: flex;
           justify-content: space-between;
        }

        .item-info {
            font-size: 14px;
            color: #333;
        }

        #price {
            font-weight: bold;
            color: #000;
            font-size: 16px;
        }

        .quantity-control {
            display: flex;
            align-items: center;
            border: 1px solid #ccc;
            border-radius: 4px;
            overflow: hidden;
        }

        .quantity-control button {
            background-color: #fff;
            border: none;
            width: 30px;
            height: 30px;
            font-size: 16px;
            cursor: pointer;
        }

        .quantity-control button:hover {
            background-color: #f0f0f0;
        }

        .quantity-control input {
            width: 40px;
            height: 30px;
            border: none;
            text-align: center;
            font-size: 14px;
            color: #333;
        }

        .quantity-control input:focus {
            outline: none;
        }

        .buy-buttons {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .buy-buttons button {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
        }

        .buy-now {
            background-color: #f36a1d;
            color: white;
            border: none;
        }

        .cart {
            background-color: white;
    		border: 1px solid #888;
        }
        
  /* --------------------------추천 상품 이미지--------------------------------------- */
  
     .product-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr); 
        gap: 20px; 
      }
   
      .product-card {
         border: none;
         border-radius: 8px;
         overflow: hidden;
         background-color: none;
         transition: transform 0.2s, box-shadow 0.2s;
       }
   
      .product-card:hover .product-image {
          border-color: #f56a00; 
      }
   
      .product-image {
        width: 100%;
        height: 100%px;
        object-fit: cover;
        border: 3px solid transparent; 
        box-sizing: border-box;
        background-color: #f9f9f9; 
        transition: border 0.1s ease-in-out;
       }
   
       .product-info {
         padding: 8px;
         text-align: center;
         display: flex;
        justify-content: space-between;
       }
   
       .product-name {
         font-size: 13px;
         font-weight: bold;
         margin-bottom: 5px;
       }
       
       .product-name  a{
         text-decoration: none;
       }
   
       .product-price {
         font-size: 15px;
         color: #f56a00;
         font-weight: bold;
         margin-bottom: 5px;
       }
   
/* -------------------------------하단 메뉴------------------------------------------ */
        .product_menu {
            border-top: 1px solid black;
            border-bottom: 1px solid #E0E0E0;
            border-left: none;
            border-right: none;
            padding: 10px 0;
            text-align: center;
            margin-top: 20px;
        }

        .product_menu ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .product_menu li {
            display: inline-block;
        }

        .product_menu a {
             text-decoration: none;
           color: black;
           font-weight: bold;
           padding-bottom: 5px;
           display: inline-block;
           border-bottom: 2px solid transparent;
           transition: border-color 0.3s ease-in-out;
        }    
        
        .product_menu a.active {
           border-bottom: 2px solid orange;
      }
        
        .product_menu span {
          font-size: 18px;
          margin: 0 20px;
      }
      
      #product-detail1 {
          margin-top: 20px;
      }
      .product-detail-wrap {
         display: flex;
            flex-direction: column;
            justify-content: center;
      }
      
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
/* --------------------리뷰------------------------------------- */
      #product-detail4 {
          width: 100%;
          margin: 0 auto;
          font-family: Arial, sans-serif;
          color: #333;
          margin-top:5px;
      }
      
      .review-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 10px 0;
      }
      
      .write-review-button {
          padding: 5px 10px;
          border: 1px solid #ccc;
          border-radius: 20px;
          background-color: white;
          cursor: pointer;
          font-size: 14px;
      }
      
      .review-header h3 {
          font-size: 18px;
          font-weight: bold;
          margin: 0;
          color: #333;
      }
      
      .review-header .review-count {
          color: orange;
          font-size: 16px;
      }
      
      .write-review-link {
          padding: 5px 10px;
          border: 1px solid #ccc;
          border-radius: 20px;
          background-color: white;
          color: #333;
          text-decoration: none;
          font-size: 14px;
          display: inline-block;
          cursor: pointer;
      }

      .write-review-link:hover {
          background-color: #f0f0f0;
      }
      
      .divider {
          border: none;
          border-bottom: 1px solid #ccc;
          margin: 10px 0;
      }
      
      .non-review {
          text-align: center;
          padding: 20px 0;
          color: #888;
      }
      
      .non-review .no-review {
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 10px;
      }
      
      .non-review .no-review-icon {
          font-size: 50px;
          color: #ccc;
      }
      
        .review {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }

        .review-rating {
            color: orange;
            font-size: 12px;
        }

        .review-user {
            color: #555;
        }

        .review-user .username {
            font-weight: bold;
            font-size: 15px;
        }

        .review-user .date {
            margin-left: 10px;
            color: #999;
            font-size: 15px;
        }
        
    </style>
<script type="text/javascript">
function add_cart(product_id) {
	var amount = $("#quantity").val();
    $.ajax({
        type: "post",
        url: "${contextPath}/cart/addProductInCart.do",
        data: { product_id: product_id,
        	amount: amount	
        },
        success: function(data, textStatus) {
            if (data.trim() === "add_success") {
                imagePopup('open', '.layer01');	
                alert("장바구니에 담겻습니다.");	
            } else if (data.trim() === "already_existed") {
                alert("이미 장바구니에 등록된 상품입니다.");	
            } else if (data.trim() === "not_logged_in") {
                alert("로그인이 필요합니다.");	
            }
        },
        error: function(xhr, textStatus, errorThrown) {
            alert("에러가 발생했습니다. " + xhr.responseText);
        }
    });
}
function imagePopup(type) {
   if (type == 'open') {
      // 팝업창을 연다.
      jQuery('#layer').attr('style', 'visibility:visible');

      // 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
      jQuery('#layer').height(jQuery(document).height());
   }

   else if (type == 'close') {

      // 팝업창을 닫는다.
      jQuery('#layer').attr('style', 'visibility:hidden');
   }
}
function buy_product(product_id, product_name, product_price, product_image) {
	var isLogOn=${isLogOn};
	
	if (isLogOn == "false" || isLogOn == '') {
		alert("로그인 후 주문이 가능합니다.");
	}

	
    var quantity = document.getElementById("quantity");
    if(${product.product_amount} == 0){
    	alert("상품이 품절되어 구매하실 수 없습니다.");
    	return;
    }

    var formObj = document.createElement("form");
    formObj.method = "post";
    formObj.action = "${contextPath}/order/orderEachProduct.do";

    var i_product_id = createHiddenInput("product_id", product_id); 
	var i_product_name = createHiddenInput("product_name", product_name);
	var i_product_price = createHiddenInput("product_price", product_price);
    var i_product_image = createHiddenInput("product_image", product_image);
    var i_product_qty = createHiddenInput("quantity", quantity.value);

    formObj.appendChild(i_product_id);
 	formObj.appendChild(i_product_name);
	formObj.appendChild(i_product_price);
    formObj.appendChild(i_product_image);
	formObj.appendChild(i_product_qty);

    document.body.appendChild(formObj);
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
    <div class="container">
        <div class="product">
            <div class="product-image">
               <img alt="cookit"
            src="${contextPath}/download.do?product_id=${product.product_id}&imageName=${product.product_image}">
            </div>
            <div class="product-details">
                <div class="details-section">
                    <h2>${product.product_name }</h2>
                </div>
                <div class="product-rating"><span style="margin-left:auto;">★ ${product.rating}</span></div>
                <div class="price">
                   <h3><fmt:formatNumber value="${product.price}" pattern="#,###" />원</h3>
                </div>
                <div class="delivery-section">
                   <div class="a">
                      <div class="a-1">배송비</div>&nbsp&nbsp&nbsp&nbsp
                       <div class="a-2">3,000원</div>
                   </div>
                    <div class="b"><p>40,000원 이상 구매 시 무료배송</p></div>
                </div>
   <div class="buy-section">
                    <div class="quantity-section">
                        <div class="product_name">${product.product_name}</div>
                        <div class="control-section">
                            <div 
                            class="quantity-control">
                                <button onclick="updateQuantity(-1)">-</button>
                                <input type="text" id="quantity" value="1" readonly>
                                <button onclick="updateQuantity(1)">+</button>
                            </div>
                            <div id="currentPrice"><fmt:formatNumber value="${product.price}" pattern="#,###" />원</div>
                        </div>
                    </div>
	
                    <div class="product-price">
                        <label for="price">구매예정 금액</label>
                        <span id="finalPrice"><fmt:formatNumber value="${product.price}" pattern="#,###" />원</span>
                    </div>
     
                    <div class="buy-buttons">
                        <a class="add-cart" href="javascript:add_cart('${product.product_id }')"><button class="cart">장바구니</button></a>
                        <a class="buy" href="javascript:buy_product('${product.product_id }','${product.product_name }','${product.price}','${product.product_image}');"><button class="buy-now">바로구매</button></a>
                    </div>
<%--                                         <c:when test="${product.product_price == 0}">
                    	<h1>품절되어 구매하실 수 없습니다!</h1>
                    </c:when>
                    <c:otherwise>
                  </c:otherwise> --%>
                </div>
            </div>
        </div>
    </div>
    <script>
        // JSP에서 서버로부터 받은 product 가격을 JavaScript 변수에 저장
        const productPrice = ${product.price}; // 기본 가격 (서버에서 전달)
        const quantityInput = document.getElementById('quantity'); // 수량 입력 필드
        const currentPriceElement = document.getElementById('currentPrice'); // 실시간 가격
        const finalPriceElement = document.getElementById('finalPrice'); // 구매예정 금액

        // 수량 변경 시 호출되는 함수
        function updateQuantity(change) {
        	let max_quantity = ${product.product_amount};
            let quantity = parseInt(quantityInput.value) + change;
            if (quantity < 1) quantity = 1; // 최소 수량은 1로 제한
            if(quantity > max_quantity) quantity = max_quantity;
            if(max_quantity == 0) quantity = 0;
            quantityInput.value = quantity;
            /* quantityInput.value = quantity; */
            // 총 가격 계산
            const totalPrice = productPrice * quantity;

            // 실시간 가격 및 구매예정 금액 업데이트
            currentPriceElement.textContent = totalPrice.toLocaleString('ko-KR') + '원';
            if(totalPrice >= 40000){
               finalPriceElement.textContent = (totalPrice).toLocaleString('ko-KR') + '원';   
            }
            else {
               finalPriceElement.textContent = (totalPrice + 3000).toLocaleString('ko-KR') + '원';   
            }
        }
    </script>
    <div style="border-bottom: 1px solid #E0E0E0; width: 100%; padding-bottom: 5px;">
    <h2>고객님을 위한 추천상품</h2>
   </div>
       <div class="product-grid">
      <c:forEach var="item" items="${relationProduct}">
         <div class="product-card">
            <a href="${contextPath}/product/detailProduct.do?product_id=${item.product_id }">
               <img class="product-image" width="75" alt=""
               src="${contextPath}/thumbnails.do?product_id=${item.product_id}&imageName=${item.product_image}">
            </a>
            <div class="product-info">
               <div class="product-name">${item.product_name}</div>
               <div class="product-price"><fmt:formatNumber value="${item.price}" pattern="#,###" />원</div>
            </div>
         </div>
      </c:forEach>
   </div>
   <div class="product-detail-wrap">
      <div class="product_menu">
         <ul>
            <li class="menu1"><a href="#product-detail1"><span>상세정보</span></a></li>
            <li class="menu2"><a href="#product-detail2"><span>기본정보</span></a></li>
            <li class="menu3"><a href="#product-detail3"><span>사용법 / 배송정보</span></a></li>
            <li class="menu4"><a href="#product-detail4"><span>상품리뷰</span></a></li>
         </ul>
      </div>
      <div id="product-detail1">
               <img alt="cookit"
            src="${contextPath}/download.do?product_id=${product.product_id}&imageName=${product.product_inf_image}">
          </div>
          <div id="product-detail2">
             <table>
             <tr>
                  <th>식품 이름</th>
                  <td>${productInform.product_name}</td>
                  <th>중량</th>
                  <td>상세페이지 참고</td>
              </tr>
              <tr>
                  <th>소비기한</th>
                  <td>${productInform.product_ex_date}</td>
                  <th>배송 가능 지역</th>
                  <td>${productInform.delivery_area}</td>
              </tr>
              <tr>
                  <th>원재료명 및 함량</th>
                  <td>${productInform.ingredient_info}</td>
                  <th>배송 방법</th>
                  <td>${productInform.delivery_method}</td>
              </tr>
              <tr>
                  <th>유전자재조합식품 여부</th>
                  <td>${productInform.GMO_status}</td>
                  <th>수입식품 문구</th>
                  <td>${productInform.import_notice}</td>
              </tr>
              <tr>
                  <th>영양성분</th>
                  <td>${productInform.nutrition_facts}</td>
                  <th>영유아식 또는 체중조절식품 등에 해당 여부</th>
                  <td>${productInform.special_category}</td>
              </tr>
              <tr>
                  <th>제조사</th>
                  <td>${productInform.producer}</td>
                  <th>소비자 상담 번호</th>
                  <td>${productInform.customer_service}</td>
              </tr>
              <tr>
                  <th>생산자 소재지</th>
                  <td>${productInform.product_addr}</td>
                  <th>주의사항</th>
                  <td>${productInform.warnings}</td>
              </tr>
             </table>
          </div>
          <div id="product-detail3">
              <img alt="cookit" src="${contextPath}/resources/image/guideImage.png">
              <img alt="cookit" src="${contextPath}/resources/image/delivery_info.png">
          </div>
          <div id="product-detail4">
          <div class="review-header">
              <h3>상품리뷰 <span class="review-count">${rivewList_count}건</span></h3>
       </div>
       <hr class="divider" />
       <c:choose>
    <c:when test="${rivewList_count >= 1}">
   <c:forEach var="review" items="${reviewList}">
    <div class="review">
        <div class="review-rating">
            ★
        </div>
        <div class="review-user">
            <span class="username">${review.user_id }</span>
            <span class="date">${review.review_only_date }</span>
        </div>
        <div class="review-content">
          <p>${review.comment }</p>
        </div>
    </div>
    </c:forEach>
    </c:when>
    <c:otherwise>
      <div class="non-review">
        <div class="no-review">
          <div class="no-review-icon">❌</div>
          <p>등록된 리뷰가 없습니다.</p>
         </div>
       </div>
    </c:otherwise>
</c:choose>
      </div>
   </div>
<script>
  

</script>
<%-- <input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/> --%>

</body>
</html>