package com.cookit.mypage.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.cookit.order.vo.OrderVO;

public interface MyPageDAO {
	public List<OrderVO> selectMyOrderList(String user_id) throws DataAccessException;

}
