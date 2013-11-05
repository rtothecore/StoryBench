package com.paprika.storybench.mybatis;

import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.paprika.storybench.dao.StoryBaseDao;

public class StoryBaseDaoImpl extends SqlSessionDaoSupport implements StoryBaseDao {

	@Override
	public int addNewStoryBase(Map<String, String> map) {
		return getSqlSession().insert("storyBaseDao.addNewStoryBase",map);
	}
}