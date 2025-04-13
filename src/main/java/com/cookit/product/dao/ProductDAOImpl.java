package com.cookit.product.dao;

import com.cookit.product.vo.ProductInformVO;
import com.cookit.product.vo.ProductVO;
import com.cookit.review.vo.ReviewVO;
import java.util.ArrayList;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository("ProductDAO")
public class ProductDAOImpl implements ProductDAO {
  @Autowired
  private SqlSession sqlSession;
  
  public List<ProductVO> selectAllProductList() throws DataAccessException {
    List<ProductVO> productList = this.sqlSession.selectList("mapper.product.selectAllProductList");
    for (int i = 0; i < productList.size(); i++) {
      ProductVO productVO = productList.get(i);
      int product_id = productVO.getProduct_id();
      float rating = ((Float)this.sqlSession.selectOne("mapper.product.selectProductRating", Integer.valueOf(product_id))).floatValue();
      productVO.setRating(rating);
    } 
    return productList;
  }
  
  public ProductVO selectProductDetail(int product_id) throws DataAccessException {
    ProductVO productVO = new ProductVO();
    productVO = (ProductVO)this.sqlSession.selectOne("mapper.product.selectProductDetail", Integer.valueOf(product_id));
    float rating = ((Float)this.sqlSession.selectOne("mapper.product.selectProductRating", Integer.valueOf(product_id))).floatValue();
    productVO.setRating(rating);
    return productVO;
  }
  
  public List<ProductVO> selectRelationProduct(int product_id) throws DataAccessException {
    List<ProductVO> relationProduct = this.sqlSession.selectList("mapper.product.selectRelationProduct", Integer.valueOf(product_id));
    for (int i = 0; i < relationProduct.size(); i++) {
      ProductVO productVO = relationProduct.get(i);
      int product_id_ = productVO.getProduct_id();
      float rating = ((Float)this.sqlSession.selectOne("mapper.product.selectProductRating", Integer.valueOf(product_id_))).floatValue();
      productVO.setRating(rating);
    } 
    return relationProduct;
  }
  
  public String selectProductImageName(int product_id) throws DataAccessException {
    String product_image = (String)this.sqlSession.selectOne("mapper.product.selectProductImageName", Integer.valueOf(product_id));
    return product_image;
  }
  
  public ProductInformVO selectProductInform(int product_id) throws DataAccessException {
    ProductInformVO productInformVO = new ProductInformVO();
    productInformVO = (ProductInformVO)this.sqlSession.selectOne("mapper.product.selectProductInform", Integer.valueOf(product_id));
    return productInformVO;
  }
  
  public List<ProductVO> selectRecommnedProduct(int category_id) throws DataAccessException {
    List<ProductVO> ProductList = this.sqlSession.selectList("mapper.product.selectRecommnedProduct", Integer.valueOf(category_id));
    for (int i = 0; i < ProductList.size(); i++) {
      ProductVO productVO = ProductList.get(i);
      int product_id = productVO.getProduct_id();
      float rating = ((Float)this.sqlSession.selectOne("mapper.product.selectProductRating", Integer.valueOf(product_id))).floatValue();
      productVO.setRating(rating);
    } 
    return ProductList;
  }
  
  public List<ProductVO> selectNewProduct() throws DataAccessException {
    List<ProductVO> newProductList = this.sqlSession.selectList("mapper.product.selectNewProduct");
    for (int i = 0; i < newProductList.size(); i++) {
      ProductVO productVO = newProductList.get(i);
      int product_id = productVO.getProduct_id();
      float rating = ((Float)this.sqlSession.selectOne("mapper.product.selectProductRating", Integer.valueOf(product_id))).floatValue();
      productVO.setRating(rating);
    } 
    return newProductList;
  }
  
  public List<ProductVO> selectTwoProductCategory() throws DataAccessException {
    List<ProductVO> ProductList = this.sqlSession.selectList("mapper.product.selectTwoProductCategory");
    for (int i = 0; i < ProductList.size(); i++) {
      ProductVO productVO = ProductList.get(i);
      int product_id = productVO.getProduct_id();
      float rating = ((Float)this.sqlSession.selectOne("mapper.product.selectProductRating", Integer.valueOf(product_id))).floatValue();
      productVO.setRating(rating);
    } 
    return ProductList;
  }
  
