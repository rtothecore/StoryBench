package com.paprika.storybench;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class JsonTestCtrl {
    
private static final Logger logger = LoggerFactory.getLogger(JsonTestCtrl.class);
    
    @RequestMapping("jsonTest.do")
    public ModelAndView main(HttpServletRequest request, HttpServletResponse response) {
    	
    	PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        JSONObject obj = new JSONObject();
        obj.put("result", new Boolean(true));
        obj.put("name","foo");
        obj.put("num",new Integer(100));
        obj.put("balance",new Double(1000.21));
        obj.put("is_vip",new Boolean(true));
        obj.put("nickname",null);
        out.print(obj);
        out.flush();
        out.close();    
         
        return null;    
   
    }
}
