package com.cookit.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.cookit.mypage.dao.MyPageDAO;
import com.cookit.order.vo.OrderVO;

@Service("MyPageService")
@Transactional(propagation=Propagation.REQUIRED)
public class MyPageServiceImpl  implements MyPageService{
	@Autowired
	private MyPageDAO myPageDAO;

	@Override
	public List<OrderVO> listMyOrderList(String user_id) throws Exception{
		return myPageDAO.selectMyOrderList(user_id);
	}
}
