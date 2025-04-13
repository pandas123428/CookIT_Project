package com.cookit.admin.inquiry.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cookit.admin.inquiry.dao.AdminInquiryDAO;
import com.cookit.inquiry.vo.InquiryVO;

@Service("adminInquiryService")
public class AdminInquiryServiceImpl implements AdminInquiryService {
	
	@Autowired
	private AdminInquiryDAO adminInquiryDAO;
	
	@Override
	public List<InquiryVO> getAllInquiries(){
		return adminInquiryDAO.selectAllInquiries();
	}
	
	@Override
	public InquiryVO getInquiryById(int inquiry_id) {
		return adminInquiryDAO.selectInquiryById(inquiry_id);
	}
	
	@Override
	public void updateInquiryAnswer(int inquiry_id, String answer) {
		adminInquiryDAO.updateInquiryAnswer(inquiry_id, answer);
	}
}
