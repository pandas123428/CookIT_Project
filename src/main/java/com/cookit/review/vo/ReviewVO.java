package com.cookit.review.vo;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;

import org.springframework.stereotype.Component;


@Component("reviewVO")
public class ReviewVO {
	private int review_id;
	private int product_id;
	private int order_id;
	private String user_id;
	private BigDecimal rating;
	private String comment;
	private Timestamp review_date;
	private LocalDate review_only_date;
	
	public int getReview_id() {
		return review_id;
	}
	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public BigDecimal getRating() {
		return rating;
	}
	public void setRating(BigDecimal rating) {
		this.rating = rating;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Timestamp getReviewDate() {
		return review_date;
	}
	public void setReviewDate(Timestamp review_date) {
		this.review_date = review_date;
	}
	public LocalDate getReview_only_date() {
		return review_only_date;
	}
	public void setReview_only_date(LocalDate review_only_date) {
		this.review_only_date = review_only_date;
	}
	
	
	
	
	
}
