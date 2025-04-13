package com.cookit.admin.product.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.admin.product.service.AdminProductService;
import com.cookit.common.base.BaseController;
import com.cookit.product.vo.ProductInformVO;
import com.cookit.product.vo.ProductVO;
import com.cookit.user.vo.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminProductControllerImpl extends BaseController implements AdminProductController {
	private static final String CURR_IMAGE_REPO_PATH = "/pandas13/tomcat/webapps/ROOT/resources/product_image";
	@Autowired
	private AdminProductService adminProductService;

	@Override
	@RequestMapping(value="/goForm.do" ,method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView goForm(
			                 HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		System.out.println("viewName : "+ viewName);
		return mav;
	}
	
	@RequestMapping(value="/productList.do" ,method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView productList(
			                 HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		List<ProductVO> productList= adminProductService.listAllProduct();
		mav.setViewName(viewName);
		mav.addObject("productList", productList);
		System.out.println("viewName : "+ viewName);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/insertProduct.do" ,method = {RequestMethod.POST,RequestMethod.GET})
	public ResponseEntity insertProduct( @ModelAttribute("productVO") ProductVO productVO, @ModelAttribute("productInformVO") ProductInformVO productInformVO,
		MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		String viewName=(String)request.getAttribute("viewName");
		System.out.println("viewName : "+ viewName);
		
		HttpSession session=request.getSession();
		UserVO userVO = new UserVO();
		userVO = (UserVO)session.getAttribute("userInfo");
		String user_id = userVO.getUser_id();
		
		String category_name = request.getParameter("product_category"); 
		int category_id = adminProductService.findCategoryId(category_name);
		ProductVO imageFileList =upload(multipartRequest); 
		String imageName = imageFileList.getProduct_image();
		String imageInform = imageFileList.getProduct_inf_image();

		productVO.setCategory_id(category_id);
 		productVO.setProduct_inf_image(imageInform);
  		productVO.setProduct_image(imageName);
		productVO.setReg_id(user_id);
		int product_id = adminProductService.addNewProduct(productVO);
		productInformVO.setProduct_name(productVO.getProduct_name());
		adminProductService.insertInform(productInformVO);

		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			if(imageFileList!=null) {
				
				File srcFile1 = new File(CURR_IMAGE_REPO_PATH+"/"+"temp"+"/"+imageName);
				File destDir1 = new File(CURR_IMAGE_REPO_PATH+"/"+product_id);
				FileUtils.moveFileToDirectory(srcFile1, destDir1,true);
	
				File srcFile2 = new File(CURR_IMAGE_REPO_PATH+"/"+"temp"+"/"+imageInform);
				File destDir2 = new File(CURR_IMAGE_REPO_PATH+"/"+product_id);
				FileUtils.moveFileToDirectory(srcFile2, destDir2,true);
			}
			message= "<script>";
			message += " alert('상품이 등록 되었습니다.');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/admin/productList.do';";
			message +=("</script>");
		}catch(Exception e) {
			if(imageFileList!=null) {
				File srcFile1 = new File(CURR_IMAGE_REPO_PATH+"/"+"temp"+"/"+imageName);
				File srcFile2 = new File(CURR_IMAGE_REPO_PATH+"/"+"temp"+"/"+imageInform);
				srcFile1.delete();
				srcFile2.delete();				
			}
			
			message= "<script>";
			message += " alert('에러 발생.');";
			message +=" location.href='"+multipartRequest.getContextPath()+"/admin/goForm.do';";
			message +=("</script>");
			e.printStackTrace();
		}
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	@RequestMapping(value="/deleteProduct.do" ,method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView deleteProduct(@RequestParam("product_id") int product_id, 
			@RequestParam("product_inf_image") String product_inf_image,
			@RequestParam("product_image") String product_image,
		   HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView();
		adminProductService.deleteProduct(product_id);

		deleteImage(product_id, product_inf_image);
		deleteImage(product_id, product_image);

		String folderPath = CURR_IMAGE_REPO_PATH + "/" + product_id;
        deleteFolderIfEmpty(new File(folderPath));
		System.out.println("viewName : "+ viewName);
		mav.setViewName("redirect:/admin/productList.do");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/modifyForm.do" ,method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView modifyForm(@RequestParam("product_id") int product_id,
			                 HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ProductVO productVO = new ProductVO();
		ProductInformVO productInformVO = new ProductInformVO();
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName);
		productVO = adminProductService.oneProduct(product_id);
		productInformVO = adminProductService.oneProductInform(product_id);
		mav.addObject("product", productVO);
		mav.addObject("productInform", productInformVO);
		System.out.println("viewName : "+ viewName);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/modifyProduct.do" ,method = {RequestMethod.POST,RequestMethod.GET})
	public ResponseEntity modifyProduct( @ModelAttribute("productVO") ProductVO productVO, @ModelAttribute("productInformVO") ProductInformVO productInformVO,
		MultipartHttpServletRequest multipartRequest, HttpServletRequest request, HttpServletResponse response) throws Exception{
		multipartRequest.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		String viewName=(String)request.getAttribute("viewName");
		System.out.println("viewName : "+ viewName);
		System.out.println(productVO.getProduct_amount());
		System.out.println(productInformVO.getGMO_status());
		String category_name = request.getParameter("product_category"); 
		int category_id = adminProductService.findCategoryId(category_name);
		System.out.println("카테고리 아이디:" + category_id);
		productVO.setCategory_id(category_id);
		productInformVO.setProduct_name(productVO.getProduct_name());
		ProductVO imageFileList =upload(multipartRequest); 
		String imageName = imageFileList.getProduct_image();
		String imageInform = imageFileList.getProduct_inf_image();
		System.out.println(imageName);
		System.out.println(imageInform);

		String product_name = productVO.getProduct_name();
		System.out.println(product_name);
		int product_id = adminProductService.findProductId(product_name);
		productVO.setProduct_id(product_id);
		System.out.println(productVO.getProduct_id());
		String beforeImageName = adminProductService.findImageName(product_id);
		String beforeImageInform = adminProductService.findImageInform(product_id);
		if(!imageName.equals("")) {
			deleteImage(product_id, beforeImageName);
			productVO.setProduct_image(imageName);
			if(imageFileList!=null) {
				File srcFile1 = new File(CURR_IMAGE_REPO_PATH+"/"+"temp"+"/"+imageName);
				File destDir1 = new File(CURR_IMAGE_REPO_PATH+"/"+product_id);
				FileUtils.moveFileToDirectory(srcFile1, destDir1,true);
			}
		}
		else {
			productVO.setProduct_image(beforeImageName);
		}
		if(!imageInform.equals("")) {
			productVO.setProduct_inf_image(imageInform);
			deleteImage(product_id, beforeImageInform);
			if(imageFileList!=null) {
				File srcFile2 = new File(CURR_IMAGE_REPO_PATH+"/"+"temp"+"/"+imageInform);
				File destDir2 = new File(CURR_IMAGE_REPO_PATH+"/"+product_id);
				FileUtils.moveFileToDirectory(srcFile2, destDir2,true);
			}
		}
		else {
			productVO.setProduct_inf_image(beforeImageInform);
		}
		adminProductService.updateProduct(productVO);
		adminProductService.updateProductInform(productInformVO);
		
		ResponseEntity resEntity = null;
		String message = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		message= "<script>";
		message += " alert('상품이 수정되었습니다.');";
		message +=" location.href='"+multipartRequest.getContextPath()+"/admin/productList.do';";
		message +=("</script>");
		
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
		
	 private void deleteFolderIfEmpty(File folder) {
	        if (folder.exists() && folder.isDirectory()) {
	            File[] files = folder.listFiles();
	            if (files == null || files.length == 0) {
	            	folder.delete();
	            } else {
	                System.out.println("파일이 남아있어 삭제에 실패했습니다.: " + folder.getPath());
	            }
	        }
	    }
	 private void deleteImage(int product_id, String fileName) {
		 try{
			File srcFile = new File(CURR_IMAGE_REPO_PATH+"/"+product_id+"/"+fileName);
			srcFile.delete();
			}catch(Exception e) {
			e.printStackTrace();
			}
	 }
	
}