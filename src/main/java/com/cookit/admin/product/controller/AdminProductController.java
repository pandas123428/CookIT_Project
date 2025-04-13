package com.cookit.admin.product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.product.vo.ProductInformVO;
import com.cookit.product.vo.ProductVO;


public interface AdminProductController {
//	public ModelAndView productDetail(@RequestParam("product_id") String product_id,HttpServletRequest request, HttpServletResponse response) throws Exception;
//	public @ResponseBody String keywordSearch(@RequestParam("keyword") String keyword,HttpServletRequest request, HttpServletResponse response) throws Exception;
//	public ModelAndView searchProduct(@RequestParam("searchWord") String searchWord,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView goForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity insertProduct(@ModelAttribute("productVO") ProductVO _productVO, @ModelAttribute("productInformVO") ProductInformVO _productInformVO,
	         MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView deleteProduct(@RequestParam("product_id") int product_id, @RequestParam("product_inf_image") String product_inf_image,
			@RequestParam("product_image") String product_image,
			HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView modifyForm(@RequestParam("product_id") int product_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity modifyProduct(@ModelAttribute("productVO") ProductVO _productVO, @ModelAttribute("productInformVO") ProductInformVO _productInformVO,
	         MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception;
//	public ModelAndView updateProduct(@RequestParam("product_id") int product_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
}