package com.cookit.user.service;

import java.util.Map;

import com.cookit.user.vo.UserVO;

public interface UserService {
	public UserVO login(Map  loginMap) throws Exception;
	public void addUser(UserVO memberVO) throws Exception;
	public String overlapped(String id) throws Exception;
	public UserVO getUserInfo(String userId);
    public UserVO getUserById(String userId) throws Exception;
    public void updateUser(UserVO userVO) throws Exception;
	public void updatePassword(UserVO loggedInUser) throws Exception; 
    public void insertNaverUser(UserVO userVO) throws Exception;
    public boolean isNaverUserExists(String userId) throws Exception;
    public void updateNaverUser(UserVO userVO) throws Exception;
    public void deleteUser(String userId) throws Exception;
}