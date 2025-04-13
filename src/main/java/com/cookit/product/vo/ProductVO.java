package com.cookit.product.vo;

import org.springframework.stereotype.Component;

@Component("productVO")
public class ProductVO {
  private int product_id;
  
  private String product_name;
  
  private int price;
  
  private int product_amount;
  
  private int category_id;
  
  private String product_inf_image;
  
  private String product_image;
  
  private String reg_id;
  
  private String post_date;
  
  private float rating;
  
  public int getProduct_id() {
    return this.product_id;
  }
  
  public void setProduct_id(int product_id) {
    this.product_id = product_id;
  }
  
  public String getProduct_name() {
    return this.product_name;
  }
  
  public void setProduct_name(String product_name) {
    this.product_name = product_name;
  }
  
  public int getPrice() {
    return this.price;
  }
  
  public void setPrice(int price) {
    this.price = price;
  }
  
  public int getProduct_amount() {
    return this.product_amount;
  }
  
  public void setProduct_amount(int product_amount) {
    this.product_amount = product_amount;
  }
  
  public int getCategory_id() {
    return this.category_id;
  }
  
  public void setCategory_id(int category_id) {
    this.category_id = category_id;
  }
  
  public String getProduct_inf_image() {
    return this.product_inf_image;
  }
  
  public void setProduct_inf_image(String product_inf_image) {
    this.product_inf_image = product_inf_image;
  }
  
  public String getProduct_image() {
    return this.product_image;
  }
  
  public void setProduct_image(String product_image) {
    this.product_image = product_image;
  }
  
  public String getReg_id() {
    return this.reg_id;
  }
  
  public void setReg_id(String reg_id) {
    this.reg_id = reg_id;
  }
  
  public String getPost_date() {
    return this.post_date;
  }
  
  public void setPost_date(String post_date) {
    this.post_date = post_date;
  }
  
  public float getRating() {
    return this.rating;
  }
  
  public void setRating(float rating) {
    this.rating = rating;
  }
}
