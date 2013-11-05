package com.paprika.storybench;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	
}
