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
public class CgUserService  extends AbstractService{
	private static final Logger log = Logger.getLogger(CgUserService.class);
	
	/**注册*/
	public String register(Map<String, Object> params) {
		log.info("ump real register");
	    String url = ConfigManager.getInstance().getApiPay(ApiPayConstants.API_PAYMENT_USER_REGISTER);
	    return SendRequest.post(url, params);
	}
	
	public String getRegisterInfo(Map<String, Object> params) {
		String url = ConfigManager.getInstance().getApiPay(ApiPayConstants.API_PAYMENT_CG_REGISTER_INFO);
		log.info("RegisterService.register request url = " + url);
		return SendRequest.post(url, params);
	}
	
}
