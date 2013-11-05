package com.paprika.storybench.dao;

import java.util.Map;
import com.paprika.storybench.vo.UserVo;

public interface UserDao {
    public int getLoginResult(Map<String, String> map);
    public UserVo getUserInfo(String id);
    
    public int getDuplUserId(String joinUserId);
    public int getDuplAuthor(String joinAuthor);
    public int addNewUser(Map<String, String> map);
    
}
