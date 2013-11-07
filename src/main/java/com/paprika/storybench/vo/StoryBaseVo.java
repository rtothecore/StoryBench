package com.paprika.storybench.vo;

public class StoryBaseVo {
	private int storyBaseId;
	private String background;
	private String view;
	private String genre;
	private String etc;
	
	public int getStoryBaseId()         { return storyBaseId;      }   public void setStoryBaseId(int storyBaseId)              { this.storyBaseId = storyBaseId; }
	public String getBackground()       { return background;       }   public void setBackground(String background)             { this.background = background; }
	public String getView()       { return view;       }   public void setView(String view)             { this.view = view; }
	public String getGenre()       { return genre;       }   public void setGenre(String genre)             { this.genre = genre; }
	public String getEtc()       { return etc;       }   public void setEtc(String etc)             { this.etc = etc; }
}
