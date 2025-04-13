<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    var swiper = new Swiper(".swiper-container", {
      slidesPerView: 1, // 한 번에 보여지는 슬라이드 수
      spaceBetween: 0, // 슬라이드 간 간격
      loop: true, // 무한 루프
      initialSlide: 0, // 처음 보여질 슬라이드 인덱스 (0부터 시작)
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
      pagination: {
        el: ".swiper-pagination",
        type: "fraction",
      },
      autoplay: {
        delay: 3000,
        disableOnInteraction: false,
      },
    });

    // Play/Pause 버튼 동작
    document.querySelector(".swiper-button-play").addEventListener("click", function () {
      swiper.autoplay.start();
      this.style.display = "none";
      document.querySelector(".swiper-button-pause").style.display = "inline-block";
    });

    document.querySelector(".swiper-button-pause").addEventListener("click", function () {
      swiper.autoplay.stop();
      this.style.display = "none";
      document.querySelector(".swiper-button-play").style.display = "inline-block";
    });
  });
</script>
<style type="text/css">
.swiper-container {
  width: 100vw; /* 화면 너비를 꽉 채움 */
  height: auto; /* 높이는 비율에 따라 자동 조정 */
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden; /* 초과되는 부분 숨김 */
  position: relative;
}

.swiper-slide {
  width: 100%;
  height: 100%;
}

.swiper-slide img {
  width: 100%;
  height: 100%;
  object-fit: cover; /* 비율 유지하며 배너 채우기 */
}

/* 작은 화면에서도 적절히 표시되도록 반응형 설정 */
@media (max-width: 768px) {
  .swiper-container {
    height: 300px; /* 모바일 화면에서 배너 높이를 줄임 */
  }

  .swiper-slide img {
    object-fit: contain; /* 작은 화면에서 짤림 없이 표시 */
  }
}

  .swiper-button-next, .swiper-button-prev {
    color: #fff;
  }

  .swiper-pagination {
    color: #fff;
  }

  .swiper-button-play, .swiper-button-pause {
    position: absolute;
    bottom: 20px;
    right: 20px;
    background: rgba(0, 0, 0, 0.5);
    color: #fff;
    border: none;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
  }
  </style>
</head>
<body>
	<div class="swiper-container main-slide">
  <div class="swiper-wrapper">
    <div class="swiper-slide">
      <div class="inner-div-main-swiper">
        <a href="javascript:;" onclick="#" class="btn-back">
          <img src="${contextPath}/resources/image/banner_img1.jpg" alt="메인비쥬얼이미지">
        </a>
      </div>
    </div>
    <div class="swiper-slide">
      <div class="inner-div-main-swiper">
        <a href="javascript:;" onclick="#" class="btn-back">
          <img src="${contextPath}/resources/image/banner_img2.jpg" alt="메인비쥬얼이미지">
        </a>
      </div>
    </div>
    <div class="swiper-slide">
      <div class="inner-div-main-swiper">
        <a href="javascript:;" onclick="#" class="btn-back">
          <img src="${contextPath}/resources/image/banner_img3.jpg" alt="메인비쥬얼이미지">
        </a>
      </div>
    </div>
  </div><!--// swiper-wrapper -->
  <div class="main-slide-bottom">
    <div class="inner">
      <div class="main-slide-btns">
        <div class="swiper-pagination swiper-pagination-fraction">
          <span class="swiper-pagination-current">1</span>｜<span class="swiper-pagination-total">3</span>
        </div>
      </div><!--// main-slide-btns -->
      <div class="main-slide-playctrl">
        <button type="button" class="swiper-button-pause"><span class="blind">PLAY</span></button>
        <button type="button" class="swiper-button-play" style="display: none;"><span class="blind">STOP</span></button>
      </div>
    </div>
  </div><!--// main-slide-bottom -->
</div>
</body>
</html>