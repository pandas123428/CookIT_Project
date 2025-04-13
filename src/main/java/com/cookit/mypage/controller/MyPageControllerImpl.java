package com.cookit.mypage.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.common.base.BaseController;
import com.cookit.mypage.service.MyPageService;
import com.cookit.order.dao.OrderDAO;
import com.cookit.order.vo.OrderVO;
import com.cookit.product.dao.ProductDAO;
import com.cookit.user.service.UserService;
import com.cookit.user.vo.UserVO;

@Controller

@RequestMapping(value = "/mypage")
public class MyPageControllerImpl extends BaseController implements MyPageController {
	
	@Autowired
    private UserService userService;
	
	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private UserVO userVO;
	
	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private OrderDAO orderDAO;
//	@Override
//	@RequestMapping(value = "/myPageMain.do", method = { RequestMethod.POST, RequestMethod.GET })
//	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
//	    HttpSession session = request.getSession();
//	    UserVO userInfo = (UserVO) session.getAttribute("userInfo"); // 세션에서 사용자 정보 가져오기
//
//	    ModelAndView mav = new ModelAndView();
//	    String viewName = (String) request.getAttribute("viewName");
//	    mav.setViewName(viewName);
//
//	    if (userInfo != null) {
//	        mav.addObject("userInfo", userInfo); // 모델에 사용자 정보 추가
//	    }
//
//	    System.out.println("viewName : " + viewName);
//	    return mav;
//	}

	@Override
	@RequestMapping(value = "/myPageMain.do", method = RequestMethod.GET )
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response)  throws Exception{

		HttpSession session = request.getSession();
	    UserVO userInfo = (UserVO) session.getAttribute("userInfo"); // 세션에서 사용자 정보 가져오기
	    ModelAndView mav = new ModelAndView();
	    String viewName = (String) request.getAttribute("viewName");
	    String user_id = userInfo.getUser_id();
		List<OrderVO> myOrderList= myPageService.listMyOrderList(user_id);
	    mav.setViewName(viewName);
	    mav.addObject("userInfo", userInfo);
		session.setAttribute("myOrderList", myOrderList);
	    System.out.println("viewName : " + viewName);
	    return mav;
	}
	
	@Override
	@RequestMapping(value="/orderDetail.do" ,method = RequestMethod.GET)
	public ModelAndView orderDetail(@RequestParam Map<String, String> receiverMap,
			HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		userVO = (UserVO)session.getAttribute("userInfo");
		List<OrderVO> myOrderList = (List<OrderVO>)session.getAttribute("myOrderList");
		
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO=(OrderVO)myOrderList.get(i);
			int order_id = orderVO.getOrder_id();
			List <OrderVO> each_orderList =orderDAO.eachOrderList(order_id);
		
			for(int j=0; j<each_orderList.size(); j++) {
				OrderVO each_order=(OrderVO)each_orderList.get(j);
				int product_id = each_order.getProduct_id();
				String product_image = productDAO.selectProductImageName(product_id);
				each_order.setProduct_image(product_image);
				String product_name = productDAO.selectProductName(product_id);
				each_order.setProduct_name(product_name);
			}
			orderVO.setEach_orderList(each_orderList);
		}
		mav.addObject("myOrderList", myOrderList);
		System.out.println("viewName : " + viewName);
		return mav;
	}	

}
 