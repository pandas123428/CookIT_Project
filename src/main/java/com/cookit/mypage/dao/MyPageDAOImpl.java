package com.cookit.mypage.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.cookit.order.vo.OrderVO;

@Repository("myPageDAO")
public class MyPageDAOImpl implements MyPageDAO{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<OrderVO> selectMyOrderList(String user_id) throws DataAccessException{
		List<OrderVO> myOrderList= sqlSession.selectList("mapper.mypage.selectMyOrderList",user_id);
		return myOrderList;
	}
	
}
