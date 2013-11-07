package com.paprika.storybench.mybatis;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.paprika.storybench.dao.StoryActorsDao;
import com.paprika.storybench.vo.StoryActorsVo;

public class StoryActorsDaoImpl extends SqlSessionDaoSupport implements StoryActorsDao {

	@Override
	public int addNewStoryActor(Map<String, String> map) {
		return getSqlSession().insert("storyActorsDao.addNewStoryActor",map);
	}

	@Override
	public List<StoryActorsVo> getStoryActorsInfo(int storyBaseId) {
		return (List<StoryActorsVo>) getSqlSession().selectList("storyActorsDao.getStoryActorsInfo",storyBaseId);
	}
	
}