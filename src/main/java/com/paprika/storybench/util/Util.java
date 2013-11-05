package com.paprika.storybench.util;

public class Util {
	
	public static String nullCheck(String param, String returnValue){
		
		String result = "";
		
		if (param == null) 
		{
			result = returnValue;
		}
		else 
		{
			result = param;
		}
		
		return result;
	}
}
