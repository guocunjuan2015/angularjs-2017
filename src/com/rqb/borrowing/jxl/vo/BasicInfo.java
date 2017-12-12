package com.rqb.borrowing.jxl.vo;

/**
 * 基本信息
 * 
 * @author zhaojianjun
 * 
 *
 */
public class BasicInfo {
	/** 用户姓名 **/
	private String name;
	/** 身份证号码 **/
	private String id_card_num;
	/** 手机号码 **/
	private String cell_phone_num;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId_card_num() {
		return id_card_num;
	}

	public void setId_card_num(String id_card_num) {
		this.id_card_num = id_card_num;
	}

	public String getCell_phone_num() {
		return cell_phone_num;
	}

	public void setCell_phone_num(String cell_phone_num) {
		this.cell_phone_num = cell_phone_num;
	}

	@Override
	public String toString() {
		return "BasicInfo [name=" + name + ", id_card_num=" + id_card_num + ", cell_phone_num=" + cell_phone_num + "]";
	}
}
