package com.cookit.inquiry.dao;

import java.util.List;
import com.cookit.inquiry.vo.InquiryVO;

public interface InquiryDAO {
    void insertInquiry(InquiryVO inquiry);
    List<InquiryVO> selectInquiryListByUser(String user_id);
    InquiryVO selectInquiryById(int inquiry_id);
    void updateInquiryStatus(int inquiry_id, String status);
    List<InquiryVO> selectAllInquiries();
}
