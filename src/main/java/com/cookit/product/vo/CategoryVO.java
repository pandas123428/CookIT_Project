package com.cookit.product.vo;

import org.springframework.stereotype.Component;

@Component("categoryVO")
public class CategoryVO {
  private int category_id;
  
  private String category_name;
  
  public int getCategory_id() {
    return this.category_id;
  }
  
  public void setCategory_id(int category_id) {
    this.category_id = category_id;
  }
  
  public String getCategory_name() {
    return this.category_name;
  }
  
  public void setCategory_name(String category_name) {
    this.category_name = category_name;
  }
}
