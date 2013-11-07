package com.paprika.storybench.dao;

import java.util.Map;

import com.paprika.storybench.vo.StoryBaseVo;

public interface StoryBaseDao {
	public int addNewStoryBase(Map<String, String> map);
	public StoryBaseVo getStoryBaseInfo(int storyBaseId);
}
