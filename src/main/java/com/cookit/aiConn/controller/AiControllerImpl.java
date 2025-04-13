package com.cookit.aiConn.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.codehaus.jackson.map.ObjectMapper;

@Controller
public class AiControllerImpl implements AiController{
	
	@Override
	@RequestMapping(value= "/aiConn/test.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView fetchData() {
		
        // REST API ȣ��
		
        String url = "http://localhost:5000/api/data";
        RestTemplate restTemplate = new RestTemplate();
        
        ModelAndView mav = new ModelAndView("/ai/data-view");
        try {
        	  // Flask �������� JSON �����͸� List<Map<String, Object>>�� ��������
            List<Map<String, Object>> responseList = restTemplate.getForObject(url, List.class);

            // ��� ���
            System.out.println("responseList : " + responseList);
            // JSP���� ����� ������ �߰�
            mav.addObject("dataList", responseList);
			
        } catch (Exception e) {
            e.printStackTrace();
        }
		
        return mav;
    }

}
