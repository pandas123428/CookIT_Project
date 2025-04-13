package com.cookit.user.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.cookit.user.vo.UserVO;

public interface UserDAO {
	public UserVO login(Map loginMap) throws DataAccessException;
	public void insertNewUser(UserVO userVO) throws DataAccessException;
	public String selectOverlappedID(String id) throws DataAccessException;
	public UserVO selectUserInfo(String userId);
    public UserVO selectUserById(String userId) throws Exception;
    public void updateUser(UserVO userVO) throws Exception;
	public void updatePassword(UserVO userVO) throws Exception;
	public void insertNaverUser(UserVO userVO) throws Exception;	
	public UserVO selectNaverUserById(String userId) throws Exception;
	public void updateNaverUser(UserVO userVO) throws Exception;
	public void deleteUser(String userId) throws DataAccessException;
}