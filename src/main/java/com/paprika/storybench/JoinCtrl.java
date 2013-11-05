package com.paprika.storybench;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.paprika.storybench.mybatis.UserDaoImpl;

@Controller
public class JoinCtrl {
    
private static final Logger logger = LoggerFactory.getLogger(HomeCtrl.class);
    
    @Resource(name="userDaoImpl")
    private UserDaoImpl userDaoImpl;
    
    @RequestMapping("join.do")
    public ModelAndView main(HttpServletRequest request) {
    	
    	String joinId = request.getParameter("join_id");
    	String joinPw = request.getParameter("join_pw");
    	String joinAuthor = request.getParameter("join_author");
    	
    	logger.info("Inserting new user...(" + joinId + ", " + joinPw + ", " + joinAuthor + ")");
    	
        ModelAndView mav = new ModelAndView("main");
        mav.setViewName("ajax/joinAjaxData");
        
        Map<String, String> map = new HashMap<String, String>();
        map.put("id", joinId);
        map.put("password", joinPw);
        map.put("authorname", joinAuthor);
        
        if(1 == userDaoImpl.addNewUser(map)) {
        	logger.info("Inserting new user(" + joinId + ", " + joinPw + ", " + joinAuthor + ") success!");
        	mav.addObject("result", "1");
        } else {
        	logger.info("Inserting new user(" + joinId + ", " + joinPw + ", " + joinAuthor + ") failed..");
        	mav.addObject("result", "0");
        }
        
        return mav; 
    }
}
