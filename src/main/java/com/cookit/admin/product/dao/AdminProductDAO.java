package com.cookit.admin.product.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.cookit.product.vo.ProductVO;
import com.cookit.product.vo.ProductInformVO;


public interface AdminProductDAO {
	public int insertProduct(ProductVO productVO) throws DataAccessException;
	public int findCategory(String category_name) throws DataAccessException;
	public void insertInform(ProductInformVO productInformVO) throws DataAccessException;
	public List<ProductVO> selectAllProductList() throws DataAccessException;
	public void deleteProduct(int product_id) throws DataAccessException;
	public ProductVO selectProduct(int product_id) throws DataAccessException;
	public ProductInformVO selectProductInfrom(int product_id) throws DataAccessException;
	public int findProductId(String product_name) throws DataAccessException;
	public String selectImageName(int product_id) throws DataAccessException;
	public String selectImageInform(int product_id) throws DataAccessException;
	public void updateProduct(ProductVO productVO) throws DataAccessException;
	public void updateProductInform(ProductInformVO productInformVO) throws DataAccessException;	
}
