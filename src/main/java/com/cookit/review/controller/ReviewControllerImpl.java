package com.cookit.review.controller;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.review.service.ReviewService;
import com.cookit.review.vo.ReviewVO;


@Controller("reviewController")
@RequestMapping(value="/review")
public class ReviewControllerImpl implements ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Override
    @RequestMapping(value = "/addReview.do", method = RequestMethod.POST)
    public ModelAndView addReview(@RequestParam("product_id") int productId,
                                  @RequestParam("order_id") int orderId,
                                  @RequestParam("user_id") String userId,
                                  @RequestParam("rating") BigDecimal rating,
                                  @RequestParam("comment") String comment) {

        ReviewVO review = new ReviewVO();
        System.out.println(productId);
        System.out.println(orderId);
        System.out.println(userId);
        System.out.println(rating);
        System.out.println(comment);
        review.setProduct_id(productId);
        review.setOrder_id(orderId);
        review.setUser_id(userId);
        review.setRating(rating);
        review.setComment(comment);

        int result = reviewService.addReview(review);
        
        ModelAndView mav = new ModelAndView("redirect:/mypage/orderDetail.do");
        
        if (result > 0) {
            mav.addObject("message", "리뷰가 성공적으로 등록되었습니다.");
        } else {
            mav.addObject("message", "리뷰 등록 실패");
        }
        
        return mav;
    }
}

