package com.cookit.faq.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cookit.faq.service.FaqService;
import com.cookit.faq.vo.FaqVO;

@RestController
@RequestMapping("/faq")
public class FaqController {

    @Autowired
    private FaqService faqService;

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public List<FaqVO> searchFAQ(@RequestParam("keyword") String keyword) throws Exception {
        return faqService.searchFAQ(keyword);
    }
}


