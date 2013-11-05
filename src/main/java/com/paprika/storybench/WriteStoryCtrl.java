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

import com.paprika.storybench.mybatis.StoryBaseDaoImpl;
import com.paprika.storybench.mybatis.StoryActorsDaoImpl;
import com.paprika.storybench.mybatis.StoryDaoImpl;

@Controller
public class WriteStoryCtrl {
    
private static final Logger logger = LoggerFactory.getLogger(HomeCtrl.class);
    
	@Resource(name="storyBaseDaoImpl")
	private StoryBaseDaoImpl storyBaseDaoImpl;
	
	@Resource(name="storyActorsDaoImpl")
	private StoryActorsDaoImpl storyActorsDaoImpl;
	
	@Resource(name="storyDaoImpl")
	private StoryDaoImpl storyDaoImpl;
    
    @RequestMapping("writeStory.do")
    public ModelAndView main(HttpServletRequest request) {
    	
    	ModelAndView mav = new ModelAndView("main");
    	mav.setViewName("ajax/joinAjaxData");
    	
    	String storyBg = request.getParameter("storyBg");
    	String storyView = request.getParameter("storyView");
    	String storyGenre = request.getParameter("storyGenre");
    	
    	String storyActor1Name = request.getParameter("storyActor1");
    	String storyActor1Sex = "1";	// 0: 여, 1: 남
    	String storyActor1Age = "33";
    	String storyActor1Desc = "오크의족장";
    	
    	String storyParentRef = "0";	// 0이면 root 인걸로?
    	String storyTreeLevel = "0";	// 0이면 root
    	String story = request.getParameter("story");
    	String storyRegistered = "1";
    	
    	logger.info("Inserting new story_base...(" + storyBg + ", " + storyView + ", " + storyGenre + ")");
    	
    	// 1. Insert to story_base
    	Map<String, String> map_sb = new HashMap<String, String>();
    	map_sb.put("id", "");	// for getting story_base_id 
    	map_sb.put("storyBg", storyBg);
    	map_sb.put("storyView", storyView);
    	map_sb.put("storyGenre", storyGenre);
    	
    	if(1 == storyBaseDaoImpl.addNewStoryBase(map_sb)) {
    		logger.info("Inserting new story_base(" + map_sb.get("id") + ", "+ storyBg + ", " + storyView + ", " + storyGenre + ") success!");
    	} else {
    		logger.info("Inserting new story_base(" + map_sb.get("id") + ", "+ storyBg + ", " + storyView + ", " + storyGenre + ") failed..");
    	}
    	
    	// 2. Insert to story_actors
    	String story_base_id = map_sb.get("id");
    	
    	Map<String, String> map_sa = new HashMap<String, String>();
    	map_sa.put("storyBaseId", story_base_id);
    	map_sa.put("actorName", storyActor1Name);
    	map_sa.put("actorSex", storyActor1Sex);
    	map_sa.put("actorAge", storyActor1Age);
    	map_sa.put("actorDesc", storyActor1Desc);
    	
    	if(1 == storyActorsDaoImpl.addNewStoryActor(map_sa)) {
    		logger.info("Inserting new story_actors(" + story_base_id + ", "+ storyActor1Name + ", " + storyActor1Sex + ", " + storyActor1Age + ", " + storyActor1Desc + ") success!");
    	} else {
    		logger.info("Inserting new story_actors(" + story_base_id + ", "+ storyActor1Name + ", " + storyActor1Sex + ", " + storyActor1Age + ", " + storyActor1Desc + ") failed!");
    	}
    	
    	// 3. Insert to story
    	HttpSession session = request.getSession();
    	Integer userId = (Integer)session.getAttribute("userIdInt");

    	Map<String, String> map_s = new HashMap<String, String>();
    	map_s.put("storyBaseId", story_base_id);
    	map_s.put("userId", userId.toString());
    	map_s.put("parentRef", storyParentRef);
    	map_s.put("treeLevel", storyTreeLevel);
    	map_s.put("story", story);
    	map_s.put("registered", storyRegistered);
    	
    	if(1 == storyDaoImpl.addNewStory(map_s)) {
    		logger.info("Inserting new story(" + story_base_id + ", "+ userId + ", " + storyParentRef + ", " + storyTreeLevel + ", " + story + ", " + storyRegistered + ") success!");
    		mav.addObject("result", "1");
    	} else {
    		logger.info("Inserting new story(" + story_base_id + ", "+ userId + ", " + storyParentRef + ", " + storyTreeLevel + ", " + story + ", " + storyRegistered + ") failed!");
    		mav.addObject("result", "0");
    	}
    	
    	return mav;    
    }
}
