package com.paprika.storybench;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ViewStoryCtrl {
    
	private static final Logger logger = LoggerFactory.getLogger(ViewStoryCtrl.class);
    
    @RequestMapping("viewStory.do")
    public ModelAndView main(HttpServletRequest request) {
    	
    	String storyId = (String)request.getParameter("storyId");
    	logger.info("Redirecting viewStory.jsp... storyId:" + storyId);
    	
    	ModelAndView mav = new ModelAndView("viewStory");
		mav.addObject("storyId", storyId);
    	
        return mav;
    }
}