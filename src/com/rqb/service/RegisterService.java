package com.rqb.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.rqb.common.ConfigManager;
import com.rqb.common.SendRequest;
import com.rqb.common.Constants.Pks;
import com.rqb.service.abs.AbstractService;

@Service
public class RegisterService  extends AbstractService{
	private static final Logger log = Logger.getLogger(RegisterService.class);
	
	/**注册*/
	public String register(Map<String, Object> params) {
		log.info("RegisterService.register");
		String url = ConfigManager.getInstance().get(Pks.REGISTER_REG);
		log.info("RegisterService.register request url = " + url);
		return SendRequest.post(url, params);
	}
	
	/**注册*/
	public String registerByBeiqing(Map<String, Object> params) {
		log.info("RegisterService.register_beiqing");
		String url = ConfigManager.getInstance().get(Pks.BQ_REGISTER_BEIQING);
		log.info("RegisterService.register request url = " + url);
		return SendRequest.post(url, params);
	}
	
	/**注册*/
	public String registerByRqb(Map<String, Object> params) {
		log.info("RegisterService.register_rqb");
		String url = ConfigManager.getInstance().get(Pks.BQ_REGISTER_RQB);
		log.info("RegisterService.register request url = " + url);
		return SendRequest.post(url, params);
	}
	
	/**检查用户是否存在*/
	public String checkUser(Map<String, Object> params) {
		log.info("RegisterService.checkUser");
		String url = ConfigManager.getInstance().get(Pks.REGISTER_USER_VALIDATE);
		log.info("RegisterService.checkUser request url = " + url);
		return SendRequest.post(url, params);
	}
	
	/**获取手机验证码*/
	public String getMCode(Map<String, Object> params) {
		log.info("RegisterService.getMCode");
		String url = ConfigManager.getInstance().get(Pks.REGISTER_GETCODE);
		log.info("RegisterService.getMCode request url = " + url);
		return SendRequest.post(url, params);
	}
	
	/**获取手机语音验证码*/
	public String getRadioCode(Map<String, Object> params) {
		log.info("RegisterService.getRadioCode");
		String url = ConfigManager.getInstance().get(Pks.SEND_AUDIO_TO_GET_CODE);
		log.info("RegisterService.getRadioCode request url = " + url);
		return SendRequest.post(url, params);
	}
	
	/**实名认证*/
	public String authentication(Map<String, Object> params){
		log.info("RegisterService.authentication");
		String url =  ConfigManager.getInstance().get(Pks.ACCOUNT_INFO_DOAPPAUTHIDCARD);
		log.info("RegisterService.authentication request url = " + url);
		return SendRequest.post(url, params);
	}
	
	/**UMP实名注册*/
	public String umpRegister(Map<String, Object> params){
	    log.info("ump real register");
	    String url = ConfigManager.getInstance().get(Pks.UMP_REAL_REGISTER);
	    return SendRequest.post(url, params);
	}
	
	/**登录*/
	public String login(Map<String, Object> params){
		log.info("RegisterService.login");
		String url =  ConfigManager.getInstance().get(Pks.REGISTER_LOGIN);
		log.info("RegisterService.login request url = " + url);
		return SendRequest.post(url, params);
	}
	
	/**修改登录密码*/
	public String modifyPassword(Map<String, Object> params){
		log.info("RegisterService.modifyPassword");
		String url =  ConfigManager.getInstance().get(Pks.ACCOUNT_CHANGEL);
		log.info("RegisterService.modifyPassword request url = " + url);
		return SendRequest.post(url, params);
	}
	
	/**修改支付密码*/
	public String modifyPayPassword(Map<String, Object> params){
		log.info("RegisterService.modifyPayPassword");
		String url =  ConfigManager.getInstance().get(Pks.ACCOUNT_CHANGEP);
		log.info("RegisterService.modifyPayPassword request url = " + url);
		return SendRequest.post(url, params);
	}
	
	/**重置密码*/
	public String findPW(Map<String, Object> params){
		log.info("RegisterService.findPW 重置密码");
		String url =  ConfigManager.getInstance().get(Pks.ACCOUNT_INFO_FINDPW);
		log.info("RegisterService.findPW request url = " + url);
		return SendRequest.post(url, params);
	}
	public String checkMobileUsed(String m){
		log.info("RegisterService.checkMobileUsed ");
		String url =  ConfigManager.getInstance().get(Pks.CHECK_MOBILE_USED_OR_NOT);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("m", m);
		return SendRequest.post(url, params);
	}
}
