package com.cookit.product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface ProductController {
  ModelAndView detailProduct(@RequestParam("product_id") int paramInt, HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws Exception;
  
  ModelAndView productCategory(@RequestParam(defaultValue = "1") int paramInt1, @RequestParam("category_id") int paramInt2, HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws Exception;
  
  ModelAndView searchProduct(@RequestParam(defaultValue = "0") int paramInt, @RequestParam("searchWord") String paramString, HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws Exception;
}
