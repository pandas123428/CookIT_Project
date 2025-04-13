package com.cookit.product.dao;

import com.cookit.product.vo.ProductInformVO;
import com.cookit.product.vo.ProductVO;
import com.cookit.review.vo.ReviewVO;
import java.util.List;
import org.springframework.dao.DataAccessException;

public interface ProductDAO {
  List<ProductVO> selectAllProductList() throws DataAccessException;
  
  ProductVO selectProductDetail(int paramInt) throws DataAccessException;
  
  ProductInformVO selectProductInform(int paramInt) throws DataAccessException;
  
  List<ProductVO> selectRelationProduct(int paramInt) throws DataAccessException;
  
  String selectProductImageName(int paramInt) throws DataAccessException;
  
  List<ProductVO> selectRecommnedProduct(int paramInt) throws DataAccessException;
  
  List<ProductVO> selectNewProduct() throws DataAccessException;
  
  List<ProductVO> selectTwoProductCategory() throws DataAccessException;
  
  List<ProductVO> selectNormalProductCategory(int paramInt) throws DataAccessException;
  
  List<ProductVO> selectSearchProduct(String paramString) throws DataAccessException;
  
  String selectProductName(int paramInt) throws DataAccessException;
  
  List<ReviewVO> selectReviewList(int paramInt) throws DataAccessException;
  
  List<ProductVO> selectSortedProductLatest(int paramInt) throws DataAccessException;
  
  List<ProductVO> selectSortedProductRatingHigh(int paramInt) throws DataAccessException;
  
  List<ProductVO> selectSortedProductRatingLow(int paramInt) throws DataAccessException;
  
  List<ProductVO> selectSortedSeachingLatest(String paramString) throws DataAccessException;
  
  List<ProductVO> selectSortedSeachingRatingHigh(String paramString) throws DataAccessException;
  
  List<ProductVO> selectSortedSeachingRatingLow(String paramString) throws DataAccessException;
}
