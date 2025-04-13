package com.cookit.user.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cookit.user.vo.UserVO;


public interface UserController {
	public ModelAndView login(@RequestParam Map<String, String> loginMap,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity  addUser(@ModelAttribute("user") UserVO user,
            HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity   overlapped(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView showUpdateForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateUser(UserVO userVO, HttpServletRequest request) throws Exception;
	public ModelAndView updatePassword(UserVO userVO, HttpServletRequest request) throws Exception;
	public ModelAndView deleteUser(String userId, HttpServletRequest request);

}