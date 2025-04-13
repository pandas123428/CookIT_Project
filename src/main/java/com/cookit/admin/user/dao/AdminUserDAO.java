package com.cookit.admin.user.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.dao.DataAccessException;

import com.cookit.user.vo.UserVO;


public interface AdminUserDAO {
	public ArrayList<UserVO> listUser(HashMap condMap) throws DataAccessException;
	public UserVO userDetail(String user_id) throws DataAccessException;
	public void modifyUserInfo(HashMap userMap) throws DataAccessException;
}
