package com.cookit.admin.user.service;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.cookit.admin.user.dao.AdminUserDAO;
import com.cookit.user.vo.UserVO;



@Service("adminUserService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminUserServiceImpl implements AdminUserService {
	@Autowired
	private AdminUserDAO adminUserDAO;
	
	public ArrayList<UserVO> listUser(HashMap condMap) throws Exception{
		System.out.println("Conditions: " + condMap); 
		return adminUserDAO.listUser(condMap);
	}

	public UserVO userDetail(String user_id) throws Exception{
		 return adminUserDAO.userDetail(user_id);
	}
	
	public void  modifyUserInfo(HashMap userMap) throws Exception{
		 String user_id=(String)userMap.get("user_id");
		 adminUserDAO.modifyUserInfo(userMap);
	}
}
