package com.paprika.storybench.mybatis;

import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.paprika.storybench.dao.StoryActorsDao;

public class StoryActorsDaoImpl extends SqlSessionDaoSupport implements StoryActorsDao {

	@Override
	public int addNewStoryActor(Map<String, String> map) {
		return getSqlSession().insert("storyActorsDao.addNewStoryActor",map);
	}
	
}