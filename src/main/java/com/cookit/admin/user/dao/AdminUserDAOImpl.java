package com.cookit.admin.user.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.cookit.user.vo.UserVO;


@Repository("adminUserDao")
public class AdminUserDAOImpl  implements AdminUserDAO{
	@Autowired
	private SqlSession sqlSession;
	

	public ArrayList<UserVO> listUser(HashMap condMap) throws DataAccessException{
		ArrayList<UserVO>  userList=(ArrayList)sqlSession.selectList("mapper.admin_user.listUser",condMap);
		return userList;
	}
	
	public UserVO userDetail(String user_id) throws DataAccessException{
		UserVO userBean=(UserVO)sqlSession.selectOne("mapper.admin_user.userDetail",user_id);
		return userBean;
	}
	
	public void modifyUserInfo(HashMap userMap) throws DataAccessException{
		sqlSession.update("mapper.admin_user.modifyUserInfo",userMap);
	}


}
