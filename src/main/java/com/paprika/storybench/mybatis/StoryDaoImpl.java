package com.paprika.storybench.mybatis;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.paprika.storybench.dao.StoryDao;
import com.paprika.storybench.vo.StoryVo;

public class StoryDaoImpl extends SqlSessionDaoSupport implements StoryDao {

	@Override
	public int addNewStory(Map<String, String> map) {
		return getSqlSession().insert("storyDao.addNewStory",map);
	}

	@Override
	public StoryVo getStoryInfo(String storyId) {
		return (StoryVo) getSqlSession().selectOne("storyDao.getStoryInfo",storyId);
	}

	@Override
	public List<StoryVo> getChildrenStoryInfo(String storyId) {
		return (List<StoryVo>) getSqlSession().selectList("storyDao.getChildrenStoryInfo",storyId);
	}
	
}