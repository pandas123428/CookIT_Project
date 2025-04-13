package com.cookit.product.service;

import com.cookit.product.vo.ProductInformVO;
import com.cookit.product.vo.ProductVO;
import com.cookit.review.vo.ReviewVO;
import java.util.List;

public interface ProductService {
  List<ProductVO> listAllProduct() throws Exception;
  
  ProductVO detailProduct(int paramInt) throws Exception;
  
  ProductInformVO productInform(int paramInt) throws Exception;
  
  List<ProductVO> relationProduct(int paramInt) throws Exception;
  
  List<ProductVO> recommnedProduct(int paramInt) throws Exception;
  
  List<ProductVO> newProduct() throws Exception;
  
  List<ProductVO> twoProductCategory() throws Exception;
  
  List<ProductVO> normalProductCategory(int paramInt) throws Exception;
  
  List<ProductVO> searchProduct(String paramString) throws Exception;
  
  List<ReviewVO> bringReviewList(int paramInt) throws Exception;
  
  List<ProductVO> sortedProductLatest(int paramInt) throws Exception;
  
  List<ProductVO> sortedProductRatingHigh(int paramInt) throws Exception;
  
  List<ProductVO> sortedProductRatingLow(int paramInt) throws Exception;
  
  List<ProductVO> sortedSeachingLatest(String paramString) throws Exception;
  
  List<ProductVO> sortedSeachingRatingHigh(String paramString) throws Exception;
  
  List<ProductVO> sortedSeachingRatingLow(String paramString) throws Exception;
}
