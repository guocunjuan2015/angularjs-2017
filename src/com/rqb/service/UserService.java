package com.rqb.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rqb.common.SendRequest;
import com.rqb.common.Constants.Pks;
import com.rqb.service.abs.AbstractService;

/**
 * 用户奖品
 * @author wangya
 * @since 2017-01-09
 */
@Service
public class UserService extends AbstractService {
	
	/**
	 * 用户中心
	 * @author wangya
	 * @since 2017-01-10
	 * @param request
	 * @param response
	 */
	public String getUserCenter(Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.USER_CENTER), params);
	}
	
	/**
	 * 获取我的回款计划明细
	 * @author wangya
	 * @since 2017-01-10
	 * @param request
	 * @return
	 */
	public String getPaymentPlanDetail (Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.USER_PAYMENT_PLAN_DETAIL), params);
	}
	
	/**
	 * 身份证上传
	 * @author wangya
	 * @since 2017-02-17
	 * @param request
	 * @return
	 */
	public String uploadImg (Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.BACKEND_URL_AUTHEN_UPLOADIMG), params);
	}
	
	/**
	 * 用户认证信息接口
	 * @author wangya
	 * @since 2017-02-17
	 * @param request
	 * @return
	 */
	public String userAuthenInfo (Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.BACKEND_URL_AUTHEN_USERAUTHENINFO), params);
	}
}
