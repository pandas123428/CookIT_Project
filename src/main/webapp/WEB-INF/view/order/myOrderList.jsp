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
    </style>
</head>
<body>
    <div class="header">주문/배송 내역</div>
    
    <c:forEach var="item" items="${myOrderList}">
    <div class="order-container">
        <div class="order-header">${item.order_date} 주문</div>
        <div class="order-summary">
        	할인 전 금액: <span><fmt:formatNumber value="${item.t_order_price}" pattern="#,###" />원</span>
        	| 배송비: <span><fmt:formatNumber value="${item.delivery_price}" pattern="#,###" />원</span>
        	| 총 할인 금액: <span><fmt:formatNumber value="${item.t_discount_price}" pattern="#,###"/>원</span>
            | 총 결제 금액: <span><fmt:formatNumber value="${item.f_t_order_price}" pattern="#,###" />원</span>
            | 적립 포인트: <span><fmt:formatNumber value="${item.cash_point}" pattern="#,###"/>P</span>
        </div>
        <c:forEach var="each_order" items="${item.each_orderList}">
        <div class="order-items">
            <!-- 항목 1 -->
            <div class="order-item">
                <a href="${contextPath}/product/detailProduct.do?product_id=${each_order.product_id }">
                <img class="product-image" width="75" alt=""
                src="${contextPath}/thumbnails.do?product_id=${each_order.product_id}&imageName=${each_order.product_image}">
                </a>
                <div class="order-details">
                    <h3>${each_order.product_name}</h3>
                    <p><strong>${each_order.order_price}원</strong></p>
                </div>
                <div class="order-actions">
                    <button >리뷰쓰기</button>
                </div>
            </div>
        </div>
        </c:forEach>
    </div>
        </c:forEach>      
</body>
</html>

	
			
			
			