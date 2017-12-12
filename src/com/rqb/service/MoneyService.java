package com.rqb.service;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rqb.common.Constants.Msg;
import com.rqb.common.Constants.Pks;
import com.rqb.common.SendRequest;
import com.rqb.service.abs.AbstractService;
import com.ruiqt.lianlian.utils.APPUtil;
import com.ultrapower.cloudup.utils.EmptyUtils;

@Service
public class MoneyService extends AbstractService{
	private static final SimpleDateFormat FORMATTER = new SimpleDateFormat("yyyyMMddHHmmss");
	private static final String VERSION = "1.1";
	private static final String OID_PARTNER = "201501091000169503";
	private static final String APP_REQUEST = "3";
	private static final String BUSI_PARTNER = "101001";
	private static final String NAME_GOODS = "充值";
	private static final String ID_TYPE = "0";
	
	private static final String SIGN_TYPE = "MD5";
	private static final String MD5_KEY = "5416b9dbff02358930b01496c9e09425";
	
	public String getCard(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userName", account);
		return SendRequest.post(config.get(Pks.RECHARGE_BANKCARDNO), params);
	}
	
	public String bindCard(String cardNo, String province, String city, String brabank, String cardCode, String password, String account){
		_log.info("account [" + account + "] bind card -> " + cardNo);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("cardNo", cardNo);
		params.put("provice", province);
		params.put("city", city);
		params.put("brabank", brabank);
		params.put("userName", account);
		params.put("cardCode", cardCode);
		params.put("password", password);
		return SendRequest.post(config.get(Pks.RECHARGE_BANDCARD), params);
	}
	
	public String getInfo(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.RECHARGE_RECHARGEVALIDATE), params);
	}
	
	public String recharge(String account, Double amount){
		_log.info("account [" + account + "] recharge -> money = " + amount);
		if(EmptyUtils.isEmpty(amount) || amount < 100){
			executeFail(Msg.FAILURE);
			return null;
		}
		
		//精确到小数点后2位
		String money = String.format("%.2f", amount);
		
		_log.info("account [" + account + "] request info");
		
		//请求校验信息
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		String jsonStr = SendRequest.post(config.get(Pks.RECHARGE_RECHARGEVALIDATE), params);
		_log.info("account [" + account + "] recharge -> checkInfo = " + jsonStr);
		JSONObject jo = JSONObject.fromObject(jsonStr);
		if(jo.getInt("result") == 0){
			executeFail(jo.getString("errInfo"));
			return null;
		}
		jo = jo.getJSONObject("resultObject");
		String userID = jo.getString("userID");
		String realName = jo.getString("realName");
		String idCard = jo.getString("idCard");
		String registerTime = jo.getString("registerTime");
		
		_log.info("account [" + account + "] request recharge info -> money = " + money);
		
		//请求充值信息
		params = new HashMap<String, Object>();
		params.put("u", account);
		params.put("amount", money);
		jsonStr = SendRequest.post(config.get(Pks.RECHARGE_DORECHARGEAPP), params);
		_log.info("account [" + account + "] recharge -> rechargeInfo = " + jsonStr);
		jo = JSONObject.fromObject(jsonStr);
		
		if(jo.getInt("result") == 0){
			executeFail(jo.getString("errInfo"));
			return null;
		}
		jo = jo.getJSONObject("resultObject");
		String orderID = jo.getString("orderID");
		String notifyUrl = jo.getString("notifyUrl");
		String noAgree = "";
		String cardNo  = "";
		try{ noAgree = jo.getString("no_agree"); }catch (Exception e) {}
		try{ 
			cardNo = jo.getString("cardNo"); 
			if(cardNo.indexOf("*") != -1){
				cardNo = "";
			}
		}catch (Exception e) {}
		
		_log.info("account [" + account + "] request for lianlian");
		
		//请求充值
		params = new HashMap<String, Object>();
		params.put("version", VERSION);
		params.put("oid_partner", OID_PARTNER);
		params.put("user_id", userID);
		params.put("app_request", APP_REQUEST);
		params.put("busi_partner", BUSI_PARTNER);
		params.put("no_order", orderID);
		params.put("dt_order", FORMATTER.format(new Date()));
		params.put("name_goods", NAME_GOODS);
		params.put("acct_name", realName);
		params.put("id_no", idCard);
		
		params.put("money_order", money);
		params.put("notify_url", notifyUrl);
		params.put("id_type", ID_TYPE);
		
		Map<String, Object> risk_item_map = new HashMap<String, Object>();
		risk_item_map.put("frms_ware_category", "2009");
		risk_item_map.put("user_info_identify_type", "3");
		risk_item_map.put("user_info_identify_state", "1");
		
		risk_item_map.put("user_info_mercht_us", userID);
		risk_item_map.put("user_info_dt_register", registerTime);
		risk_item_map.put("user_info_full_name", realName);
		risk_item_map.put("user_info_id_no", idCard);
		
		jo = JSONObject.fromObject(risk_item_map);
		params.put("risk_item", jo.toString());
		
		//TODO 处理空参数
		params.put("platform", "");
		params.put("url_return", "http://www.rqbao.com/rqb/personal_center.jsp");
		params.put("info_order", "");
		params.put("no_agree", noAgree);
		params.put("valid_order", "");
		params.put("card_no", cardNo);
		
		String reqJson = EmptyUtils.isEmpty(params) ? "{}" : com.alibaba.fastjson.JSONObject.toJSONString(params);
		com.alibaba.fastjson.JSONObject reqObject = com.alibaba.fastjson.JSON.parseObject(reqJson);
		reqObject.put("sign_type", SIGN_TYPE);
		String sign = APPUtil.addSign(reqObject, "", MD5_KEY);
		reqObject.put("sign", sign);
		String reqStr = reqObject.toString();
		
		return reqStr;
	}
	
	public String cash(String account, String password, String money){
		_log.info("account [" + account + "] cash -> money = " + money);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("username", account);
		params.put("password", password);
		params.put("money", money);
		String result = SendRequest.post(config.get(Pks.RECHARGE_WITHDRAWREQUEST), params);
		_log.info("cash info -> " + result);
		return result;
	}
	
	public String searchBranch(String cityCode,String bankCode,String branchName){
//		String braName = URLEncoder.encode(branchName);
		String url = config.get(Pks.SEARCH_BRANCH_NAME)+"?cityCode="+cityCode+"&bankCode="+bankCode+"&branchName="+branchName;
		_log.info("searchBranch info -> " + url);
		return SendRequest.post(url, null);
	}
}
