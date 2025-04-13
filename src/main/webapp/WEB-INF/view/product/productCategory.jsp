<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="${contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" media="screen">
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>카테고리 페이지</title>
</head>
<body>
	<style>
	 .header {
    	margin-bottom: 50px;
    	
    }
    .header-1 {
    	display: flex;
    	justify-content:space-between;
    }
    #chooseSort{
    	margin-top: 30px;
    	display: flex;
    	justify-content:space-between;
    	gap: 15px;
    }
    #chooseSort a{
    	text-decoration-line: none;
    	color: black;
    }
    .header-1 select {
    	height:20px;
    	margin-top: 30px;
    }
	.category-menu {
	  display: flex;
	  justify-content: center;
	  padding: 10px 0;
	  border: 1px solid lightgray; /* 외부에 얇은 회색 선 추가 */
	  border-radius: 10px;
	}
	
	.category-menu ul {
	  display: flex;
	  flex-wrap: wrap; /* 두 줄 배치를 활성화 */
	  padding: 0;
	  margin: 0;
	  list-style: none; /* 점(불릿) 제거 */
	  width: 100%; /* 한 줄에 5개 배치를 위한 전체 너비 설정 */
	  justify-content: flex-start; /* 좌측 정렬 */
	}
	
	.category-menu li {
	  flex: 0 0 20%; /* 한 줄에 5개 배치 (100% ÷ 5 = 20%) */
	  text-align: center; /* 텍스트 가운데 정렬 */
	  margin: 10px 0; /* 위아래 간격 설정 */
	}
	
	.category-item {
	  display: inline-block;
	  padding: 5px 10px;
	  text-decoration: none;
	  font-size: 16px;
	  color: black;
	  border-radius: 20px;
	  transition: background-color 0.3s, color 0.3s;
	}
	
	.category-item.active {
	  color: white;
	  background-color: #f56a00;
	}
	 /* ---------------상품 리스트------------------ */
	.product-grid {
	  display: grid;
	  grid-template-columns: repeat(4, 1fr); 
	  gap: 20px; 
	}

    .product-card {
      border: none;
 	  border-radius: 8px;
  	  overflow: hidden;
   	  background-color: #fff;
 	  transition: transform 0.2s, box-shadow 0.2s;
    }

	.product-card:hover .product-image {
	    border-color: #f56a00; 
	}

    .product-image {
	  width: 100%;
	  height: 100%px;
	  object-fit: cover; /* 이미지를 잘라내면서 컨테이너에 꽉 차게 */ 
	  border: 3px solid transparent; 
	  box-sizing: border-box;
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
	</style>
    <div class="header">
      <div class="header-1">
    	<h2>밀키트</h2>
    	<div id="chooseSort">
    		<a href="${contextPath}/product/productCategory.do?category_id=${param.category_id}&sort=1">최근 등록 순</a>
    		<a href="${contextPath}/product/productCategory.do?category_id=${param.category_id}&sort=2">별점 높은 순</a>
    		<a href="${contextPath}/product/productCategory.do?category_id=${param.category_id}&sort=3">별점 낮은 순</a>
    	</div>
       </div>
	    <div class="category-menu">
	        <ul>
	          <li><a href="${contextPath}/product/productCategory.do?category_id=0"
					 class="category-item ${param.category_id == 0 ? 'active' : ''}">전체</a></li>
			  <li><a href="${contextPath}/product/productCategory.do?category_id=1"
					 class="category-item ${param.category_id == 1 ? 'active' : ''}">한식</a></li>
			  <li><a href="${contextPath}/product/productCategory.do?category_id=2"
					 class="category-item ${param.category_id == 2 ? 'active' : ''}">중식·일식</a></li>
			  <li><a href="${contextPath}/product/productCategory.do?category_id=4"
					 class="category-item ${param.category_id == 4 ? 'active' : ''}">양식</a></li>
			  <li><a href="${contextPath}/product/productCategory.do?category_id=5"
					 class="category-item ${param.category_id == 5 ? 'active' : ''}">분식</a></li>
			  <li><a href="${contextPath}/product/productCategory.do?category_id=6"
					 class="category-item ${param.category_id == 6 ? 'active' : ''}">동남아</a></li>
	        </ul>
	      </div>
	    </div>
 	<div id="productList" class="product-grid">
		<c:forEach var="item" items="${productList}">
			<div class="product-card">
				<a href="${contextPath}/product/detailProduct.do?product_id=${item.product_id }">
					<img class="product-image" width="75" alt=""
					src="${contextPath}/thumbnails.do?product_id=${item.product_id}&imageName=${item.product_image}">
				</a>
				<div class="product-info">
					<div class="product-name">${item.product_name}</div>
					<div class="product-price"><fmt:formatNumber value="${item.price}" pattern="#,###" />원</div>
					<div class="product-rating"><span style="margin-left:auto;">★ ${item.rating}</span></div>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>