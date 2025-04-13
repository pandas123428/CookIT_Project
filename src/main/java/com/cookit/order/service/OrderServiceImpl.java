package com.cookit.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.cookit.order.dao.OrderDAO;
import com.cookit.order.vo.OrderVO;


@Service("orderService")
@Transactional(propagation=Propagation.REQUIRED)
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderDAO orderDAO;
//	
//	public List<OrderVO> listMyOrderGoods(OrderVO orderVO) throws Exception{
//		List<OrderVO> orderGoodsList;
//		orderGoodsList=orderDAO.listMyOrderProduct(orderVO);
//		return orderGoodsList;
//	}
	
	public int addNewOrderHistory(OrderVO orderVO) throws Exception{
		int order_id = orderDAO.insertOrderHistory(orderVO);
		return order_id;
//		orderDAO.insertOrderSequence();
		//카트에서 주문 상품 제거한다.
//		orderDAO.removeProductFromCart(myOrderList);
	}	
	
	public void addNewOrderProduct(OrderVO orderVO) throws Exception{
		orderDAO.insertOrderProduct(orderVO);
	}	
	
	public void addNewDelivery_address(OrderVO orderVO) throws Exception{
		orderDAO.insertDelivery_address(orderVO);
	}	
	
}

