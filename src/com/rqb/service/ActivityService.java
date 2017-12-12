package com.rqb.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.rqb.common.Constants.Pks;
import com.rqb.common.SendRequest;
import com.rqb.service.abs.AbstractService;

@Service
public class ActivityService extends AbstractService{
	
	/**
	 * 获取账户余额
	 * @author wangya
	 * @since 2017-07-02
	 * @param request
	 * @return
	 */
	public String morerate (Map<String, Object> params) {
		return SendRequest.post(config.get("backend_url_activity_cg_morerate"), params);
	}
	
	/**
	 * 获取账户余额
	 * @author wangya
	 * @since 2017-07-02
	 * @param request
	 * @return
	 */
	public String morerateUserLt (Map<String, Object> params) {
		return SendRequest.post(config.get("backend_url_activity_cg_morerateUserLt"), params);
	}
}
