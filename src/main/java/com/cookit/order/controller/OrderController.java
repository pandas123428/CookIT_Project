package com.cookit.order.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.order.vo.OrderVO;

public interface OrderController {
	public ModelAndView orderEachProduct(@ModelAttribute("orderVO") OrderVO _orderVO,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView orderAllCartProduct(@RequestParam("amount")  String[] amount,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView payToOrderProduct(@RequestParam Map<String, String> orderMap,HttpServletRequest request, HttpServletResponse response)  throws Exception;
}

