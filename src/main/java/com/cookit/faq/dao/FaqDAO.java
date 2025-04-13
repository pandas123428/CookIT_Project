package com.cookit.faq.dao;

import java.util.List;
import org.springframework.dao.DataAccessException;
import com.cookit.faq.vo.FaqVO;

public interface FaqDAO {
    public List<FaqVO> searchFAQ(String keyword) throws DataAccessException;
}
