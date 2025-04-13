package com.cookit.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cookit.review.dao.ReviewDAO;
import com.cookit.review.vo.ReviewVO;

@Service("reviewService")
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewDAO reviewDAO;
	
    @Override
    public int addReview(ReviewVO review) {
        return reviewDAO.insertReview(review);
    }

    @Override
    public List<ReviewVO> getReviewsByProduct(int product_id) {
        return reviewDAO.getReviewsByProduct(product_id);
    }

    @Override
    public List<ReviewVO> getReviewsByUser(String user_id) {
        return reviewDAO.getReviewsByUser(user_id);
    }
}
