package com.cookit.aiConn.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface AiController {
	
	public ModelAndView fetchData() throws Exception;

}
