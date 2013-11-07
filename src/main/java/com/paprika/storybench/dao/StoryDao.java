package com.paprika.storybench.dao;

import java.util.List;
import java.util.Map;

import com.paprika.storybench.vo.StoryVo;

public interface StoryDao {
	public int addNewStory(Map<String, String> map);
	
	public StoryVo getStoryInfo(String storyId);
	
	public List<StoryVo> getChildrenStoryInfo(String storyId);
}