package com.cookit.review.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cookit.review.vo.ReviewVO;

@Repository("reviewDAO")
public class ReviewDAOImpl implements ReviewDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "mapper.review";
	
	@Override
	public int insertReview(ReviewVO review) {
		System.out.println(review.getRating());
		return sqlSession.insert(NAMESPACE + ".insertReivew", review);
	}
	
	@Override
	public List<ReviewVO> getReviewsByProduct(int product_id){
		return sqlSession.selectList(NAMESPACE + ".getReviewsByProduct", product_id);
	}
	
	@Override
	public List<ReviewVO> getReviewsByUser(String user_id){
		return sqlSession.selectList(NAMESPACE + ".getReviewsByUser", user_id);
	}
}
