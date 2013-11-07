package com.paprika.storybench.ajax;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.paprika.storybench.mybatis.StoryBaseDaoImpl;
import com.paprika.storybench.mybatis.StoryActorsDaoImpl;
import com.paprika.storybench.mybatis.StoryDaoImpl;
import com.paprika.storybench.vo.StoryActorsVo;
import com.paprika.storybench.vo.StoryBaseVo;
import com.paprika.storybench.vo.StoryVo;

@Controller
public class WriteFollowedAjax {
    
	private static final Logger logger = LoggerFactory.getLogger(WriteFollowedAjax.class);
	
	StoryVo storyVo;
	StoryBaseVo storyBaseVo;
	List<StoryActorsVo> storyActorsVo;
	
	@Resource(name="storyDaoImpl")
	private StoryDaoImpl storyDaoImpl;
	
	@Resource(name="storyBaseDaoImpl")
	private StoryBaseDaoImpl storyBaseDaoImpl;
	
	@Resource(name="storyActorsDaoImpl")
	private StoryActorsDaoImpl storyActorsDaoImpl;
    
    @RequestMapping("getStoryBase.ajax")
    public ModelAndView getStoryBase(HttpServletRequest request) {
    	
    	String storyBaseId = request.getParameter("storyBaseId");
    	logger.info("Selecting story_base...(" + storyBaseId + ")");
    	
    	// 1. Select story_base
    	logger.info("getStoryInfo - storyBaseId:" + storyBaseId);
    	storyBaseVo = storyBaseDaoImpl.getStoryBaseInfo(Integer.parseInt(storyBaseId));
    	logger.info("getStoryBaseInfo - background:" + storyBaseVo.getBackground());
    	    	
    	// 2. Select story_actors - N개
    	storyActorsVo = storyActorsDaoImpl.getStoryActorsInfo(Integer.parseInt(storyBaseId));
    	if(0 < storyActorsVo.size()) {
    		logger.info("등장인물들을 찾음! getStoryActorsInfo - size:" + storyActorsVo.size());
    		logger.info("등장인물1:" + storyActorsVo.get(0).getActorName());
    	}
    	
    	// json
    	/*
    	 *  {"m_StoryBase":{"m_background":str, "m_view":str, "m_genre":str, "m_etc":str },
    	 * 	 "m_StoryActors":[
    	 * 						{"m_storyActorsId":int, "m_actorName":str, "m_actorSex":int,
    	 * 					     "m_actorAge":int, "m_actorDesc":str }
    	 * 				   ]
    	 * 	}
    	 */
        
        JSONObject objRoot = new JSONObject();
      	
        // m_StoryBase
        JSONObject objMeStoryBase = new JSONObject();
        objRoot.put("m_StoryBase", objMeStoryBase);
        objMeStoryBase.put("m_background", storyBaseVo.getBackground());
        objMeStoryBase.put("m_view", storyBaseVo.getView());
        objMeStoryBase.put("m_genre", storyBaseVo.getGenre());
        objMeStoryBase.put("m_etc", storyBaseVo.getEtc());
        
        // m_StoryActors
        JSONArray arrMeStoryActors = new JSONArray();
        objRoot.put("m_StoryActors", arrMeStoryActors);
        
        for(int i=0; i<storyActorsVo.size(); i++) {	// 등장인물 수만큼 루프돌며 add
	        JSONObject objMeStoryActor = new JSONObject();
	        arrMeStoryActors.add(objMeStoryActor);
	        objMeStoryActor.put("m_storyActorsId", storyActorsVo.get(i).getStoryActorsId());
	        objMeStoryActor.put("m_actorName", storyActorsVo.get(i).getActorName());
	        objMeStoryActor.put("m_actorSex", storyActorsVo.get(i).getActorSex());
	        objMeStoryActor.put("m_actorAge", storyActorsVo.get(i).getActorAge());
	        objMeStoryActor.put("m_actorDesc", storyActorsVo.get(i).getActorDesc());
        }
    	
        // mv
        ModelAndView mav = new ModelAndView("main");
        mav.setViewName("ajax/joinAjaxData");
        mav.addObject("result", objRoot);
        
        return mav;
    }
    
    @RequestMapping("getParentStory.ajax")
    public ModelAndView getParentStory(HttpServletRequest request) {
    	
    	String storyId = request.getParameter("storyId");
    	logger.info("Selecting story...(" + storyId + ")");
    	
    	storyVo = storyDaoImpl.getStoryInfo(storyId);
    	logger.info("getStoryInfo - story:" + storyVo.getStory());
    	
    	// json    	
    	/*
    	 * {"p_storyId":int, "p_storyBaseId":int, "p_userId":int, 
    	 * 	"p_regDate":str, "p_parentRef":int, "p_treeLevel":int, 
    	 * 	"p_story":str, "p_viewCount":int, "p_recommCount":int,
    	 * 	"p_registered":int, "p_deleted":int 
    	 * }
    	 */
        
        JSONObject objRoot = new JSONObject();
        objRoot.put("p_storyId", storyVo.getStoryId());
        objRoot.put("p_storyBaseId", storyVo.getStoryBaseId());
        objRoot.put("p_userId", storyVo.getUserId());
        objRoot.put("p_regDate", storyVo.getRegDate());
        objRoot.put("p_parentRef", storyVo.getParentRef());
        objRoot.put("p_treeLevel", storyVo.getTreeLevel());
        objRoot.put("p_story", storyVo.getStory());
        objRoot.put("p_viewCount", storyVo.getViewCount());
        objRoot.put("p_recommCount", storyVo.getRecommCount());
        objRoot.put("p_registered", storyVo.getRegistered());
        objRoot.put("p_deleted", storyVo.getDeleted());
    	
        // mv
        ModelAndView mav = new ModelAndView("main");
        mav.setViewName("ajax/joinAjaxData");
        mav.addObject("result", objRoot);
        
        return mav;
    }
}
