package com.cookit.admin.inquiry.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.cookit.admin.inquiry.service.AdminInquiryService;
import com.cookit.inquiry.vo.InquiryVO;

@Controller
@RequestMapping("/admin")
public class AdminInquiryControllerImpl implements AdminInquiryController {

    @Autowired
    private AdminInquiryService adminInquiryService;

    @Override
    @RequestMapping("/adminInquiryList.do")
    public ModelAndView adminInquiryList(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("/admin/inquiry/adminInquiryList");
        List<InquiryVO> inquiryList = adminInquiryService.getAllInquiries();
        mav.addObject("inquiryList", inquiryList);
        return mav;
    }

    @Override
    @RequestMapping("/adminInquiryDetail.do")
    public ModelAndView adminInquiryDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int inquiry_id = Integer.parseInt(request.getParameter("id"));
        ModelAndView mav = new ModelAndView("/admin/inquiry/adminInquiryDetail");
        InquiryVO inquiry = adminInquiryService.getInquiryById(inquiry_id);
        mav.addObject("inquiry", inquiry);
        return mav;
    }

    @Override
    @RequestMapping(value = "/submitInquiryAnswer.do", method = RequestMethod.POST)
    public ModelAndView submitInquiryAnswer(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int inquiry_id = Integer.parseInt(request.getParameter("inquiry_id"));
        String answer = request.getParameter("answer_content");

        adminInquiryService.updateInquiryAnswer(inquiry_id, answer);

        return new ModelAndView("redirect:/admin/adminInquiryList.do");
    }
}

