package com.rqb.service;

import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.rqb.common.ApiPayConstants;
import com.rqb.common.ConfigManager;
import com.rqb.common.SendRequest;
import com.rqb.common.Constants.Pks;
import com.rqb.service.abs.AbstractService;

@Service
public class CgMemberCouponService  extends AbstractService{
	private static final Logger log = Logger.getLogger(CgMemberCouponService.class);
	
	/**
	 * 获取用户提现券列表
	 * @param params
	 * @return
	 */
	public String getList(Map<String, Object> params) {
		log.info("ump real register");
	    String url = ConfigManager.getInstance().getApiPay(ApiPayConstants.API_PAYMENT_MEMBER_COUPON_LIST);
	    return SendRequest.post(url, params);
	}
	
}
