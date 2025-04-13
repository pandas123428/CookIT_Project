package com.cookit.mypage.service;

import java.util.List;

import com.cookit.order.vo.OrderVO;

public interface MyPageService{
	public List<OrderVO> listMyOrderList(String user_id) throws Exception;

}
