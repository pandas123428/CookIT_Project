package com.cookit.service.center.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.common.base.BaseController;
import com.cookit.mypage.vo.MyPageVO;
import com.cookit.user.vo.UserVO;

@Controller
@RequestMapping(value = "/service")
public class ServiceCenterImpl {
	
	@RequestMapping(value= "/center.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav=new ModelAndView();		
		mav.setViewName(viewName);
		System.out.println("viewName : "+ viewName);
		return mav;
	}
		
    @RequestMapping(value = "/checkLogin", method = RequestMethod.GET)
    public void checkLogin(HttpSession session, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        UserVO user = (UserVO) session.getAttribute("userInfo"); 
        boolean isLoggedIn = (user != null);

        out.print("{\"isLoggedIn\": " + isLoggedIn + "}");
        out.flush();
    }

    @RequestMapping(value = "/user/saveRedirectUrl", method = RequestMethod.GET)
    public void saveRedirectUrl(@RequestParam("url") String url, HttpSession session, HttpServletResponse response) throws IOException {
        session.setAttribute("redirectUrl", url);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"message\": \"URL saved successfully\"}");
        out.flush();
    }
    
	@RequestMapping(value= "/faq.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView faq(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav=new ModelAndView();		
		mav.setViewName(viewName);
		System.out.println("viewName : "+ viewName);
		return mav;
	}
	
	@RequestMapping(value= "/faq2.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView faq2(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav=new ModelAndView();		
		mav.setViewName(viewName);
		System.out.println("viewName : "+ viewName);
		return mav;
	}
	
	@RequestMapping(value= "/guide.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView guide(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav=new ModelAndView();		
		mav.setViewName(viewName);
		System.out.println("viewName : "+ viewName);
		return mav;
	}
	
	@RequestMapping(value= "/notice.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView notice(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav=new ModelAndView();		
		mav.setViewName(viewName);
		System.out.println("viewName : "+ viewName);
		return mav;
	}
	
	@RequestMapping(value= "/notice_view.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView notice_view(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav=new ModelAndView();		
		mav.setViewName(viewName);
		System.out.println("viewName : "+ viewName);
		return mav;
	}
	
	@RequestMapping(value= "/delivery" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView delivery(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav=new ModelAndView();		
		mav.setViewName(viewName);
		System.out.println("viewName : "+ viewName);
		return mav;
	}
	
}
