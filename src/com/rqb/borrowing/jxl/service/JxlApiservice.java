package com.rqb.borrowing.jxl.service;

import org.springframework.stereotype.Service;

import com.rqb.borrowing.jxl.vo.ApplyInfo;
import com.rqb.borrowing.jxl.vo.ReqMsg;
import com.rqb.common.SendRequest;
import com.rqb.common.Constants.Pks;
import com.rqb.service.abs.AbstractService;

import net.sf.json.JSONObject;

/**
 * 聚信立
 * @author wangya
 * @since 2017-02-16
 */
@Service
public class JxlApiservice extends AbstractService {
	
	/**
	 * 提交数据源采集请求
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	public String collectReq(JSONObject jsonObject) {
		return SendRequest.post(config.get(Pks.BACKEND_URL_JXL_COLLECT_REQ), jsonObject);
	}
	
	/**
	 * 获取支持的数据源列表
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	public String datasources() {
		return SendRequest.post(config.get(Pks.BACKEND_URL_JXL_DATASOURCE), null);
	}
	
	/**
	 * 提交申请表单获取回执信息
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	public String apply(JSONObject jsonObject) {
		return SendRequest.post(config.get(Pks.BACKEND_URL_JXL_APPLY), jsonObject);
	}
	
	/**
	 * 提交申请表单接口
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	public String applications(JSONObject jsonObject) {
		return SendRequest.post(config.get(Pks.BACKEND_URL_JXL_CREDITCARD_APPLICATIONS), jsonObject);
	}
	
	/**
	 * 信用卡-提交采集请求接口
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	public String messageReq(JSONObject jsonObject) {
		return SendRequest.post(config.get(Pks.BACKEND_URL_JXL_CREDITCARD_MESSAGE_COLLECT_REQ), jsonObject);
	}
	
	/**
	 * 信用卡响应接口(二维码登录方式才需要)
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	public String messageResp(JSONObject jsonObject) {
		return SendRequest.post(config.get(Pks.BACKEND_URL_JXL_CREDITCARD_MESSAGE_QRCODECOLLECT_RESP), jsonObject);
	}
}
