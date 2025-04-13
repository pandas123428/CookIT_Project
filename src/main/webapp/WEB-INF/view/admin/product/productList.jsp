<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" media="screen">
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>
    function executeCommand(url) {
    	console.log("요청 보낼 URL:", url); // URL 확인용 로그추가
        fetch(url, { method: 'GET' })
        .then(response => response.text())
        .catch(error => console.error('Error:', error));
    } 
</script>
</head>
<body>
	<style>
	.product-grid {
	  display: grid;
	  grid-template-columns: repeat(4, 1fr); 
	  gap: 20px; 
	}

	.product-card {
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  justify-content: space-between;
	  border: none;
	  border-radius: 8px;
	  overflow: hidden;
	  background-color: #fff;
	  padding: 10px;
	  box-sizing: border-box;
	}

	.product-card a:hover .product-image {
      border-color: #f56a00; /* 테두리 색상 변경 */
	}
    
    .product-image {
	  width: 100%;
	  object-fit: cover;
	  border: 3px solid transparent;
	  background-color: #f9f9f9;
	  transition: border 0.1s ease-in-out;
	}

    .product-info {
      padding: 8px;
      text-align: center;
    }

    .product-name {
      font-size: 16px;
      font-weight: bold;
      margin-bottom: 5px;
    }
    
      .product-name  a{
      text-decoration: none;
    }

    .product-price {
      font-size: 18px;
      color: #f56a00;
      font-weight: bold;
      margin-bottom: 5px;
    }

    .product-rating {
      font-size: 14px;
      color: #888;
      display: flex;
      align-items: center;
      margin-right: 30px;
    }

    .product-rating span {
      margin-left: 5px;
    }

    .badge {
      background-color: #ffd700;
      color: #fff;
      font-size: 12px;
      font-weight: bold;
      padding: 2px 6px;
      border-radius: 4px;
      margin-right: 10px;
    }
    /* -------------버튼 부분--------- */
	.product-buttons {
	    display: flex;
	    justify-content: center;
	    gap: 10px;
	    margin-top: 10px;
	    width: 100%;
	}
	
	.product-buttons input {
	    font-size: 12px;
	    padding: 5px 10px;
	    border: none;
	    background-color: #f56a00;
	    color: white;
	    cursor: pointer;
	    border-radius: 4px;
	    transition: background 0.2s, transform 0.2s;
	}
	
	.product-buttons input:hover {
	    background-color: #d94c00;
	    transform: scale(1.05);
	}
	</style>
	<h1>상품 목록</h1>
 	<div class="product-grid">
		<c:forEach var="item" items="${productList}">
			<div class="product-card">
			    <a href="${contextPath}/product/detailProduct.do?product_id=${item.product_id}">
			        <img class="product-image" width="75" alt=""
			             src="${contextPath}/thumbnails.do?product_id=${item.product_id}&imageName=${item.product_image}">
			    </a>
			    <div class="product-info">
			        <div class="product-name">${item.product_name}</div>
			        <div class="product-price"><fmt:formatNumber value="${item.price}" pattern="#,###" />원</div>
			        <div class="product-rating"><span>★ ${item.rating}</span></div>
			    </div>
			    <div class="product-buttons">
			        <input type="button" value="상품 삭제"
			               onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${contextPath}/admin/deleteProduct.do?product_id=${item.product_id}&product_inf_image=${item.product_inf_image}&product_image=${item.product_image }'">
			        <input type="button" value="상품 수정"
			               onclick="location.href='${contextPath}/admin/modifyForm.do?product_id=${item.product_id}'">
			    </div>
			</div>
		</c:forEach>	
	</div>
</body>
</html>