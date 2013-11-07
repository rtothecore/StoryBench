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
public class ViewAjax {
    
	private static final Logger logger = LoggerFactory.getLogger(ViewAjax.class);
	StoryVo storyVo;
	StoryBaseVo storyBaseVo;
	List<StoryActorsVo> storyActorsVo;
	
	StoryVo storyVo_parent;
	
	List<StoryVo> storyVo_children;
	
	@Resource(name="storyBaseDaoImpl")
	private StoryBaseDaoImpl storyBaseDaoImpl;
	
	@Resource(name="storyActorsDaoImpl")
	private StoryActorsDaoImpl storyActorsDaoImpl;
	
	@Resource(name="storyDaoImpl")
	private StoryDaoImpl storyDaoImpl;
    
    @RequestMapping("viewStory.ajax")
    public ModelAndView main(HttpServletRequest request) {
    	
    	String storyId = request.getParameter("storyId");
    	logger.info("Selecting new story_base...(" + storyId + ")");
    	
    	////////////////////////////// ME ///////////////////////////////////////////
    	// 1. Select story
    	storyVo = storyDaoImpl.getStoryInfo(storyId);
    	logger.info("getStoryInfo - story:" + storyVo.getStory());
    	
    	// 2. Select story_base
    	int storyBaseId = storyVo.getStoryBaseId();
    	logger.info("getStoryInfo - storyBaseId:" + storyBaseId);
    	storyBaseVo = storyBaseDaoImpl.getStoryBaseInfo(storyBaseId);
    	logger.info("getStoryBaseInfo - background:" + storyBaseVo.getBackground());
    	    	
    	// 3. Select story_actors - N개 
    	storyActorsVo = storyActorsDaoImpl.getStoryActorsInfo(storyBaseId);
    	if(0 < storyActorsVo.size()) {
    		logger.info("등장인물들을 찾음! getStoryActorsInfo - size:" + storyActorsVo.size());
    		logger.info("등장인물1:" + storyActorsVo.get(0).getActorName());
    	}
    	
    	////////////////////////////// PARENT ///////////////////////////////////////////
    	// 4. Select parent story - 1개
    	if(0 == storyVo.getParentRef()) {	// 부모가 없음
    		logger.info("부모가 음슴...");
    	} else {	// 부모가 있는 경우
    		storyVo_parent = storyDaoImpl.getStoryInfo(String.valueOf(storyVo.getParentRef()));
    		logger.info("부모를 찾았다! getStoryInfo - parentStory:" + storyVo_parent.getStory());
    	}
    	
    	////////////////////////////// CHILDREN ///////////////////////////////////////////
    	// 5. Select children story - N개
    	// 현재 story_id를 부모로 가진 넘들을 모조리 Select
    	storyVo_children = storyDaoImpl.getChildrenStoryInfo(storyId);
    	if(0 < storyVo_children.size()) {
    		logger.info("자식덜을 찾았다! getChildrenStoryInfo - size:" + storyVo_children.size());
    		StoryVo tempChild1 = storyVo_children.get(0);
    		logger.info("자식1:" + tempChild1.getStoryId() + " " + tempChild1.getStory());
    	} else {
    		logger.info("자식이 엄슴...");
    	}
    	    	
    	// json
    	
    	/*
    	 * {"me":{"m_Story":{"m_storyId":int, "m_storyBaseId":int, "m_userId":int, 
    	 * 			  		 "m_regDate":str, "m_parentRef":int, "m_treeLevel":int, 
    	 * 			  		 "m_story":str, "m_viewCount":int, "m_recommCount":int,
    	 * 			  		 "m_registered":int, "m_deleted":int
    	 * 					}, 
    	 * 		  "m_StoryBase":{"m_background":str, "m_view":str, "m_genre":str, "m_etc":str },
    	 * 		  "m_StoryActors":[
    	 * 							{"m_storyActorsId":int, "m_actorName":str, "m_actorSex":int,
    	 * 					         "m_actorAge":int, "m_actorDesc":str }
    	 * 						  ]
    	 * 		 },
    	 * 	"parent":{"p_storyId":int, "p_storyBaseId":int, "p_userId":int, 
    	 * 			  "p_regDate":str, "p_parentRef":int, "p_treeLevel":int, 
    	 * 			  "p_story":str, "p_viewCount":int, "p_recommCount":int,
    	 * 			  "p_registered":int, "p_deleted":int 
    	 *           },
    	 * 	"children":[{"c_storyId":int, "c_storyBaseId":int, "c_userId":int, 
    	 * 			     "c_regDate":str, "c_parentRef":int, "c_treeLevel":int, 
    	 * 			     "c_story":str, "c_viewCount":int, "c_recommCount":int,
    	 * 			     "c_registered":int, "c_deleted":int 
    	 *              },
    	 * 				{반복}..
    	 * 			   ]
    	 * }
    	 */
    	
        JSONObject objRoot = new JSONObject();
        
        // me
        JSONObject objMe = new JSONObject();
        objRoot.put("me", objMe);
        
        	// me.m_Story
        JSONObject objMeStory = new JSONObject();
        objMe.put("m_Story", objMeStory);
        objMeStory.put("m_storyId", storyVo.getStoryId());
        objMeStory.put("m_storyBaseId", storyVo.getStoryBaseId());
        objMeStory.put("m_userId", storyVo.getUserId());
        objMeStory.put("m_regDate", storyVo.getRegDate());
        objMeStory.put("m_parentRef", storyVo.getParentRef());
        objMeStory.put("m_treeLevel", storyVo.getTreeLevel());
        objMeStory.put("m_story", storyVo.getStory());
        objMeStory.put("m_viewCount", storyVo.getViewCount());
        objMeStory.put("m_recommCount", storyVo.getRecommCount());
        objMeStory.put("m_registered", storyVo.getRegistered());
        objMeStory.put("m_deleted", storyVo.getDeleted());
        
        	// me.m_StoryBase
        JSONObject objMeStoryBase = new JSONObject();
        objMe.put("m_StoryBase", objMeStoryBase);
        objMeStoryBase.put("m_background", storyBaseVo.getBackground());
        objMeStoryBase.put("m_view", storyBaseVo.getView());
        objMeStoryBase.put("m_genre", storyBaseVo.getGenre());
        objMeStoryBase.put("m_etc", storyBaseVo.getEtc());
        
        	// me.m_StoryActors
        JSONArray arrMeStoryActors = new JSONArray();
        objMe.put("m_StoryActors", arrMeStoryActors);
        
        for(int i=0; i<storyActorsVo.size(); i++) {	// 등장인물 수만큼 루프돌며 add
	        JSONObject objMeStoryActor = new JSONObject();
	        arrMeStoryActors.add(objMeStoryActor);
	        objMeStoryActor.put("m_storyActorsId", storyActorsVo.get(i).getStoryActorsId());
	        objMeStoryActor.put("m_actorName", storyActorsVo.get(i).getActorName());
	        objMeStoryActor.put("m_actorSex", storyActorsVo.get(i).getActorSex());
	        objMeStoryActor.put("m_actorAge", storyActorsVo.get(i).getActorAge());
	        objMeStoryActor.put("m_actorDesc", storyActorsVo.get(i).getActorDesc());
        }
        
        // parent
        JSONObject objParent = new JSONObject();
        objRoot.put("parent", objParent);
        
        if(0 != storyVo.getParentRef()) {
	        objParent.put("p_storyId", storyVo_parent.getStoryId());
	        objParent.put("p_storyBaseId", storyVo_parent.getStoryBaseId());
	        objParent.put("p_userId", storyVo_parent.getUserId());
	        objParent.put("p_regDate", storyVo_parent.getRegDate());
	        objParent.put("p_parentRef", storyVo_parent.getParentRef());
	        objParent.put("p_treeLevel", storyVo_parent.getTreeLevel());
	        objParent.put("p_story", storyVo_parent.getStory());
	        objParent.put("p_viewCount", storyVo_parent.getViewCount());
	        objParent.put("p_recommCount", storyVo_parent.getRecommCount());
	        objParent.put("p_registered", storyVo_parent.getRegistered());
	        objParent.put("p_deleted", storyVo_parent.getDeleted());
        }
        
        // children
        JSONArray arrChildren = new JSONArray();
        objRoot.put("children", arrChildren);
        
        	// child    
        for(int i=0; i<storyVo_children.size(); i++) {
        	JSONObject objChild = new JSONObject();	
        	
	        objChild.put("c_storyId", storyVo_children.get(i).getStoryId());
	        objChild.put("c_storyBaseId", storyVo_children.get(i).getStoryBaseId());
	        objChild.put("c_userId", storyVo_children.get(i).getUserId());
	        objChild.put("c_regDate", storyVo_children.get(i).getRegDate());
	        objChild.put("c_parentRef", storyVo_children.get(i).getParentRef());
	        objChild.put("c_treeLevel", storyVo_children.get(i).getTreeLevel());
	        objChild.put("c_story", storyVo_children.get(i).getStory());
	        objChild.put("c_viewCount", storyVo_children.get(i).getViewCount());
	        objChild.put("c_recommCount", storyVo_children.get(i).getRecommCount());
	        objChild.put("c_registered", storyVo_children.get(i).getRegistered());
	        objChild.put("c_deleted", storyVo_children.get(i).getDeleted());
	        
	        arrChildren.add(objChild);
        }

        // mv
        ModelAndView mav = new ModelAndView("main");
        mav.setViewName("ajax/joinAjaxData");
        mav.addObject("result", objRoot);
        
        return mav;
    }
}
