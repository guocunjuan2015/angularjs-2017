package com.rqb.borrowing.jxl.vo;

import java.util.List;

/**
 * 申请信息
 * 
 * @author zhaojianjun
 *
 */
public class ApplyInfo {

	/**
	 * 基本信息
	 */
	private BasicInfo basic_info;
	/**
	 * 用户ID
	 */
	private String userId;
    
	/**
	 * 是否跳过移动运营商的采集
	 */
	private String skip_mobile;//（ true 跳过，false 不跳过）如果选择跳过的话，selected_website 字段就不能为空。类型为boolean

	/**
	 * 需要进行认证的网站集合
	 */
	private List<Website> selected_website;

	private List<Contact> contacts;

	public List<Contact> getContacts() {

		return contacts;
	}

	public void setContacts(List<Contact> contacts) {

		this.contacts = contacts;
	}

	public BasicInfo getBasic_info() {

		return basic_info;
	}

	public void setBasic_info(BasicInfo basic_info) {

		this.basic_info = basic_info;
	}

	public List<Website> getSelected_website() {

		return selected_website;
	}

	public void setSelected_website(List<Website> selected_website) {

		this.selected_website = selected_website;
	}

    public String getSkip_mobile() {
        return skip_mobile;
    }

    public void setSkip_mobile(String skip_mobile) {
        this.skip_mobile = skip_mobile;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

	@Override
	public String toString() {

		return "ApplyInfo [basic_info=" + basic_info + ", selected_website=" + selected_website + ", contacts=" + contacts + "]";
	}
}
