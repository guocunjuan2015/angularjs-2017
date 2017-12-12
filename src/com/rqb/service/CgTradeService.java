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
public class CgTradeService  extends AbstractService{
	private static final Logger log = Logger.getLogger(CgTradeService.class);
	
	/**充值*/
	public String recharge(Map<String, Object> params) {
	    String url = ConfigManager.getInstance().getApiPay(ApiPayConstants.API_PAYMENT_TRADE_RECHARGE);
	    return SendRequest.post(url, params);
	}
	
	/**
	 * 提现
	 * @param params
	 * @return
	 */
	public String withdraw(Map<String, Object> params) {
		String url = ConfigManager.getInstance().getApiPay(ApiPayConstants.API_PAYMENT_TRADE_WITHDRAW);
		return SendRequest.post(url, params);
	}
	
	/**
	 * 投资
	 * @param params
	 * @return
	 */
	public String invest(Map<String, Object> params) {
		String url = ConfigManager.getInstance().getApiPay(ApiPayConstants.API_PAYMENT_TRADE_INVEST);
		return SendRequest.post(url, params);
	}
	
}
