package com.paprika.storybench;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LogoutCtrl {

	private static final Logger logger = LoggerFactory.getLogger(LoginCtrl.class);
	
	@RequestMapping("logout.do")
	public ModelAndView main(HttpServletRequest request ) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		logger.info("Log out session...");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("ajax/joinAjaxData");
		mav.addObject("result", "1");
		
		return mav; 
	}
}