package com.cookit.inquiry.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cookit.inquiry.dao.InquiryDAO;
import com.cookit.inquiry.vo.InquiryVO;

@Service
public class InquiryServiceImpl implements InquiryService {
    @Autowired
    private InquiryDAO inquiryDAO;

    @Override
    public void addInquiry(InquiryVO inquiry) {
        inquiryDAO.insertInquiry(inquiry);
    }

    @Override
    public List<InquiryVO> getInquiryListByUser(String user_id) {
        return inquiryDAO.selectInquiryListByUser(user_id);
    }

    @Override
    public InquiryVO getInquiryById(int inquiry_id) {
        return inquiryDAO.selectInquiryById(inquiry_id);
    }

    @Override
    public void changeInquiryStatus(int inquiry_id, String status) {
        inquiryDAO.updateInquiryStatus(inquiry_id, status);
    }
    
    @Override
    public List<InquiryVO> getAllInquiries() {
        return inquiryDAO.selectAllInquiries(); 
    }
    
}

