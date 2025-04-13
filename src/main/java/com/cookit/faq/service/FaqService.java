package com.cookit.faq.service;

import java.util.List;
import com.cookit.faq.vo.FaqVO;

public interface FaqService {
	public List<FaqVO> searchFAQ(String keyword) throws Exception;
}
