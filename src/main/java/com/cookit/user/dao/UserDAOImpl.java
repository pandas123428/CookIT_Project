package com.cookit.user.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import com.cookit.user.vo.UserVO;

@Repository("userDAO")
public class UserDAOImpl  implements UserDAO{
	@Autowired
	private SqlSession sqlSession;	
	
	@Override
	public UserVO login(Map loginMap) throws DataAccessException{
		UserVO user=(UserVO)sqlSession.selectOne("mapper.user.login",loginMap);
	   return user;
	}
	
	@Override
	public void insertNewUser(UserVO userVO) throws DataAccessException{
		sqlSession.insert("mapper.user.insertNewUser",userVO);
	}

	@Override
	public String selectOverlappedID(String id) throws DataAccessException {
		String result =  sqlSession.selectOne("mapper.user.selectOverlappedID",id);
		return result;
	}

	@Override
	public UserVO selectUserInfo(String userId) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public UserVO selectUserById(String userId) throws Exception{
		return sqlSession.selectOne("mapper.user.selectUserById", userId);
	}
	
	@Override
    public UserVO selectNaverUserById(String userId) throws Exception{
        return sqlSession.selectOne("mapper.user.selectNaverUserById", userId);
    }
	
	@Override
	public void updateUser(UserVO userVO) throws Exception{
		sqlSession.update("mapper.user.updateUser", userVO);
	}
	
    @Override
    public void updatePassword(UserVO userVO) throws Exception {
        sqlSession.update("mapper.user.updatePassword", userVO);
    }

	@Override
	public void insertNaverUser(UserVO userVO) throws Exception {
		sqlSession.insert("mapper.user.insertNaverUser",userVO);		
	}
	@Override
    public void updateNaverUser(UserVO user) {
        sqlSession.update("mapper.user.updateNaverUser", user);
    }
	
    @Override
    public void deleteUser(String userId) throws DataAccessException {
        sqlSession.delete("mapper.user.deleteUser", userId);
    }
}