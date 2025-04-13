package com.cookit.product.controller;

import com.cookit.product.dao.ProductDAO;
import com.cookit.product.service.ProductService;
import com.cookit.product.vo.ProductInformVO;
import com.cookit.product.vo.ProductVO;
import com.cookit.review.vo.ReviewVO;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping({"/product"})
public class ProductControllerImpl implements ProductController {
  @Autowired
  private ProductService productService;
  
  @Autowired
  private ProductDAO productDAO;
  
  @RequestMapping(value = {"/detailProduct.do"}, method = {RequestMethod.POST, RequestMethod.GET})
  public ModelAndView detailProduct(@RequestParam("product_id") int product_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
    HttpSession session = request.getSession();
    session = request.getSession();
    Boolean isLogOn = (Boolean)session.getAttribute("isLogOn");
    ProductVO productVO = new ProductVO();
    ProductInformVO productInformVO = new ProductInformVO();
    ModelAndView mav = new ModelAndView();
    String viewName = (String)request.getAttribute("viewName");
    System.out.println("viewName : " + viewName);
    productVO = this.productService.detailProduct(product_id);
    productInformVO = this.productService.productInform(product_id);
    productInformVO.setProduct_name(productVO.getProduct_name());
    List<ProductVO> relationProduct = this.productService.relationProduct(product_id);
    List<ReviewVO> reviewList = this.productService.bringReviewList(product_id);
    int rivewList_count = reviewList.size();
    for (ReviewVO review : reviewList) {
      LocalDateTime review_date_ = review.getReviewDate().toLocalDateTime();
      System.out.println(review.getReview_only_date());
      System.out.println(review_date_);
      LocalDate review_date = review_date_.toLocalDate();
      review.setReview_only_date(review_date);
    } 
    Timestamp timestamp = new Timestamp(System.currentTimeMillis());
    long millis = timestamp.getTime();
    System.out.println("Timestamp: " + timestamp);
    mav.setViewName(viewName);
    mav.addObject("reviewList", reviewList);
    mav.addObject("rivewList_count", Integer.valueOf(rivewList_count));
    mav.addObject("product", productVO);
    mav.addObject("isLogOn", isLogOn);
    mav.addObject("relationProduct", relationProduct);
    mav.addObject("productInform", productInformVO);
    return mav;
  }
  
  @RequestMapping(value = {"/productCategory.do"}, method = {RequestMethod.POST, RequestMethod.GET})
  public ModelAndView productCategory(@RequestParam(defaultValue = "0") int sort, @RequestParam("category_id") int category_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
    ProductVO productVO = new ProductVO();
    System.out.println("sort:" + sort);
    ModelAndView mav = new ModelAndView();
    List<ProductVO> productList = new ArrayList<ProductVO>();
    String viewName = (String)request.getAttribute("viewName");
    System.out.println("viewName : " + viewName);
    if (category_id == 0) {
      productList = this.productService.listAllProduct();
      if (sort == 1) {
        productList = this.productService.sortedProductLatest(0);
      } else if (sort == 2) {
        productList = this.productService.sortedProductRatingHigh(0);
      } else if (sort == 3) {
        productList = this.productService.sortedProductRatingLow(0);
      } 
    } else if (category_id == 2) {
      productList = this.productService.twoProductCategory();
      if (sort == 1) {
        productList = this.productService.sortedProductLatest(2);
      } else if (sort == 2) {
        productList = this.productService.sortedProductRatingHigh(2);
      } else if (sort == 3) {
        productList = this.productService.sortedProductRatingLow(2);
      } 
    } else {
      productList = this.productService.normalProductCategory(category_id);
      if (sort == 1) {
        productList = this.productService.sortedProductLatest(category_id);
      } else if (sort == 2) {
        productList = this.productService.sortedProductRatingHigh(category_id);
      } else if (sort == 3) {
        productList = this.productService.sortedProductRatingLow(category_id);
      } 
    } 
    mav.addObject("productList", productList);
    mav.setViewName(viewName);
    return mav;
  }
  
  @RequestMapping(value = {"/searchProduct.do"}, method = {RequestMethod.POST, RequestMethod.GET})
  public ModelAndView searchProduct(@RequestParam(defaultValue = "0") int sort, @RequestParam("searchWord") String searchWord, HttpServletRequest request, HttpServletResponse response) throws Exception {
    ProductVO productVO = new ProductVO();
    System.out.println(searchWord);
    ModelAndView mav = new ModelAndView();
    List<ProductVO> productList = new ArrayList<ProductVO>();
    if (!searchWord.equals("")) {
      productList = this.productService.searchProduct(searchWord);
      if (sort == 1) {
        productList = this.productService.sortedSeachingLatest(searchWord);
      } else if (sort == 2) {
        productList = this.productService.sortedSeachingRatingHigh(searchWord);
      } else if (sort == 3) {
        productList = this.productService.sortedSeachingRatingLow(searchWord);
      } 
    } 
    String viewName = (String)request.getAttribute("viewName");
    System.out.println("viewName : " + viewName);
    mav.setViewName(viewName);
    mav.addObject("searchWord", searchWord);
    mav.addObject("productList", productList);
    return mav;
  }
}
