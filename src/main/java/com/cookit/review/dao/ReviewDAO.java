package com.cookit.review.dao;

import java.util.List;

import com.cookit.review.vo.ReviewVO;

public interface ReviewDAO {
	int insertReview(ReviewVO review);
    List<ReviewVO> getReviewsByProduct(int product_id);
    List<ReviewVO> getReviewsByUser(String user_id);

}
