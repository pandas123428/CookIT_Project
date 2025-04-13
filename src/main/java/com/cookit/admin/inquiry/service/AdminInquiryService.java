package com.cookit.admin.inquiry.service;

import java.util.List;
import com.cookit.inquiry.vo.InquiryVO;

public interface AdminInquiryService {
	
    List<InquiryVO> getAllInquiries();
    
    InquiryVO getInquiryById(int inquiry_id);
    
    void updateInquiryAnswer(int inquiry_id, String answer);
}

