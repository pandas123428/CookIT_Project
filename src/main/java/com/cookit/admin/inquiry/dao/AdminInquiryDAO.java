package com.cookit.admin.inquiry.dao;

import java.util.List;
import com.cookit.inquiry.vo.InquiryVO;

public interface AdminInquiryDAO {
    List<InquiryVO> selectAllInquiries();
    InquiryVO selectInquiryById(int inquiry_id);
    void updateInquiryAnswer(int inquiry_id, String answer);
}