package com.rqb.borrowing.jxl.vo;

public class Contact {

	private String contact_tel;

	private String contact_name;

	private String contact_type;

	public String getContact_tel() {

		return contact_tel;
	}

	public void setContact_tel(String contact_tel) {

		this.contact_tel = contact_tel;
	}

	public String getContact_name() {

		return contact_name;
	}

	public void setContact_name(String contact_name) {

		this.contact_name = contact_name;
	}

	public String getContact_type() {

		return contact_type;
	}

	public void setContact_type(String contact_type) {

		this.contact_type = contact_type;
	}

	@Override
	public String toString() {

		return "Contact [contact_tel=" + contact_tel + ", contact_name=" + contact_name + ", contact_type=" + contact_type + "]";
	}
}
