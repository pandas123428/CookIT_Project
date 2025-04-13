package com.cookit.admin.product.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.cookit.product.vo.ProductInformVO;
import com.cookit.product.vo.ProductVO;

@Repository("AdminProductDAO")
public class AdminProductDAOImpl  implements AdminProductDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertProduct(ProductVO productVO) throws DataAccessException {
		sqlSession.insert("mapper.admin_product.insertProduct",productVO);
		String product_name = productVO.getProduct_name();
		int product_id = sqlSession.selectOne("mapper.admin_product.selectProductId", product_name);
		return product_id;
	}
	
	@Override
	public int findCategory(String category_name) throws DataAccessException {
		int category_id =sqlSession.selectOne("mapper.admin_product.findCategory", category_name);
		return category_id;
	}
	
	@Override
	public void insertInform(ProductInformVO productInformVO) throws DataAccessException{
		sqlSession.insert("mapper.admin_product.insertInform", productInformVO);
	}
	
	@Override
	public List<ProductVO> selectAllProductList() throws DataAccessException {
		List<ProductVO> productList=sqlSession.selectList("mapper.admin_product.selectAllProductList");
		
		for(int i = 0; i < productList.size(); i++ ) {
			ProductVO productVO = productList.get(i);
			int product_id = productVO.getProduct_id();
			float rating = sqlSession.selectOne("mapper.admin_product.selectProductRating",product_id);
			productVO.setRating(rating);
			
		}	
	   return productList;	
     
	}
	
	@Override
	public void deleteProduct(int product_id) throws DataAccessException {
		sqlSession.delete("mapper.admin_product.deleteProductInform", product_id);
		sqlSession.delete("mapper.admin_product.deleteProduct", product_id);
	};
	
	@Override
	public ProductVO selectProduct(int product_id) throws DataAccessException {
		ProductVO productVO = sqlSession.selectOne("mapper.admin_product.selectProduct", product_id);
		return productVO;
	};
	
	@Override
	public ProductInformVO selectProductInfrom(int product_id) throws DataAccessException {
		ProductInformVO productInformVO =sqlSession.selectOne("mapper.admin_product.selectProductInform", product_id);
		return productInformVO;
	};
	
	@Override
	public int findProductId(String product_name) throws DataAccessException {
		int product_id = sqlSession.selectOne("mapper.admin_product.selectProductId", product_name);
		return product_id;
	};
	
	@Override
	public String selectImageName(int product_id) throws DataAccessException {
		String ImageName = sqlSession.selectOne("mapper.admin_product.selectImageName", product_id);
		return ImageName;
	};

	@Override
	public String selectImageInform(int product_id) throws DataAccessException {
		String ImageInform = sqlSession.selectOne("mapper.admin_product.selectImageInform", product_id);
		return ImageInform;
	};
	
	@Override
	public void updateProduct(ProductVO productVO) throws DataAccessException {
		sqlSession.update("mapper.admin_product.updateProduct", productVO);
	};
	
	@Override
	public void updateProductInform(ProductInformVO productInformVO) throws DataAccessException {
		sqlSession.update("mapper.admin_product.updateProductInform", productInformVO);
	};
}