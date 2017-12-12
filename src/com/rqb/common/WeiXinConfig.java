package com.rqb.common;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.ruiqt.lianlian.utils.HttpsUtils;

/**
 * 微信配置
 */
public class WeiXinConfig {

	protected static Logger _log = Logger.getLogger(WeiXinConfig.class);
	//ricky
	// 订阅号 Appid 和 密钥
	//public static final String APPID = "wxc0a92365fdd6d136";
	public static final String APPID = "wxf945c2cee029f0a1";
	//public static final String SECRET = "6e8572674905b871a51ff91165423cb7";
	public static final String SECRET = "4788a119637d9a1dd1af383d0aaf2b2c";

	//测试订阅号Appid 和 密钥
//	public static final String APPID = "wxeffb2c45d52c9093";
//	public static final String SECRET = "f2ab97ca6820709f5e42079b46e1818a";
	// 微信的access_token
	public static String ACCESSTOKEN = "";
	public static String JSAPITICKET = "";
	// 上次获取的时间戳
	public static long LASTGETTIME = 0;
	
	public static String getJsapiticket(){
		_log.info("ACCESSTOKEN:" + ACCESSTOKEN + " :JSAPITICKET: " + JSAPITICKET);
		// 无值时候重新获取
		if (StringUtils.isBlank(ACCESSTOKEN) ||  StringUtils.isBlank(JSAPITICKET)) {
			JSAPITICKET = getLatestJsapiticket();
		} else {
			// 快到期时重新获取
			if((LASTGETTIME + 6200000) < System.currentTimeMillis()){
				JSAPITICKET = getLatestJsapiticket();
			}
		}
		_log.info("result JSAPITICKET: " + JSAPITICKET);
		return JSAPITICKET;
	}
	
	public static String getLatestJsapiticket() {
		LASTGETTIME = System.currentTimeMillis(); //获得当前的时间戳

		// 获取token
		String tokenResult = HttpsUtils.sendGet( "https://api.weixin.qq.com/cgi-bin/token",
				"grant_type=client_credential&appid=" + APPID + "&secret=" + SECRET);
		_log.info("获取到的token:" + tokenResult);//获得tokenResult
		
		JSONObject jsonObject = JSONObject.parseObject(tokenResult);
		ACCESSTOKEN = jsonObject.getString("access_token");
		
		// 根据获取到的 token 获取 ticket
		String jsapiticket = HttpsUtils.sendGet("https://api.weixin.qq.com/cgi-bin/ticket/getticket",
				"access_token=" + ACCESSTOKEN + "&type=jsapi");
		_log.info("获取tikent:" + jsapiticket);
		jsonObject = JSONObject.parseObject(jsapiticket);
		JSAPITICKET = jsonObject.getString("ticket");
		return JSAPITICKET;
	}
	
	public static class ClearThread extends Thread{
		public void run(){
			int t = 1*60;
			while(t!=0){
				t = t - 1;
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			ACCESSTOKEN = "";
			JSAPITICKET = "";
			getJsapiticket();
		}
	}

	public static void main(String[] args) {
		System.out.println(new Date().getTime());
		System.out.println(System.currentTimeMillis());
	}
}