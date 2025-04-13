package com.cookit.admin.inquiry.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;

public interface AdminInquiryController {
	ModelAndView adminInquiryList(HttpServletRequest request, HttpServletResponse response) throws Exception;
    ModelAndView adminInquiryDetail(HttpServletRequest request, HttpServletResponse response) throws Exception;
    ModelAndView submitInquiryAnswer(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
