package com.paprika.storybench.mybatis;

import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import com.paprika.storybench.dao.UserDao;
import com.paprika.storybench.vo.UserVo;

public class UserDaoImpl extends SqlSessionDaoSupport implements UserDao {
    @Override
    public int getLoginResult(Map<String, String> map) {
        return (Integer) getSqlSession().selectOne("userDao.getLoginResult",map);
    }

    @Override
	public UserVo getUserInfo(String id) {
    	return (UserVo) getSqlSession().selectOne("userDao.getUserInfo",id);
	}
    
	@Override
	public int getDuplUserId(String joinUserId) {
		return (Integer) getSqlSession().selectOne("userDao.getDuplUserId",joinUserId);
	}

	@Override
	public int getDuplAuthor(String joinAuthor) {
		return (Integer) getSqlSession().selectOne("userDao.getDuplAuthor",joinAuthor);
	}

	@Override
	public int addNewUser(Map<String, String> map) {
		return getSqlSession().insert("userDao.addNewUser",map);
	}

}