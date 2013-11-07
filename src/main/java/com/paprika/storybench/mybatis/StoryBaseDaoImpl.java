package com.paprika.storybench.mybatis;

import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.paprika.storybench.dao.StoryBaseDao;
import com.paprika.storybench.vo.StoryBaseVo;

public class StoryBaseDaoImpl extends SqlSessionDaoSupport implements StoryBaseDao {

	@Override
	public int addNewStoryBase(Map<String, String> map) {
		return getSqlSession().insert("storyBaseDao.addNewStoryBase",map);
	}

	@Override
	public StoryBaseVo getStoryBaseInfo(int storyBaseId) {
		return (StoryBaseVo) getSqlSession().selectOne("storyBaseDao.getStoryBaseInfo",storyBaseId);
	}
}