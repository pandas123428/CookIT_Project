package com.cookit.order.service;

import java.util.List;

import com.cookit.order.vo.OrderVO;


public interface OrderService {
	public int addNewOrderHistory(OrderVO orderVO) throws Exception;
	public void addNewOrderProduct(OrderVO orderVO) throws Exception;
	public void addNewDelivery_address(OrderVO orderVO) throws Exception;	
}
