package com.cookit.admin.inquiry.dao;

import java.util.List;
import java.util.HashMap;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.cookit.inquiry.vo.InquiryVO;

@Repository("adminInquiryDAO")
public class AdminInquiryDAOImpl implements AdminInquiryDAO{
	
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE = "mapper.InquiryMapper";
	
	@Override
	public List<InquiryVO> selectAllInquiries(){
		return sqlSession.selectList(NAMESPACE + ".selectAllInquiries");
	}
	
	@Override
	public InquiryVO selectInquiryById(int inquiry_id) {
		return sqlSession.selectOne(NAMESPACE + ".selectInquiryById", inquiry_id);
	}
	
	@Override
	public void updateInquiryAnswer(int inquiry_id, String answer) {
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("inquiry_id", inquiry_id);
	    params.put("answer", answer);
	    sqlSession.update(NAMESPACE + ".updateInquiryAnswer", params);
	}
}
