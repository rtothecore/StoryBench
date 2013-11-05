package com.paprika.storybench.mybatis;

import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.paprika.storybench.dao.StoryDao;

public class StoryDaoImpl extends SqlSessionDaoSupport implements StoryDao {

	@Override
	public int addNewStory(Map<String, String> map) {
		return getSqlSession().insert("storyDao.addNewStory",map);
	}
	
}