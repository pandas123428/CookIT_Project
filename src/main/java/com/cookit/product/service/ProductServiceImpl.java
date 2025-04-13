package com.cookit.product.service;

import com.cookit.product.dao.ProductDAO;
import com.cookit.product.vo.ProductInformVO;
import com.cookit.product.vo.ProductVO;
import com.cookit.review.vo.ReviewVO;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("ProductService")
@Transactional(propagation = Propagation.REQUIRED)
public class ProductServiceImpl implements ProductService {
  @Autowired
  private ProductDAO productDAO;
  
  public List<ProductVO> listAllProduct() throws Exception {
    List<ProductVO> productList = this.productDAO.selectAllProductList();
    return productList;
  }
  
  public ProductVO detailProduct(int product_id) throws Exception {
    ProductVO productVO = this.productDAO.selectProductDetail(product_id);
    return productVO;
  }
  
  public List<ProductVO> relationProduct(int product_id) throws Exception {
    List<ProductVO> relationProduct = this.productDAO.selectRelationProduct(product_id);
    return relationProduct;
  }
  
  public List<ProductVO> sortedProductLatest(int category_id) throws Exception {
    List<ProductVO> productList = this.productDAO.selectSortedProductLatest(category_id);
    return productList;
  }
  
  public List<ProductVO> sortedProductRatingHigh(int category_id) throws Exception {
    List<ProductVO> productList = this.productDAO.selectSortedProductRatingHigh(category_id);
    return productList;
  }
  
  public List<ProductVO> sortedProductRatingLow(int category_id) throws Exception {
    List<ProductVO> productList = this.productDAO.selectSortedProductRatingLow(category_id);
    return productList;
  }
  
  public ProductInformVO productInform(int product_id) throws Exception {
    ProductInformVO productInformVO = this.productDAO.selectProductInform(product_id);
    return productInformVO;
  }
  
  public List<ProductVO> recommnedProduct(int category_id) throws Exception {
    List<ProductVO> productList = this.productDAO.selectRecommnedProduct(category_id);
    return productList;
  }
  
  public List<ProductVO> newProduct() throws Exception {
    List<ProductVO> newProductList = this.productDAO.selectNewProduct();
    return newProductList;
  }
  
  public List<ProductVO> twoProductCategory() throws Exception {
    List<ProductVO> productList = this.productDAO.selectTwoProductCategory();
    return productList;
  }
  
  public List<ProductVO> normalProductCategory(int category_id) throws Exception {
    List<ProductVO> productList = this.productDAO.selectNormalProductCategory(category_id);
    return productList;
  }
  
  public List<ProductVO> searchProduct(String searchWord) throws Exception {
    List<ProductVO> productList = this.productDAO.selectSearchProduct(searchWord);
    return productList;
  }
  
  public List<ReviewVO> bringReviewList(int product_id) throws Exception {
    List<ReviewVO> reviewList = this.productDAO.selectReviewList(product_id);
    return reviewList;
  }
  
  public List<ProductVO> sortedSeachingLatest(String searchWord) throws Exception {
    List<ProductVO> productList = this.productDAO.selectSortedSeachingLatest(searchWord);
    return productList;
  }
  
  public List<ProductVO> sortedSeachingRatingHigh(String searchWord) throws Exception {
    List<ProductVO> productList = this.productDAO.selectSortedSeachingRatingHigh(searchWord);
    return productList;
  }
  
  public List<ProductVO> sortedSeachingRatingLow(String searchWord) throws Exception {
    List<ProductVO> productList = this.productDAO.selectSortedSeachingRatingLow(searchWord);
    return productList;
  }
}
