package com.paprika.storybench.vo;

public class UserVo {

	private int userSeqId;
	private String userId;
	private String userPassword;
	private String userAuthorName;
	
	public int getUserSeqId()         { return userSeqId;      }   public void setUserSeqId(int userSeqId)              { this.userSeqId = userSeqId; }
	public String getUserId()       { return userId;       }   public void setUserId(String userId)             { this.userId       = userId; }
	public String getUserPassword() { return userPassword; }   public void setUserPassword(String userPassword) { this.userPassword = userPassword; }
	public String getUserAuthorName()    { return userAuthorName;    }   public void setUserAuthorName(String userAuthorName)       { this.userAuthorName = userAuthorName; }
	
}