  public List<ProductVO> selectNormalProductCategory(int category_id) throws DataAccessException {
    List<ProductVO> ProductList = this.sqlSession.selectList("mapper.product.selectNormalProductCategory", Integer.valueOf(category_id));
    for (int i = 0; i < ProductList.size(); i++) {
      ProductVO productVO = ProductList.get(i);
      int product_id = productVO.getProduct_id();
      float rating = ((Float)this.sqlSession.selectOne("mapper.product.selectProductRating", Integer.valueOf(product_id))).floatValue();
      productVO.setRating(rating);
    } 
    return ProductList;
  }
  
  public List<ProductVO> selectSearchProduct(String searchWord) throws DataAccessException {
    List<ProductVO> ProductList = this.sqlSession.selectList("mapper.product.selectSearchProduct", searchWord);
    for (int i = 0; i < ProductList.size(); i++) {
      ProductVO productVO = ProductList.get(i);
      int product_id = productVO.getProduct_id();
      float rating = ((Float)this.sqlSession.selectOne("mapper.product.selectProductRating", Integer.valueOf(product_id))).floatValue();
      productVO.setRating(rating);
    } 
    return ProductList;
  }
  
  public String selectProductName(int product_id) throws DataAccessException {
    String product_name = (String)this.sqlSession.selectOne("mapper.product.selectProductName", Integer.valueOf(product_id));
    return product_name;
  }
  
  public List<ReviewVO> selectReviewList(int product_id) throws DataAccessException {
    List<ReviewVO> reviewList = this.sqlSession.selectList("mapper.product.selectReviewList", Integer.valueOf(product_id));
    return reviewList;
  }
  
  public List<ProductVO> selectSortedProductLatest(int category_id) throws DataAccessException {
    List<ProductVO> productList = new ArrayList<ProductVO>();
    if (category_id == 0) {
      productList = this.sqlSession.selectList("mapper.product.selectSortedProductLatestAll");
      return productList;
    } 
    if (category_id == 2) {
      productList = this.sqlSession.selectList("mapper.product.selectSortedProductLatestTwo");
      return productList;
    } 
    productList = this.sqlSession.selectList("mapper.product.selectSortedProductLatest", Integer.valueOf(category_id));
    return productList;
  }
  
  public List<ProductVO> selectSortedProductRatingHigh(int category_id) throws DataAccessException {
    List<ProductVO> productList = new ArrayList<ProductVO>();
    if (category_id == 0) {
      productList = this.sqlSession.selectList("mapper.product.selectSortedProductRatingHighAll");
      return productList;
    } 
    if (category_id == 2) {
      productList = this.sqlSession.selectList("mapper.product.selectSortedProductRatingHighTwo");
      return productList;
    } 
    productList = this.sqlSession.selectList("mapper.product.selectSortedProductRatingHigh", Integer.valueOf(category_id));
    return productList;
  }
  
  public List<ProductVO> selectSortedProductRatingLow(int category_id) throws DataAccessException {
    List<ProductVO> productList = new ArrayList<ProductVO>();
    if (category_id == 0) {
      productList = this.sqlSession.selectList("mapper.product.selectSortedProductRatingLowAll");
      return productList;
    } 
    if (category_id == 2) {
      productList = this.sqlSession.selectList("mapper.product.selectSortedProductRatingLowTwo");
      return productList;
    } 
    productList = this.sqlSession.selectList("mapper.product.selectSortedProductRatingLow", Integer.valueOf(category_id));
    return productList;
  }
  
  public List<ProductVO> selectSortedSeachingLatest(String searchWord) throws DataAccessException {
    List<ProductVO> ProductList = this.sqlSession.selectList("mapper.product.selectSortedSeachingLatest", searchWord);
    return ProductList;
  }
  
  public List<ProductVO> selectSortedSeachingRatingHigh(String searchWord) throws DataAccessException {
    List<ProductVO> ProductList = this.sqlSession.selectList("mapper.product.selectSortedSeachingRatingHigh", searchWord);
    return ProductList;
  }
  
  public List<ProductVO> selectSortedSeachingRatingLow(String searchWord) throws DataAccessException {
    List<ProductVO> ProductList = this.sqlSession.selectList("mapper.product.selectSortedSeachingRatingLow", searchWord);
    return ProductList;
  }
}
