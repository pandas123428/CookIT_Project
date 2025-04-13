package com.cookit.main;

import java.util.Arrays;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.common.base.BaseController;
import com.cookit.product.service.ProductService;
import com.cookit.product.vo.ProductVO;
import com.cookit.user.vo.UserVO;

@Controller("mainController")
public class MainController extends BaseController{
	@Autowired
	private ProductService productService;
	
	@RequestMapping(value= "/main/main.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception{
		Random random = new Random();
		String userId = "";
		String viewName=(String)request.getAttribute("viewName");
        HttpSession session = request.getSession();
        UserVO userInfo = (UserVO) session.getAttribute("userInfo");
    	ModelAndView mav=new ModelAndView();
        if (userInfo != null) {
        	userId = userInfo.getUser_id();
        	RestTemplate restTemplate = new RestTemplate();
    		String p_url = "http://gksdnf2920.pythonanywhere.com/api/recommend/"+ userId;
    		try {
    	        ResponseEntity<ProductVO[]> result = restTemplate.getForEntity(p_url, ProductVO[].class);
    	        ProductVO[] products = result.getBody();
    	        List<ProductVO> res_productList = Arrays.asList(products);
    	        mav.addObject("recommendProduct", res_productList);
    		} catch(Exception e) {
    			e.printStackTrace();
    		
    		}
        }
        else {	
			int category_id = random.nextInt(6) + 1;
			List<ProductVO> productList = productService.recommnedProduct(category_id);	
			mav.addObject("recommendProduct", productList);
        }
        
		List<ProductVO> newProductList = productService.newProduct();
		mav.addObject("newProduct", newProductList);		
		mav.setViewName(viewName);
		mav.addObject("viewName", viewName);
		System.out.println("viewName : "+ viewName);
		return mav;
	}
}
