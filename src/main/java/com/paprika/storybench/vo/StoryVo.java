package com.paprika.storybench.vo;

public class StoryVo {
	private int storyId;
	private int storyBaseId;
	private int userId;
	
	private String regDate;
	private int parentRef;
	private int treeLevel;
	
	private String story;
	private int viewCount;
	private int recommCount;
	
	private int registered;
	private int deleted;
	
	
	public int getStoryId()         { return storyId;      }   public void setStoryId(int storyId)              { this.storyId = storyId; }
	public int getStoryBaseId()         { return storyBaseId;      }   public void setStoryBaseId(int storyBaseId)              { this.storyBaseId = storyBaseId; }
	public int getUserId()         { return userId;      }   public void setUserId(int userId)              { this.userId = userId; }
	
	public String getRegDate()       { return regDate;       }   public void setRegDate(String regDate)             { this.regDate       = regDate; }
	public int getParentRef()         { return parentRef;      }   public void setParentRef(int parentRef)              { this.parentRef = parentRef; }
	public int getTreeLevel()         { return treeLevel;      }   public void setTreeLevel(int treeLevel)              { this.treeLevel = treeLevel; }
	
	public String getStory()       { return story;       }   public void setStory(String story)             { this.story       = story; }
	public int getViewCount()         { return viewCount;      }   public void setViewCount(int viewCount)              { this.viewCount = viewCount; }
	public int getRecommCount()         { return recommCount;      }   public void setRecommCount(int recommCount)              { this.recommCount = recommCount; }
	
	public int getRegistered()         { return registered;      }   public void setRegistered(int registered)              { this.registered = registered; }
	public int getDeleted()         { return deleted;      }   public void setDeleted(int deleted)              { this.deleted = deleted; }
}
