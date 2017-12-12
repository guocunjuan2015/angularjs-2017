package com.ruiqt.lianlian.utils;

import java.io.Serializable;

public class OperateResult implements Serializable {

	private static final long serialVersionUID = 3069442418120706152L;

	private int result = 1; // 结果 1成功，0失败
	private String errInfo; // 错误信息
	private Object resultObject;

	public OperateResult() {

	}

	public OperateResult(Object resultObject) {
		this.resultObject = resultObject;
	}

	public OperateResult(int result, String errInfo) {
		this.result = result;
		this.errInfo = errInfo;
	}

	public OperateResult(int result, String errInfo,Object resultObject) {
		this.result = result;
		this.errInfo = errInfo;
		this.resultObject=resultObject;
	}
	
	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public String getErrInfo() {
		return errInfo;
	}

	public void setErrInfo(String errInfo) {
		this.errInfo = errInfo;
	}

	public Object getResultObject() {
		return resultObject;
	}

	public void setResultObject(Object resultObject) {
		this.resultObject = resultObject;
	}

}
