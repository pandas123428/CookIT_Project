<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="utf-8">
<title>상품 등록</title>
<link rel="stylesheet" href="${contextPath}/resources/css/main.css">

<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f9f9f9;
    }

    h1 {
        text-align: center;
        color: #333;
    }

    .container {
        max-width: 800px;
        margin: auto;
        background: white;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }

    .tabs {
        display: flex;
        justify-content: space-around;
        padding: 10px 0;
        border-bottom: 2px solid #ddd;
        background: #f5f5f5;
    }

    .tabs li {
        list-style: none;
        padding: 10px 20px;
        cursor: pointer;
        font-weight: bold;
    }

    .tabs li:hover {
        color: #007bff;
    }

    .tab_content {
        display: none;
        padding: 15px;
    }

    .active {
        display: block;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    table tr td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }

    input[type="text"], select, input[type="file"] {
        width: 100%;
        padding: 8px;
        margin-top: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    .btn-container {
        text-align: center;
        margin-top: 20px;
    }

    .btn-submit {
        background: #007bff;
        color: white;
        border: none;
        padding: 10px 15px;
        cursor: pointer;
        font-size: 16px;
        border-radius: 5px;
    }

    .btn-submit:hover {
        background: #0056b3;
    }

    .required {
        color: red;
        font-weight: bold;
    }
</style>

<script>
    function fn_add_new_product(obj) {
        var ImageInput1 = document.querySelector("input[name='product_image_']");
        var ImageInput2 = document.querySelector("input[name='product_inform_']");

        if (!ImageInput1 || !ImageInput2 || !ImageInput1.value || !ImageInput2.value) {
            alert("상품 이미지와 상세정보 이미지 모두를 첨부해야 합니다.");
            return;
        }
        obj.submit();
    }

    // 탭 기능 구현
    function openTab(event, tabId) {
        var i, tabContent, tabLinks;

        tabContent = document.getElementsByClassName("tab_content");
        for (i = 0; i < tabContent.length; i++) {
            tabContent[i].style.display = "none";
        }

        tabLinks = document.getElementsByClassName("tab-link");
        for (i = 0; i < tabLinks.length; i++) {
            tabLinks[i].style.color = "#000";
        }

        document.getElementById(tabId).style.display = "block";
        event.currentTarget.style.color = "#007bff";
    }
    
	function updateProduct(obj) {
		// 폼 제출
		obj.submit();
	}
</script>

</head>
<body>
    <div class="container">
        <h1>상품 수정창</h1>
        
        	<form id="modifyForm" action="${contextPath}/admin/modifyProduct.do" method="post" enctype="multipart/form-data">
            
            <!-- 탭 메뉴 -->
            <ul class="tabs">
                <li class="tab-link" onclick="openTab(event, 'tab1')">상품 정보</li>
                <li class="tab-link" onclick="openTab(event, 'tab2')">상세 정보</li>
                <li class="tab-link" onclick="openTab(event, 'tab3')">상품 이미지</li>
            </ul>

            <!-- 상품 정보 -->
            <div class="tab_content active" id="tab1">
                <table>
                    <tr>
                        <td>상품 카테고리 <span class="required">*</span></td>
                        <td>
                           <select name="product_category">
										<option value="한식" ${product.category_id eq '1' ? 'selected' : ''}>한식
										<option value="중식" ${product.category_id eq '2' ? 'selected' : ''}>중식
										<option value="일식" ${product.category_id eq '3' ? 'selected' : ''}>일식
										<option value="양식" ${product.category_id eq '4' ? 'selected' : ''}>양식
										<option value="분식" ${product.category_id eq '5' ? 'selected' : ''}>분식
										<option value="동남아식" ${product.category_id eq '6' ? 'selected' : ''}>동남아식
						    </select>
                        </td>
                    </tr>
                    <tr>
                        <td>상품 가격 <span class="required">*</span></td>
                        <td><input name="price" type="text" value="${product.price}"/></td>
                    </tr>
                    <tr>
                        <td>상품 이름 <span class="required">*</span></td>
                        <td><input name="product_name" type="text" value="${product.product_name}"/></td>
                    </tr>
                    <tr>
                        <td>상품 재고 <span class="required">*</span></td>
                        <td><input name="product_amount" type="text" value="${product.product_amount}"/></td>
                    </tr>
                </table>
            </div>

            <!-- 상세 정보 -->
            <div class="tab_content" id="tab2">
                <table>
                    <tr><td>소비기한</td><td><input name="product_ex_date" type="text" value="${productInform.product_ex_date}"/></td></tr>
                    <tr><td>원재료명 및 함량</td><td><input name="ingredient_info" type="text" value="${productInform.ingredient_info}"/></td></tr>
                    <tr><td>유전자재조합식품 여부</td><td><input name="GMO_status" type="text" value="${productInform.GMO_status}"/></td></tr>
                    <tr><td>영양성분</td><td><input name="nutrition_facts" type="text" value="${productInform.nutrition_facts}"/></td></tr>
                    <tr><td>생산자</td><td><input name="producer" type="text" value="${productInform.producer}" /></td></tr>
                    <tr><td>생산자 소재지</td><td><input name="product_addr" type="text" value="${productInform.product_addr}" /></td></tr>
                    <tr><td>중량</td><td><input name="product_weight" type="text" value="${productInform.product_weight}"/></td></tr>
                    <tr><td>배송 가능 지역</td><td><input name="delivery_area" type="text" value="${productInform.delivery_area}" /></td></tr>
                    <tr><td>배송 방법</td><td><input name="delivery_method" type="text" value="${productInform.delivery_method}"/></td></tr>
                    <tr><td>수입식품 문구 </td><td><input name="import_notice" type="text" value="${productInform.import_notice}" /></td></tr>
                    <tr><td>영유아식 또는 체중조절 식품 등에 해당 여부</td><td><input name="special_category" type="text" value="${productInform.special_category}"/></td></tr>
                    <tr><td>소비자 상담번호</td><td><input name="customer_service" type="text" value="${productInform.customer_service}"/></td></tr>
                    <tr><td>주의사항</td><td><input name="warnings" type="text" value="${productInform.warnings}" /></td></tr>
                </table>
            </div>

            <!-- 상품 이미지 -->
            <div class="tab_content" id="tab3">
                <table>
                    <tr><td>상품 이미지 <span class="required">*</span></td><td><input type="file" name="product_image_" /></td></tr>
                    <tr><td>상품 상세정보 이미지 <span class="required">*</span></td><td><input type="file" name="product_inform_" /></td></tr>
                </table>
            </div>

            <!-- 등록 버튼 -->
            <div class="btn-container">
                <input type="button" value="상품 수정하기" onClick="updateProduct(this.form)" />
            </div>

        </form>
    </div>

</body>
</html>
