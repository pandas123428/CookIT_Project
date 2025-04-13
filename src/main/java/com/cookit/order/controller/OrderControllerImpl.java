package com.cookit.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.cart.vo.CartVO;
import com.cookit.common.base.BaseController;
import com.cookit.order.service.OrderService;
import com.cookit.order.vo.OrderVO;
import com.cookit.product.service.ProductService;
import com.cookit.product.vo.ProductVO;
import com.cookit.user.dao.UserDAO;
import com.cookit.user.dao.UserDAOImpl;
import com.cookit.user.vo.UserVO;


@Controller("orderController")
@RequestMapping(value="/order")
public class OrderControllerImpl extends BaseController implements OrderController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderVO orderVO;
	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserDAO userDAO;
	
	@Override
	@RequestMapping(value="/orderEachProduct.do" ,method = RequestMethod.POST)
	public ModelAndView orderEachProduct(@ModelAttribute("orderVO") OrderVO _orderVO,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session=request.getSession();
		
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		String action=(String)session.getAttribute("action");

		if(isLogOn==null || isLogOn==false){
			session.setAttribute("orderInfo", _orderVO);
			session.setAttribute("action", "/order/orderEachProduct.do");
			return new ModelAndView("redirect:/user/loginForm.do");
		}else{
			 if(action!=null && action.equals("/order/orderEachProduct.do")){
				orderVO=(OrderVO)session.getAttribute("orderInfo");
				session.removeAttribute("action");
			 }else {
				 orderVO=_orderVO;
			 }
		 }
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		List myOrderList=new ArrayList<OrderVO>();
		myOrderList.add(orderVO);
		UserVO userInfo=(UserVO)session.getAttribute("userInfo");
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", userInfo);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/orderAllCartProduct.do", method = RequestMethod.POST)
	public ModelAndView orderAllCartProduct(@RequestParam("amount") String[] amount,
	                                        HttpServletRequest request, HttpServletResponse response) throws Exception {
	    String viewName = (String) request.getAttribute("viewName");
	    ModelAndView mav = new ModelAndView(viewName);
	    HttpSession session = request.getSession();
	    Map cartMap = (Map) session.getAttribute("cartMap");
	    List<OrderVO> myOrderList = new ArrayList<OrderVO>();
	    List<ProductVO> myProductList = (List<ProductVO>) cartMap.get("myProductList");
	    List<CartVO> myCartList = (List<CartVO>) cartMap.get("myCartList");
	    UserVO userVO = (UserVO) session.getAttribute("userInfo");

	    for (int i = 0; i < amount.length; i++) {
	        String[] cart_product = amount[i].split(":");
	        int orderProductId = Integer.parseInt(cart_product[0]);
	        int orderQuantity = Integer.parseInt(cart_product[1]); // ✅ 변경된 수량 가져오기

	        for (int j = 0; j < myProductList.size(); j++) {
	            ProductVO productVO = myProductList.get(j);
	            if (productVO.getProduct_id() == orderProductId) { // ✅ 주문한 product_id와 일치하는 상품 찾기
	                OrderVO _orderVO = new OrderVO();
	                _orderVO.setProduct_id(orderProductId);
	                _orderVO.setProduct_name(productVO.getProduct_name());
	                _orderVO.setProduct_price(productVO.getPrice());
	                _orderVO.setProduct_image(productVO.getProduct_image());
	                _orderVO.setQuantity(orderQuantity); // ✅ 변경된 수량 반영
	                myOrderList.add(_orderVO);

	                System.out.println("상품 ID: " + orderProductId + ", 주문 수량: " + orderQuantity);
	                break; // 이미 해당 상품을 찾았으므로 더 이상 반복할 필요 없음
	            }
	        }
	    }

	    session.setAttribute("myOrderList", myOrderList);
	    session.setAttribute("orderer", userVO);
	    return mav;
	}

	
	@Override
	@RequestMapping(value="/payToOrderProduct.do" ,method = RequestMethod.POST)
	public ModelAndView payToOrderProduct(@RequestParam Map<String, String> receiverMap,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		UserVO userVO=(UserVO)session.getAttribute("orderer");
		UserVO userInfo = (UserVO) session.getAttribute("userInfo"); 
		String user_id= userVO.getUser_id();

		List<OrderVO> myOrderList=(List<OrderVO>)session.getAttribute("myOrderList");
		
		for(int i=0; i<myOrderList.size();i++){
			int count = myOrderList.size();
			OrderVO orderVO=(OrderVO)myOrderList.get(i);
			
			orderVO.setUser_id(user_id);
			orderVO.setOrder_state("주문완료");
			orderVO.setPayment(receiverMap.get("payment"));
			orderVO.setDelivery_price(Integer.parseInt(receiverMap.get("delivery_price")));
			orderVO.setT_order_price(Integer.parseInt(receiverMap.get("t_order_price")));
			orderVO.setCash_point(Integer.parseInt(receiverMap.get("cash_point")));
			orderVO.setUse_point(Integer.parseInt(receiverMap.get("use_point")));
			orderVO.setOther_discount_price(Integer.parseInt(receiverMap.get("other_discount_price")));
			orderVO.setT_discount_price(Integer.parseInt(receiverMap.get("t_discount_price")));
			orderVO.setF_t_order_price(Integer.parseInt(receiverMap.get("f_t_order_price")));
			int order_id = orderService.addNewOrderHistory(orderVO);
			orderVO.setOrder_id(order_id);
			String each_order_id = order_id + "_";
			System.out.println(count);
			orderVO.setPhone_num(receiverMap.get("phone_num"));
			orderVO.setReceiver_name(receiverMap.get("receiver_name"));
			orderVO.setDesired_delivery_date(receiverMap.get("desired_delivery_date"));
			if(orderVO.getDesired_delivery_date().equals("")) {
				orderVO.setDesired_delivery_date("0");
			}
			orderVO.setDelivery_method(receiverMap.get("delivery_method"));
			orderVO.setRoad_address(receiverMap.get("road_address"));
			orderVO.setNamuji_address(receiverMap.get("namuji_address"));
			orderVO.setZipcode(receiverMap.get("zipcode"));
			if(orderVO.getZipcode().equals("")) {
				orderVO.setZipcode("-");
			}
			orderVO.setDelivery_request(receiverMap.get("delivery_request"));
			if(orderVO.getDelivery_request().equals("")) {
				orderVO.setDelivery_request("없음");
			}
			orderService.addNewDelivery_address(orderVO);

			if(count >= 2) {
				int num = 1;
				for(int j = 0; j < count; j++) {
					OrderVO orderVO_=(OrderVO)myOrderList.get(j);
					orderVO_.setOrder_id(order_id);
					each_order_id += num;
					orderVO_.setEach_order_id(each_order_id);
					int order_price = orderVO_.getProduct_price() * orderVO_.getQuantity();
					orderVO_.setOrder_price(order_price);
					orderService.addNewOrderProduct(orderVO_);
					each_order_id = order_id + "_";
					num ++;
				}
				
			}
			else {
				orderVO.setEach_order_id(each_order_id);
				int order_price = orderVO.getProduct_price() * orderVO.getQuantity();
				orderVO.setOrder_price(order_price);
				orderService.addNewOrderProduct(orderVO);
			}

			myOrderList.set(i, orderVO); 
			break;
		}
		mav.setViewName("redirect:/main/main.do");
		UserVO updatedUser= userDAO.selectUserById(user_id);
		session.setAttribute("userInfo", updatedUser);
		mav.addObject("myOrderInfo",receiverMap);
		mav.addObject("myOrderList", myOrderList);
		return mav;
	}

}
