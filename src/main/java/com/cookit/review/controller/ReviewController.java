package com.cookit.review.controller;

import java.math.BigDecimal;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface ReviewController {
    ModelAndView addReview(@RequestParam("product_id") int product_id,
                           @RequestParam("order_id") int order_id,
                           @RequestParam("user_id") String user_id,
                           @RequestParam("rating") BigDecimal rating,
                           @RequestParam("comment") String comment);
}
