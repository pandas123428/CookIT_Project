package com.cookit.inquiry.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.inquiry.service.InquiryService;
import com.cookit.inquiry.vo.InquiryVO;
import com.cookit.user.vo.UserVO;

@Controller
@RequestMapping("/inquiry")
public class InquiryControllerImpl implements InquiryController {
	
    @Autowired
    private InquiryService inquiryService;

    @RequestMapping(value= "/inquiry.do" ,method={RequestMethod.GET})
    @Override
    public ModelAndView inquiry(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("/inquiry/inquiry");
        return mav;
    }
    
    @RequestMapping(value= "/inquiryDetail.do" ,method={RequestMethod.GET})
    @Override
    public ModelAndView inquiryDetail(@RequestParam("id")int inquiry_id) throws Exception{
    		ModelAndView mav = new ModelAndView("/inquiry/inquiryDetail");
    		
    		InquiryVO inquiry = inquiryService.getInquiryById(inquiry_id);
    		return mav.addObject("inquiry", inquiry);
    	
    }
    
    
    @RequestMapping(value= "/inquiryList.do")
    @Override
    public ModelAndView inquiryList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("/inquiry/inquiryList");

        List<InquiryVO> inquiryList = inquiryService.getAllInquiries();
        mav.addObject("inquiryList", inquiryList);

        return mav;
    }
    
    @RequestMapping(value = "/submitInquiry.do", method = RequestMethod.POST)
    @Override
    public ModelAndView submitInquiry(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Object userObj = session.getAttribute("userInfo"); 

        if (userObj == null) {  
            ModelAndView mav = new ModelAndView("redirect:/user/loginForm"); 
            return mav;
        }

        UserVO user = (UserVO) userObj;
        String user_id = user.getUser_id();

        String inquiry_type = request.getParameter("inquiry_type");
        String inquiry_product = request.getParameter("inquiry_product");
        String inquiry_title = request.getParameter("inquiry_title");
        String inquiry_content = request.getParameter("inquiry_content");

        InquiryVO inquiry = new InquiryVO();
        inquiry.setUser_id(user_id);
        inquiry.setInquiry_type(inquiry_type);
        inquiry.setInquiry_product(inquiry_product);
        inquiry.setInquiry_title(inquiry_title);
        inquiry.setInquiry_content(inquiry_content);

        inquiryService.addInquiry(inquiry);

        ModelAndView mav = new ModelAndView("redirect:/main/main.do");

        return mav;
    }
    
}