package com.cookit.faq.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cookit.faq.dao.FaqDAO;
import com.cookit.faq.vo.FaqVO;

@Service
public class FaqServiceImpl implements FaqService{
	
	@Autowired
	private FaqDAO faqDAO;
	
	@Override
	public List<FaqVO> searchFAQ(String keyword) throws Exception{
			return faqDAO.searchFAQ(keyword);
	}
}
