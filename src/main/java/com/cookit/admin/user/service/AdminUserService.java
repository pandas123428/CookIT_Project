package com.cookit.admin.user.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cookit.user.vo.UserVO;


public interface AdminUserService {
	public ArrayList<UserVO> listUser(HashMap condMap) throws Exception;
	public UserVO userDetail(String user_id) throws Exception;
	public void  modifyUserInfo(HashMap userMap) throws Exception;
}
