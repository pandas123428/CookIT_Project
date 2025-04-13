package com.cookit.cart.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.eclipse.core.internal.runtime.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.cart.service.CartService;
import com.cookit.cart.vo.CartVO;
import com.cookit.common.base.BaseController;
import com.cookit.user.vo.UserVO;



@Controller("cartController")
@RequestMapping(value="/cart")
public class CartControllerImpl extends BaseController implements CartController{
	@Autowired
	private CartService cartService;
	@Autowired
	private CartVO cartVO;
	@Autowired
	private UserVO userVO;
	

	
	@RequestMapping(value="/myCartList.do" ,method = RequestMethod.GET)
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		UserVO userVO=(UserVO)session.getAttribute("userInfo");
		String User_id=userVO.getUser_id();
		cartVO.setUser_id(User_id);
		Map<String ,List> cartMap=cartService.myCartList(cartVO);
		session.setAttribute("cartMap", cartMap);//장바구니 목록 화면에서 상품 주문 시 사용하기 위해서 장바구니 목록을 세션에 저장한다.
		//mav.addObject("cartMap", cartMap);
		return mav;
	}

	
	@RequestMapping(value = "/addProductInCart.do", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public @ResponseBody String addProductInCart(@RequestParam("product_id") int product_id,
												 @RequestParam("amount") int amount,
	                                             HttpServletRequest request, HttpServletResponse response) throws Exception {
	    HttpSession session = request.getSession();
	    userVO = (UserVO) session.getAttribute("userInfo");
	    
	    if (userVO == null) {
	        return "not_logged_in"; // 로그인되지 않은 경우
	    }

	    String user_id = userVO.getUser_id();
	    cartVO.setUser_id(user_id);
	    cartVO.setProduct_id(product_id);
	    cartVO.setAmount(amount);

	    boolean isAreadyExisted = cartService.findCartProduct(cartVO);
	    if (isAreadyExisted) {
	        return "already_existed";
	    } else {
	        cartService.addProductInCart(cartVO);
	        return "add_success";
	    }
	}
	
	@Override
	@RequestMapping(value="/modifyCartQty.do", method = RequestMethod.POST)
	public @ResponseBody String modifyCartQty(
	        @RequestParam("product_id") int product_id,
	        @RequestParam("amount") int amount,
	        HttpServletRequest request) throws Exception {

	    HttpSession session = request.getSession();
	    UserVO userVO = (UserVO) session.getAttribute("userInfo");

	    if (userVO == null) {
	        return "{\"status\":\"modify_failed\"}";
	    }

	    String user_id = userVO.getUser_id();
	    CartVO cartVO = new CartVO();
	    cartVO.setProduct_id(product_id);
	    cartVO.setUser_id(user_id);
	    cartVO.setAmount(amount);

	    boolean result = cartService.modifyCartQty(cartVO);

	    // 직접 JSON 형식의 문자열 반환
	    return "{\"status\":\"" + (result ? "modify_success" : "modify_failed") + "\"}";
	}
	
	@Override
	@RequestMapping(value="/removeCartProduct.do" ,method = RequestMethod.POST)
	public ModelAndView removeCartProduct(@RequestParam("cart_id") int cart_id,
			                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
		ModelAndView mav=new ModelAndView();
		cartService.removeCartProduct(cart_id);
		mav.setViewName("redirect:/cart/myCartList.do");
		return mav;
	}


}
