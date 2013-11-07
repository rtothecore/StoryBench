package com.paprika.storybench.vo;

public class StoryActorsVo {
	private int storyActorsId;
	private int storyBaseId;
	private String actorName;
	
	private int actorSex;
	private int actorAge;
	private String actorDesc;
	
	public int getStoryActorsId() { return storyActorsId;      }   public void setStoryActorsId(int storyActorsId) { this.storyActorsId = storyActorsId; }
	public int getStoryBaseId() { return storyBaseId;      }   public void setStoryBaseId(int storyBaseId) { this.storyBaseId = storyBaseId; }
	public String getActorName()       { return actorName;       }   public void setActorName(String actorName)             { this.actorName = actorName; }
	
	public int getActorSex() { return actorSex;      }   public void setActorSex(int actorSex) { this.actorSex = actorSex; }
	public int getActorAge() { return actorAge;      }   public void setActorAge(int actorAge) { this.actorAge = actorAge; }
	public String getActorDesc()       { return actorDesc;       }   public void setActorDesc(String actorDesc)             { this.actorDesc = actorDesc; }
	
}
