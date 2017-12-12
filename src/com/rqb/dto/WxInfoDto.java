package com.rqb.dto;

import java.util.Date;

public class WxInfoDto implements Comparable<WxInfoDto>{
	private String openid;
	private String name;
	private Date date;
	private Long count;
	
	public WxInfoDto() {
		count = 0l;
		date = new Date();
	} 

	public String getOpenid() {
		return openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	
	public Long getCount() {
		return count;
	}

	public void setCount(Long count) {
		this.count = count;
	}

	public void visit(){
		this.count ++;
	}

	@Override
	public int compareTo(WxInfoDto other) {
		int value = 1;
		if(this.count < other.count){
			value = 1;
		}else if(this.count == other.count){
			value = 0;
		}else{
			value = -1;
		}
		return value;
	}
}
