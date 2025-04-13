package com.cookit.inquiry.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;

public interface InquiryController {
    public ModelAndView inquiry(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView submitInquiry(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView inquiryList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView inquiryDetail(int inquiry_id) throws Exception;
}

