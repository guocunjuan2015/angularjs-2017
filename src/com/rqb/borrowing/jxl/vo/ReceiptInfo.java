package com.rqb.borrowing.jxl.vo;

/**
 * 生成token获得的回执信息
 * 
 * @author zhaojianjun
 * 
 *
 */
public class ReceiptInfo {

	/** 用户操作凭证码 **/
	private String token;
	/** 电话号码 **/
	private String cell_phone_num;
	/** 数据源信息 **/
	private Datasource datasource;

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getCell_phone_num() {
		return cell_phone_num;
	}

	public void setCell_phone_num(String cell_phone_num) {
		this.cell_phone_num = cell_phone_num;
	}

	public Datasource getDatasource() {
		return datasource;
	}

	public void setDatasource(Datasource datasource) {
		this.datasource = datasource;
	}

	@Override
	public String toString() {
		return "ReceiptInfo [token=" + token + ", cell_phone_num=" + cell_phone_num + ", datasource=" + datasource + "]";
	}

}
