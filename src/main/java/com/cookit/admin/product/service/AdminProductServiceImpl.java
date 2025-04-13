package com.cookit.admin.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.cookit.admin.product.dao.AdminProductDAO;
import com.cookit.product.vo.ProductInformVO;
import com.cookit.product.vo.ProductVO;

@Service("AdminProductService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminProductServiceImpl implements AdminProductService {
	@Autowired
	private AdminProductDAO adminProductDAO;
	
	@Override
	public int addNewProduct(ProductVO productVO) throws Exception{
		int product_id = adminProductDAO.insertProduct(productVO);
		return product_id;
	}
	
	@Override
	public int findCategoryId(String category_name) throws Exception{
		int category_id = adminProductDAO.findCategory(category_name);
		return category_id;
	}
	
	@Override
	public void insertInform(ProductInformVO productInformVO) throws Exception{
		adminProductDAO.insertInform(productInformVO);
	}
	
	@Override
	public List<ProductVO> listAllProduct() throws Exception {
		List<ProductVO> productList=adminProductDAO.selectAllProductList();
		return productList;
	}
	
	@Override
	public void deleteProduct(int product_id) throws Exception {
		adminProductDAO.deleteProduct(product_id);
	};
	
	@Override
	public ProductVO oneProduct(int product_id) throws Exception{
		return adminProductDAO.selectProduct(product_id);
	};
	
	@Override
	public ProductInformVO oneProductInform(int product_id) throws Exception {
		return adminProductDAO.selectProductInfrom(product_id);
	};
	
	@Override
	public int findProductId(String product_name) throws Exception {
		int product_id = adminProductDAO.findProductId(product_name);
		return product_id;
	};
	
	@Override
	public String findImageName(int product_id) throws Exception {
		String ImageName = adminProductDAO.selectImageName(product_id);
		return ImageName;
	};
	
	@Override
	public String findImageInform(int product_id) throws Exception{
		String ImageInform = adminProductDAO.selectImageInform(product_id);
		return ImageInform;
	};
	
	@Override
	public void updateProduct(ProductVO productVO) throws Exception {
		adminProductDAO.updateProduct(productVO);
	};
	
	@Override
	public void updateProductInform(ProductInformVO productInformVO) throws Exception {
		adminProductDAO.updateProductInform(productInformVO);
	};
	
	
//	@Override
//	public ProductVO productDetail(int product_id) throws Exception {
//		productVO productVO=adminproductDAO.selectproductDetail(product_id);
//		List imageFileList =adminproductDAO.selectproductImageFileList(product_id);
//		productMap.put("product", productVO);
//		productMap.put("imageFileList", imageFileList);
//		return productMap;
//	}
	
	
//	
//	@Override
//	public List<productVO> listNewproduct(Map condMap) throws Exception{
//		return adminproductDAO.selectNewproductList(condMap);
//	}
//	@Override
//	public Map productDetail(int product_id) throws Exception {
//		Map productMap = new HashMap();
//		productVO productVO=adminproductDAO.selectproductDetail(product_id);
//		List imageFileList =adminproductDAO.selectproductImageFileList(product_id);
//		productMap.put("product", productVO);
//		productMap.put("imageFileList", imageFileList);
//		return productMap;
//	}
//	@Override
//	public List productImageFile(int product_id) throws Exception{
//		List imageList =adminproductDAO.selectproductImageFileList(product_id);
//		return imageList;
//	}
//	
//	@Override
//	public void modifyproductInfo(Map productMap) throws Exception{
//		adminproductDAO.updateproductInfo(productMap);
//		
//	}	
//	@Override
//	public void modifyproductImage(List<ImageFileVO> imageFileList) throws Exception{
//		adminproductDAO.updateproductImage(imageFileList); 
//	}
//	
//	@Override
//	public List<OrderVO> listOrderproduct(Map condMap) throws Exception{
//		return adminproductDAO.selectOrderproductList(condMap);
//	}
//	@Override
//	public void modifyOrderproduct(Map orderMap) throws Exception{
//		adminproductDAO.updateOrderproduct(orderMap);
//	}
//	
//	@Override
//	public void removeproductImage(int image_id) throws Exception{
//		adminproductDAO.deleteproductImage(image_id);
//	}
//	
//	@Override
//	public void addNewproductImage(List imageFileList) throws Exception{
//		adminproductDAO.insertproductImageFile(imageFileList);
//	}
//	

	
}