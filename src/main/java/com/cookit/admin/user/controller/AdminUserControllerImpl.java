package com.cookit.admin.user.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.admin.user.service.AdminUserService;
import com.cookit.common.base.BaseController;
import com.cookit.user.vo.UserVO;


@Controller("adminUserController")
@RequestMapping(value="/adminUser")
public class AdminUserControllerImpl extends BaseController  implements AdminUserController{
	@Autowired
	private AdminUserService adminUserService;
	
	@RequestMapping(value="/adminUserMain.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView adminUserMain(@RequestParam Map<String, String> dateMap,
			                           HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		System.out.println("viewName : " + viewName);
		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		String section = dateMap.get("section");
		String pageNum = dateMap.get("pageNum");
		String beginDate=null,endDate=null;
		
		String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);
		
		
		HashMap<String,Object> condMap=new HashMap<String,Object>();
		if(section== null) {
			section = "1";
		}
		condMap.put("section",section);
		if(pageNum== null) {
			pageNum = "1";
		}
		condMap.put("pageNum",pageNum);
		condMap.put("beginDate",beginDate);
		condMap.put("endDate", endDate);
		ArrayList<UserVO> user_list=adminUserService.listUser(condMap);
		mav.addObject("user_list", user_list);
		
		String beginDate1[]=beginDate.split("-");
		String endDate2[]=endDate.split("-");
		mav.addObject("beginYear",beginDate1[0]);
		mav.addObject("beginMonth",beginDate1[1]);
		mav.addObject("beginDay",beginDate1[2]);
		mav.addObject("endYear",endDate2[0]);
		mav.addObject("endMonth",endDate2[1]);
		mav.addObject("endDay",endDate2[2]);
		
		mav.addObject("section", section);
		mav.addObject("pageNum", pageNum);
		return mav;
		
	}
	@RequestMapping(value="/userDetail.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView userDetail(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		String user_id=request.getParameter("user_id");
		UserVO user_info=adminUserService.userDetail(user_id);
		mav.addObject("user_info",user_info);
		return mav;
	}
	
	@RequestMapping(value="/modifyUserInfo.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public void modifyUserInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HashMap<String,String> userMap=new HashMap<String,String>();
		String val[]=null;
		PrintWriter pw=response.getWriter();
		String user_id=request.getParameter("user_id");
		String mod_type=request.getParameter("mod_type");
		String value =request.getParameter("value");
		if(mod_type.equals("user_birth")){
			val=value.split(",");
			userMap.put("user_birth_y",val[0]);
			userMap.put("user_birth_m",val[1]);
			userMap.put("user_birth_d",val[2]);
			userMap.put("user_birth_gn",val[3]);
		}else if(mod_type.equals("tel")){
			val=value.split(",");
			userMap.put("tel1",val[0]);
			userMap.put("tel2",val[1]);
			userMap.put("tel3",val[2]);
			
		}else if(mod_type.equals("hp")){
			val=value.split(",");
			userMap.put("hp1",val[0]);
			userMap.put("hp2",val[1]);
			userMap.put("hp3",val[2]);
			userMap.put("smssts_yn", val[3]);
		}else if(mod_type.equals("email")){
			val=value.split(",");
			userMap.put("email1",val[0]);
			userMap.put("email2",val[1]);
			userMap.put("emailsts_yn", val[2]);
		}else if(mod_type.equals("address")){
			val=value.split(",");
			userMap.put("zipcode",val[0]);
			userMap.put("roadAddress",val[1]);
			userMap.put("jibunAddress", val[2]);
			userMap.put("namujiAddress", val[3]);
		}
		
		userMap.put("user_id", user_id);
		
		adminUserService.modifyUserInfo(userMap);
		pw.print("mod_success");
		pw.close();		
		
	}
	
	@RequestMapping(value="/deleteUser.do" ,method={RequestMethod.POST})
	public ModelAndView deleteUser(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView();
		HashMap<String,String> userMap=new HashMap<String,String>();
		String user_id=request.getParameter("user_id");
		String del_yn=request.getParameter("del_yn");
		userMap.put("del_yn", del_yn);
		userMap.put("user_id", user_id);
		
		adminUserService.modifyUserInfo(userMap);
		mav.setViewName("redirect:/admin/user/adminUserMain.do");
		return mav;
		
	}

		
}
