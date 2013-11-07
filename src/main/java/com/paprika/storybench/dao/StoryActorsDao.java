package com.paprika.storybench.dao;

import java.util.List;
import java.util.Map;

import com.paprika.storybench.vo.StoryActorsVo;

public interface StoryActorsDao {
	public int addNewStoryActor(Map<String, String> map);
	public List<StoryActorsVo> getStoryActorsInfo(int storyBaseId);
}
