package com.paprika.storybench;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.paprika.storybench.mybatis.UserDaoImpl;
import com.paprika.storybench.util.Util;
import com.paprika.storybench.vo.UserVo;

@Controller
public class LoginCtrl {

	private static final Logger logger = LoggerFactory.getLogger(LoginCtrl.class);
	UserVo userVo;

	@Resource(name="userDaoImpl")
	private UserDaoImpl userDaoImpl;
	
	@RequestMapping("login.do")
	public ModelAndView main(HttpServletRequest request ) {
		
		HttpSession session = request.getSession();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("ajax/joinAjaxData");
		
		Map<String, String> map = new HashMap<String, String>();
		
		String id = Util.nullCheck(request.getParameter("id"), "");
		String password = Util.nullCheck(request.getParameter("pw"), "");
		
		logger.info("Logging user...(" + id + ", " + password + ")");
		
		map.put("id", id);
		map.put("password", password);
		
		int loginValue = 0;
		
		try {  loginValue = userDaoImpl.getLoginResult(map);  } catch (Exception e) { }
		
		if (1 == loginValue) {
			logger.info("Login success! - " + id);
			
			userVo = userDaoImpl.getUserInfo(id);
			session.setAttribute("userIdInt", userVo.getUserSeqId());
			session.setAttribute("userId", userVo.getUserId());
			session.setAttribute("userPassword", userVo.getUserPassword());
			session.setAttribute("userAuthorName", userVo.getUserAuthorName());
			
			mav.addObject("result", "1");
		} else {
			logger.info("Login failed..(" + id + "," + password + ")");
			
			mav.addObject("result", "0");
		}
		
		return mav; 
	}
}
