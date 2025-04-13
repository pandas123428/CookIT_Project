package com.cookit.inquiry.service;

import java.util.List;
import com.cookit.inquiry.vo.InquiryVO;

public interface InquiryService {
    void addInquiry(InquiryVO inquiry);
    List<InquiryVO> getInquiryListByUser(String user_id);
    InquiryVO getInquiryById(int inquiry_id);
    void changeInquiryStatus(int inquiry_id, String status);
	List<InquiryVO> getAllInquiries();
}

