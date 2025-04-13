package com.cookit.faq.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import com.cookit.faq.vo.FaqVO;

@Repository
public class FaqDAOImpl implements FaqDAO {
	@Autowired
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "mappers.faq";
	
	@Override
	public List<FaqVO> searchFAQ(String keyword) throws DataAccessException{
		return sqlSession.selectList(NAMESPACE + ".searchFAQ", keyword);
		
	}
	
}
