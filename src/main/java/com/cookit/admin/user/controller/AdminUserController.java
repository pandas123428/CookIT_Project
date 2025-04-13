package com.cookit.admin.user.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


public interface AdminUserController {
	public ModelAndView adminUserMain(@RequestParam Map<String, String> dateMap,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView userDetail(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public void modifyUserInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView deleteUser(HttpServletRequest request, HttpServletResponse response)  throws Exception;
}
