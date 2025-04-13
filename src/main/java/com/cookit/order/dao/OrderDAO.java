package com.cookit.order.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.cookit.order.vo.OrderVO;



public interface OrderDAO {
//	  public List<OrderVO> listMyOrderGoods(OrderVO orderBean) throws DataAccessException;
	  public int insertOrderHistory(OrderVO orderVO) throws DataAccessException;
	  public void insertOrderProduct(OrderVO orderVO) throws DataAccessException;
	  public void insertDelivery_address(OrderVO orderVO) throws DataAccessException;
	  public List<OrderVO> eachOrderList(int order_id)throws DataAccessException;
//	  public void insertOrderSequence() throws DataAccessException;
//	  public OrderVO findMyOrder(String order_id) throws DataAccessException;
//	  public void removeGoodsFromCart(List<OrderVO>myOrderList)throws DataAccessException;
	 
}
