package com.cookit.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.cookit.order.vo.OrderVO;


@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public void insertOrderSequence() throws DataAccessException{
		
		sqlSession.insert("mapper.order.insertOrderSequence");
	}	
	
	public int insertOrderHistory(OrderVO orderVO) throws DataAccessException{
		int order_id;
		sqlSession.insert("mapper.order.insertNewOrder_history",orderVO);
		sqlSession.update("mapper.order.addCash_point",orderVO);
		sqlSession.update("mapper.order.subCash_point",orderVO);
		order_id = sqlSession.selectOne("mapper.order.selectOrder_id");
		String order_date = sqlSession.selectOne("mapper.order.selectOrder_date",order_id);
		orderVO.setOrder_date(order_date);
		return order_id;
	}	
	
	public void insertOrderProduct(OrderVO orderVO) throws DataAccessException{
		sqlSession.insert("mapper.order.insertNewOrder_product",orderVO);
		sqlSession.update("mapper.order.subProduct_amount",orderVO);
	}	
	
	public void insertDelivery_address(OrderVO orderVO) throws DataAccessException{
		sqlSession.insert("mapper.order.insertNewDelivery_address",orderVO);
		
	}	
	@Override
	public List<OrderVO> eachOrderList(int order_id)throws DataAccessException{
		List<OrderVO> each_order = sqlSession.selectList("mapper.order.selectOrderList",order_id);
		return each_order;
	}
	
}

