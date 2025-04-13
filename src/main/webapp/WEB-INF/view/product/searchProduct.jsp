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
<title>Insert title here</title>
</head>
<body>
	<style>
	.search-result-header {
	  text-align: left; /* 텍스트를 왼쪽 정렬 */
	  margin: 20px 0; /* 상하 여백 */
      display: flex;
      justify-content:space-between;
	}
    #chooseSort{
    	margin-left: 490px;
    	margin-top: 30px;
    	display: flex;
    	justify-content:space-between;
    	gap: 15px;
    }
    #chooseSort a{
    	text-decoration-line: none;
    	color: black;
    }
	
	.search-result-header h2 {
	  font-size: 24px; /* 글씨 크기 */
	  font-weight: bold; /* 글씨 굵기 */
	  margin: 0; /* h2의 기본 여백 제거 */
	}
	
	.search-result-header hr {
	  border: none; /* 기본 테두리 제거 */
	  border-top: 1px solid black; /* 상단에 얇은 검정색 선 추가 */
	  margin: 5px 0; /* 선의 위아래 간격 */
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
	<div class="search-result-header">
        <h2>${searchWord} 검색결과</h2>
        <div id="chooseSort">
    		<a href="${contextPath}/product/searchProduct.do?searchWord=${param.searchWord}&sort=1">최근 등록 순</a>
    		<a href="${contextPath}/product/searchProduct.do?searchWord=${param.searchWord}&sort=2">별점 높은 순</a>
    		<a href="${contextPath}/product/searchProduct.do?searchWord=${param.searchWord}&sort=3">별점 낮은 순</a>
    	</div>
        <hr />
    </div>
 	<div class="product-grid">
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