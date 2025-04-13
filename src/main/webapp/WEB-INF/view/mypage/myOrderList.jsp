<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<meta charset="utf-8">
<head>
<title>주문 내역 페이지</title>
	<style>
        .header {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            margin-top: 50px;
        }

        .order-container {
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fff;
            padding: 15px;
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .order-header {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        .order-summary {
            font-size: 14px;
            color: #555;
            margin-bottom: 10px;
        }

        .order-summary span {
            font-weight: bold;
            color: #333;
        }

        .order-items {
            margin-top: 10px;
            border-top: 1px solid #ddd;
            padding-top: 10px;
        }

        .order-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .order-item:last-child {
            margin-bottom: 0;
        }

        .order-item img {
            width: 80px;
            height: 80px;
            border-radius: 5px;
            margin-right: 15px;
        }

        .order-details {
            flex-grow: 1;
        }

        .order-details h3 {
            margin: 0;
            font-size: 16px;
            color: #333;
        }

        .order-details p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
        }

        .order-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .order-actions button {
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            font-size: 14px;
            cursor: pointer;
        }

        .order-actions button:hover {
            background-color: #45a049;
        }

        /* 페이지 오른쪽 끝에 리뷰 작성 창 고정 */
        .review-box {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            top: 50px;
            right: 100px;
            width: 600px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            z-index: 100;
            margin-top: 200px;
        }

        .review-box textarea {
            width: 100%;
            height: 80px;
            margin-bottom: 10px;
        }

        .review-box select {
            width: 100%;
            padding: 5px;
            margin-bottom: 10px;
        }

        .review-box button {
            width: 100%;
            padding: 8px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .review-box button:hover {
            background-color: #45a049;
        }
	    .review-actions {
	        display: flex;
	        justify-content: space-between;
	        gap: 10px;
	    }
	
	    .review-actions button {
	        flex: 1;
	    }    
    </style>
</head>
<body>
    <div class="header">주문 내역</div>
    
    <c:forEach var="item" items="${myOrderList}" varStatus="obj">
    <div class="order-container" id="test11">
        <div class="order-content">
            <div class="order-header">${item.order_date} 주문</div>
            <div class="order-summary">
                할인 전 금액: <span id="${obj.index }"><fmt:formatNumber value="${item.t_order_price}" pattern="#,###" />원</span>
                | 배송비: <span><fmt:formatNumber value="${item.delivery_price}" pattern="#,###" />원</span>
                | 총 할인 금액: <span><fmt:formatNumber value="${item.t_discount_price}" pattern="#,###"/>원</span>
                | 총 결제 금액: <span><fmt:formatNumber value="${item.f_t_order_price}" pattern="#,###" />원</span>
                | 적립 포인트: <span><fmt:formatNumber value="${item.cash_point}" pattern="#,###"/>P</span>
            </div>
            <input type="hidden" id="order_id_${obj.index }" name="order_id_${obj.index }" value="${item.order_id}" />
            <input type="hidden" id="user_id_${obj.index }" name="user_id_${obj.index }" value="${item.user_id}" />
            <c:forEach var="each_order" items="${item.each_orderList}" varStatus="subObj">
            <div class="order-items">
                <div class="order-item">
                    <a href="${contextPath}/product/detailProduct.do?product_id=${each_order.product_id }">
                        <img class="product-image" width="75" alt=""
                        src="${contextPath}/thumbnails.do?product_id=${each_order.product_id}&imageName=${each_order.product_image}">
                    </a>
                    <div class="order-details">
                        <h3>${each_order.product_name}</h3>
                        <p><strong>${each_order.order_price}원</strong></p>
                    </div>
                        <input type="hidden" id="product_id_${obj.index +subObj.index}" name="product_id_${obj.index +subObj.index}" value="${each_order.product_id}" />
                    <div class="order-actions">
                        <button class="review-btn" onclick="input_review(${obj.index },${obj.index +subObj.index})">리뷰쓰기</button>
                    </div>
                     <input type="hidden" id="rating_${obj.index +subObj.index}" name="rating_${obj.index +subObj.index}"  />
                     <input type="hidden" id="comment_${obj.index +subObj.index}" name="comment_${obj.index +subObj.index}"/>  
                </div>
            </div>
            </c:forEach>
        </div>
    </div>
    </c:forEach>

    <!-- 리뷰 창 -->
    <div class="review-box" id="review-box">
        <h4>리뷰 작성</h4>
        <p>상품 이름: <span id="review-product-id"></span></p>
        <label>별점 선택</label>
        <select id="rating">
        	<option value="0">0</option>
        	<option value="0.5">0.5</option>
            <option value="1.0">1.0</option>
            <option value="1.5">1.5</option>
            <option value="2.0">2.0</option>
            <option value="2.5">2.5</option>
            <option value="3.0">3.0</option>
            <option value="3.5">3.5</option>
            <option value="4.0">4.0</option>
            <option value="4.5">4.5</option>
            <option value="5.0">5.0</option>
        </select>
        <input type="hidden" id="h_rating" name="h_rating"  />
        <textarea placeholder="리뷰를 입력하세요"></textarea>
        <input type="hidden" id="h_comment" name="h_comment"/>  
	    <div class="review-actions">
	        <button onclick="submit_review()">제출</button>
	        <button onclick="closeReview()">닫기</button>
	    </div>
    </div>  
  <script>
  	  const reviewBox = document.getElementById("review-box");
	  var ratingSelect = document.getElementById("rating");
	  var reviewTextarea = document.querySelector(".review-box textarea");
	  var i_comment = "";
	  var i_rating = 0;
	  
	  var obj_index = 0;
	  var subObj_index = 0;
  
	  function input_review(index,index2) {
		  var product_id = document.getElementById("product_id_"+index2).value;
	      var order_id = document.getElementById("order_id_"+index).value;
	      var user_id = document.getElementById("user_id_"+index).value;
	      var rating = document.getElementById("rating_"+index2).value;
	      var comment = document.getElementById("comment_"+index2).value;
	      
	      obj_index = index;
	      subObj_index = index2;
	      
	      var h_rating = i_rating;
	      var h_comment = i_comment;
	     
	       
	      rating = h_rating;
	      comment = h_comment;
	      
	  }
	  
	  function submit_review() {
		  console.log("테스트여1234:");
		  var product_id = document.getElementById("product_id_"+subObj_index).value;
	      var order_id = document.getElementById("order_id_"+obj_index).value;
	      var user_id = document.getElementById("user_id_"+obj_index).value;
	      var rating = i_rating;
	      var comment = i_comment;

	      
	        if (comment == "") {
	            alert("글을 작성해주세요."); 
	        	return;
	        }
	        
	        var formObj = document.createElement("form");
	        formObj.method = "post";
	        formObj.action = "${contextPath}/review/addReview.do";
	        
	        document.body.appendChild(formObj);
	        
	        var in_product_id = createHiddenInput("product_id", product_id);
	        var in_order_id = createHiddenInput("order_id", order_id);
	        var in_user_id = createHiddenInput("user_id", user_id);
	        var in_rating = createHiddenInput("rating", rating);
	        var in_comment = createHiddenInput("comment", comment);
	        
	        formObj.appendChild(in_product_id);
	        formObj.appendChild(in_order_id);
	        formObj.appendChild(in_user_id);
	        formObj.appendChild(in_rating);
	        formObj.appendChild(in_comment);
		      
		    obj_index = 0;
		    subObj_index = 0;
		    i_comment = "";
		    i_rating = 0;
		    ratingSelect.value = 0;
		    reviewTextarea.value = "";
		    
	        formObj.submit(); 
	        
		    alert("작성이 완료되었습니다.");
		    
		    closeReview();
		    
	  }
	  
	  function createHiddenInput(name, value) {
        var input = document.createElement("input");
        input.type = "hidden";
        input.name = name;
        input.value = value;
        return input;
	  }
	  
	  function closeReview() {
        reviewBox.style.display = "none";
        ratingSelect.value = 0;
        reviewTextarea.value = "";
	  }
	  
	  document.addEventListener("DOMContentLoaded", function () {
        const reviewBox = document.getElementById("review-box");
        const reviewText = document.getElementById("review-product-id");
        const reviewButtons = document.querySelectorAll(".review-btn");
        const ratingSelect = document.getElementById("rating");
        const reviewTextarea = document.querySelector(".review-box textarea");

	        
        reviewButtons.forEach(button => {
            button.addEventListener("click", function () {
                let productName = this.closest(".order-item").querySelector(".order-details h3").innerText;
                reviewText.innerText = productName;
                reviewBox.style.display = reviewBox.style.display === "none" || reviewBox.style.display === "" ? "block" : "none";
            });
        });

	        ratingSelect.addEventListener("change", function () {
	            i_rating = this.value;
	        });
	
	        reviewTextarea.addEventListener("input", function () {
	            i_comment = this.value;
	        });
	  });
	</script>
</body>
</html>
