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
public class UserAwardService extends AbstractService {
	
	/**
	 * 用户奖品
	 * @param request
	 * @param response
	 * @author wangya
	 * @return
	 */
	public String getUserAward(Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.USER_AWARD_LIST), params);
	}
	
	/**
	 * 获取红包列表
	 * @author wangya
	 * @since 2017-01-09
	 * @return
	 */
	public String getCouponList(Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.USER_AWARD_COUPON_LIST), params);
	}
	
	/**
	 * 获取加息券列表
	 * @author wangya
	 * @since 2017-01-09
	 * @return
	 */
	public String getMoreateList(Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.USER_AWARD_MORERATE_LIST), params);
	}
	
	/**
	 * 获取投资时用户的可用红包与加息券
	 * @author wangya
	 * @since 2017-01-09
	 */
	public String getUserCanUseCouponList(Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.USER_CAN_USE_COUPON_MORERATE_LIST), params);
	}

}
