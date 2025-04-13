package com.cookit.inquiry.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.cookit.inquiry.vo.InquiryVO;

@Repository("inquiryDAO")
public class InquiryDAOImpl implements InquiryDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	private static final String NAMESPACE ="mapper.InquiryMapper";
	
    @Override
    public void insertInquiry(InquiryVO inquiry) {
        sqlSession.insert(NAMESPACE + ".insertInquiry", inquiry);
    }

    @Override
    public List<InquiryVO> selectInquiryListByUser(String user_id) {
        return sqlSession.selectList(NAMESPACE + ".selectInquiryListByUser", user_id);
    }

    @Override
    public InquiryVO selectInquiryById(int inquiry_id) {
        return sqlSession.selectOne(NAMESPACE + ".selectInquiryById", inquiry_id);
    }
    
    @Override
    public List<InquiryVO> selectAllInquiries() {
        return sqlSession.selectList(NAMESPACE + ".selectAllInquiries");
    }

    @Override
    public void updateInquiryStatus(int inquiry_id, String status) {
        InquiryVO inquiry = new InquiryVO();
        inquiry.setInquiry_id(inquiry_id);
        inquiry.setStatus(status);
        sqlSession.update(NAMESPACE + ".updateInquiryStatus", inquiry);
    }
}
