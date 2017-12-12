package com.rqb.borrowing.jxl.vo;

/**
 * 响应对象
 * 
 * @author zhaojianjun
 * 
 *
 */
public class RespMsg {

	/** 响应类型 **/
	private String type;
	/** 消息内容 **/
	private String content;
	/** 流程号 **/
	private Integer process_code;
	/** 下一个采集网站 **/
	private Datasource next_datasource;
	/** 采集流程是否完成 **/
	private boolean finish;
	/** 如果返回类型是需要改变请求类型的消息，会提供请求类型 **/
	private ReqMsg req_msg_tpl;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getProcess_code() {
		return process_code;
	}

	public void setProcess_code(Integer process_code) {
		this.process_code = process_code;
	}

	public Datasource getNext_datasource() {
		return next_datasource;
	}

	public void setNext_datasource(Datasource next_datasource) {
		this.next_datasource = next_datasource;
	}

	public boolean isFinish() {
		return finish;
	}

	public void setFinish(boolean finish) {
		this.finish = finish;
	}

	public ReqMsg getReq_msg_tpl() {
		return req_msg_tpl;
	}

	public void setReq_msg_tpl(ReqMsg req_msg_tpl) {
		this.req_msg_tpl = req_msg_tpl;
	}

	@Override
	public String toString() {
		return "RespMsg [type=" + type + ", content=" + content + ", process_code=" + process_code + ", next_datasource=" + next_datasource + ", finish=" + finish + ", req_msg_tpl=" + req_msg_tpl + "]";
	}

}
