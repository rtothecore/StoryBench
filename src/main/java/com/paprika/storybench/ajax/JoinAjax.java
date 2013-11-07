package com.paprika.storybench.ajax;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.paprika.storybench.mybatis.UserDaoImpl;

@Controller
public class JoinAjax {
    
    private static final Logger logger = LoggerFactory.getLogger(JoinAjax.class);
    
    @Resource(name="userDaoImpl")
    private UserDaoImpl userDaoImpl;
    
    @RequestMapping("checkDuplUserId.do")
    public ModelAndView checkDuplicatedUserId(HttpServletRequest request) {  //HttpServletRequest 를 받아서 처리한다.
        String result = "0";
        int resultValue = 0;
        String joinUserId = request.getParameter("join_id");
        
        logger.info("Checking userid duplicated...{}", joinUserId);
        
        ModelAndView mav = new ModelAndView("main");
        mav.setViewName("ajax/joinAjaxData");
         
        try { resultValue = userDaoImpl.getDuplUserId(joinUserId) ; } catch(Exception e) {}
        
        if (resultValue == 1) {
        	logger.info("Duplicated userid exist!!!");
            result ="1";
        }
        mav.addObject("result", result);
        return mav; 
    }
    
    @RequestMapping("checkDuplAuthor.do")
    public ModelAndView checkDuplicatedAuthor(HttpServletRequest request) {  //HttpServletRequest 를 받아서 처리한다.
        String result = "0";
        int resultValue = 0;
        String joinAuthor = request.getParameter("join_authorname");
        
        logger.info("Checking author name duplicated...{}", joinAuthor);
        
        ModelAndView mav = new ModelAndView("main");
        mav.setViewName("ajax/joinAjaxData");
         
        try { resultValue = userDaoImpl.getDuplAuthor(joinAuthor) ; } catch(Exception e) {}
        
        if (resultValue == 1) {
        	logger.info("Duplicated author name exist!!!");
            result ="1";
        }
        mav.addObject("result", result);
        return mav; 
    }
    
}
