package com.paprika.storybench;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeCtrl {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeCtrl.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "index";
	}
	
	/**
	 * 회원가입 폼 페이지
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "joinForm.do", method = RequestMethod.GET)
	public String joinForm(Locale locale, Model model) {
		logger.info("Welcome joinForm! The client locale is {}.", locale);
		
		return "joinForm";
	}
	
	/**
	 * 스토리 쓰기 폼 페이지
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "writeStoryForm.do", method = RequestMethod.GET)
	public String writeStoryForm(Locale locale, Model model) {
		logger.info("Welcome writeStoryForm! The client locale is {}.", locale);
		
		return "writeStoryForm";
	}
	
	/**
	 * 스토리 이어쓰기 폼 페이지
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "writeFollowedForm.do")
	public ModelAndView writeFollowedForm(HttpServletRequest request) {
		
		String parentStoryId = (String)request.getParameter("parentStoryId");
		String parentTreeLevel = (String)request.getParameter("parentTreeLevel");
		String parentStoryBaseId = (String)request.getParameter("parentStoryBaseId");
    	logger.info("Redirecting writeStoryForm.jsp... parentStoryId:" + parentStoryId + ", parentTreeLevel:" + parentTreeLevel + ", parentStoryBaseId:" + parentStoryBaseId);
    	
    	ModelAndView mav = new ModelAndView("writeStoryForm");
    	
    	/*
    	 * < writeStoryForm 페이지의 모드 >  
    	 * 1. new(새글) - 임시저장, 등록
    	 * 2. modify(수정) - 삭제, 수정
    	 * 3. followed(이어쓰기) - 임시저장, 등록
    	 */
    	mav.addObject("mode", "followed");	
		mav.addObject("parentStoryId", parentStoryId);
		mav.addObject("parentTreeLevel", parentTreeLevel);
		mav.addObject("parentStoryBaseId", parentStoryBaseId);
    	
        return mav;
	}
	
}
