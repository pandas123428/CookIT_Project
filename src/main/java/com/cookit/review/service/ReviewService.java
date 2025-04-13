package com.cookit.review.service;

import java.util.List;

import com.cookit.review.vo.ReviewVO;

public interface ReviewService {
	int addReview(ReviewVO review);
	List<ReviewVO> getReviewsByUser(String user_id);
	List<ReviewVO> getReviewsByProduct(int product_id);
}
