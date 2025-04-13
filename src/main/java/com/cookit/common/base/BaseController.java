package com.cookit.common.base;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.cookit.product.vo.ProductVO;


public abstract class BaseController  {
	private static final String CURR_IMAGE_REPO_PATH = "/pandas13/tomcat/webapps/ROOT/resources/product_image";
	
	protected ProductVO upload(MultipartHttpServletRequest multipartRequest) throws Exception{
		ProductVO productVO= new ProductVO();
		multipartRequest.setCharacterEncoding("utf-8");
		Iterator<String> fileNames = multipartRequest.getFileNames();
		String fileName = "";
		String originalFileName = "";
		MultipartFile mFile;
		while(fileNames.hasNext()){
			fileName = fileNames.next();
			if(fileName.equals("product_image_")) {
				productVO.setProduct_image(fileName);
				mFile = multipartRequest.getFile(fileName);
				originalFileName = mFile.getOriginalFilename();
				productVO.setProduct_image(originalFileName); 
				File file = new File(CURR_IMAGE_REPO_PATH +"/"+ fileName);
				if(mFile.getSize()!=0){ //File Null Check
					if(! file.exists()){ //
						if(file.getParentFile().mkdirs()){ //
								file.createNewFile(); //
						}
					}
					mFile.transferTo(new File(CURR_IMAGE_REPO_PATH +"/"+"temp"+ "/"+originalFileName)); //
				}
			}
			else if(fileName.equals("product_inform_")) {
				productVO.setProduct_inf_image(fileName);
				mFile = multipartRequest.getFile(fileName);
				originalFileName = mFile.getOriginalFilename();
				productVO.setProduct_inf_image(originalFileName);
				File file = new File(CURR_IMAGE_REPO_PATH +"/"+ fileName);
				if(mFile.getSize()!=0){ //File Null Check
					if(! file.exists()){ //
						if(file.getParentFile().mkdirs()){ //
								file.createNewFile(); //
						}
					}
					mFile.transferTo(new File(CURR_IMAGE_REPO_PATH +"/"+"temp"+ "/"+originalFileName)); //
				}
			}
		}
		return productVO;
	}
	private void deleteFile(String fileName) {
		File file =new File(CURR_IMAGE_REPO_PATH+"/"+fileName);
		try{
			file.delete();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping(value="/*.do" ,method={RequestMethod.POST,RequestMethod.GET})
	protected  ModelAndView viewForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	
	protected String calcSearchPeriod(String fixedSearchPeriod){
		String beginDate=null;
		String endDate=null;
		String endYear=null;
		String endMonth=null;
		String endDay=null;
		String beginYear=null;
		String beginMonth=null;
		String beginDay=null;
		DecimalFormat df = new DecimalFormat("00");
		Calendar cal=Calendar.getInstance();
		
		endYear   = Integer.toString(cal.get(Calendar.YEAR));
		endMonth  = df.format(cal.get(Calendar.MONTH) + 1);
		endDay   = df.format(cal.get(Calendar.DATE));
		endDate = endYear +"-"+ endMonth +"-"+endDay;
		
		if(fixedSearchPeriod == null) {
			cal.add(cal.MONTH,-4);
		}else if(fixedSearchPeriod.equals("one_week")) {
			cal.add(Calendar.DAY_OF_YEAR, -7);
		}else if(fixedSearchPeriod.equals("two_week")) {
			cal.add(Calendar.DAY_OF_YEAR, -14);
		}else if(fixedSearchPeriod.equals("one_month")) {
			cal.add(cal.MONTH,-1);
		}else if(fixedSearchPeriod.equals("two_month")) {
			cal.add(cal.MONTH,-2);
		}else if(fixedSearchPeriod.equals("three_month")) {
			cal.add(cal.MONTH,-3);
		}else if(fixedSearchPeriod.equals("four_month")) {
			cal.add(cal.MONTH,-4);
		}
		
		beginYear   = Integer.toString(cal.get(Calendar.YEAR));
		beginMonth  = df.format(cal.get(Calendar.MONTH) + 1);
		beginDay   = df.format(cal.get(Calendar.DATE));
		beginDate = beginYear +"-"+ beginMonth +"-"+beginDay;
		
		return beginDate+","+endDate;
	}
	
}
