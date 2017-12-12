package com.rqb.borrowing.jxl.vo;

/**
 * 数据源网站对象
 * 
 * @author zhaojianjun
 * 
 *
 */
public class Website {

	/** 网站名称 **/
	private String website;
	/** 网站 分类名称 **/
	private String category;

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "Website{" + "website='" + website + '\'' + ", category='" + category + '\'' + '}';
	}
}
