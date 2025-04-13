package com.cookit.admin.product.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cookit.product.vo.ProductVO;
import com.cookit.product.vo.ProductInformVO;


public interface AdminProductService {
	public int  addNewProduct(ProductVO productVO) throws Exception;
	public int findCategoryId(String category_name) throws Exception;
	public void insertInform(ProductInformVO productInformVO) throws Exception;
	public List<ProductVO> listAllProduct() throws Exception;
	public void deleteProduct(int product_id) throws Exception;
	public ProductVO oneProduct(int product_id) throws Exception;
	public ProductInformVO oneProductInform(int product_id) throws Exception;
	public int findProductId(String product_name) throws Exception;
	public String findImageName(int product_id) throws Exception;
	public String findImageInform(int product_id) throws Exception;
	public void updateProduct(ProductVO productVO) throws Exception;
	public void updateProductInform(ProductInformVO productInformVO) throws Exception;	
}
