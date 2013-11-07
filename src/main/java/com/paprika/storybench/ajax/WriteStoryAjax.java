package com.paprika.storybench.ajax;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.paprika.storybench.mybatis.StoryBaseDaoImpl;
import com.paprika.storybench.mybatis.StoryActorsDaoImpl;
import com.paprika.storybench.mybatis.StoryDaoImpl;

@Controller
public class WriteStoryAjax {
    
private static final Logger logger = LoggerFactory.getLogger(WriteStoryAjax.class);
    
	@Resource(name="storyBaseDaoImpl")
	private StoryBaseDaoImpl storyBaseDaoImpl;
	
	@Resource(name="storyActorsDaoImpl")
	private StoryActorsDaoImpl storyActorsDaoImpl;
	
	@Resource(name="storyDaoImpl")
	private StoryDaoImpl storyDaoImpl;
    
    @RequestMapping("writeStory.ajax")
    public ModelAndView main(HttpServletRequest request, HttpServletResponse response) {
    	
    	boolean result = false;
    	
    	String story_base_id = request.getParameter("storyBaseId");
    	
    	String storyBg = request.getParameter("storyBg");
    	String storyView = request.getParameter("storyView");
    	String storyGenre = request.getParameter("storyGenre");
    	
    	// actors START
    	String actorCount = request.getParameter("actorCount");
    	List<String> storyActorNames = new ArrayList<String>();
    	List<String> storyActorSexs = new ArrayList<String>();
    	List<String> storyActorAges = new ArrayList<String>();
    	List<String> storyActorDescs = new ArrayList<String>();
    	
    	for(int i=0; i<Integer.parseInt(actorCount); i++) {
    		String pName = "storyActor" + (i+1) + "Name";
    		storyActorNames.add(request.getParameter(pName));
    		
    		pName = "storyActor" + (i+1) + "Sex";
    		storyActorSexs.add(request.getParameter(pName));
    		
    		pName = "storyActor" + (i+1) + "Age";
    		storyActorAges.add(request.getParameter(pName));
    		
    		pName = "storyActor" + (i+1) + "Desc";
    		storyActorDescs.add(request.getParameter(pName));
    	}
    	// actors END
    	
    	String writeMode = request.getParameter("mode");
    	String storyParentRef = null;
    	String storyTreeLevel = null;
    	if(writeMode.equals("new")) {
    		storyParentRef = "0";	// 0이면 root
    		storyTreeLevel = "0";	// 0이면 root
    	} else if (writeMode.equals("followed")) {
    		storyParentRef = request.getParameter("parentRef");
    		storyTreeLevel = request.getParameter("parentTreeLevel");
    		logger.info("writeStory.do(followed mode) - storyParentRef:" + storyParentRef + " storyTreeLevel:" + storyTreeLevel);
        	int treeLevel = (Integer.parseInt(storyTreeLevel)) + 1;
        	storyTreeLevel = Integer.toString(treeLevel);	
    	} else {
    		// "modify" 모드는 별도 java 파일로 분리해야 할듯..(UPDATE)
    	}
    	
    	String story = request.getParameter("story");
    	String storyRegistered = "1";
    	String saveTemp = request.getParameter("saveTemp");		// 임시저장 여부
    	
    	logger.info("Inserting new story_base...(" + storyBg + ", " + storyView + ", " + storyGenre + ")");
    	
    	// NEW 스토리일 경우에만 스토리기본정보, 등장인물을 INSERT
    	if(writeMode.equals("new")) {
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
	    	story_base_id = map_sb.get("id");
	    	
	    	for(int i=0; i<Integer.parseInt(actorCount); i++) {
	    		Map<String, String> map_sa = new HashMap<String, String>();
		    	map_sa.put("storyBaseId", story_base_id);
		    	map_sa.put("actorName", storyActorNames.get(i));
		    	map_sa.put("actorSex", storyActorSexs.get(i));
		    	map_sa.put("actorAge", storyActorAges.get(i));
		    	map_sa.put("actorDesc", storyActorDescs.get(i));
		    	
		    	if(1 == storyActorsDaoImpl.addNewStoryActor(map_sa)) {
		    		logger.info("Inserting new story_actors(" + story_base_id + ", "+ storyActorNames.get(i) + ", " + storyActorSexs.get(i) + ", " + storyActorAges.get(i) + ", " + storyActorDescs.get(i) + ") success!");
		    	} else {
		    		logger.info("Inserting new story_actors(" + story_base_id + ", "+ storyActorNames.get(i) + ", " + storyActorSexs.get(i) + ", " + storyActorAges.get(i) + ", " + storyActorDescs.get(i) + ") failed!");
		    	}
	    	}
    	}
    	
    	// 3. Insert to story
    	HttpSession session = request.getSession();
    	Integer userId = (Integer)session.getAttribute("userIdInt");

    	Map<String, String> map_s = new HashMap<String, String>();
    	map_s.put("id", "");	// for getting story_id
    	map_s.put("storyBaseId", story_base_id);
    	map_s.put("userId", userId.toString());
    	map_s.put("parentRef", storyParentRef);
    	map_s.put("treeLevel", storyTreeLevel);
    	map_s.put("story", story);
    	
    	if(null == saveTemp) {	// 등록
    		map_s.put("registered", storyRegistered);
    	} else {	// 임시저장
    		map_s.put("registered", "0");
    	}
    	
    	if(1 == storyDaoImpl.addNewStory(map_s)) {
    		logger.info("Inserting new story(" + story_base_id + ", "+ userId + ", " + story + ", " + storyRegistered + ") success!");
    		result = true;
    	} else {
    		logger.info("Inserting new story(" + story_base_id + ", "+ userId + ", " + story + ", " + storyRegistered + ") failed!");
    	}
    	
    	// json
    	PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        JSONObject obj = new JSONObject();
        obj.put("result", result);
        obj.put("newStoryId", map_s.get("id"));
        out.print(obj);
        out.flush();
        out.close();    
    	
    	return null;
    }
}
