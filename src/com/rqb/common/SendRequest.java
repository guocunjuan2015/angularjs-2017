package com.rqb.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Map;

import org.apache.commons.codec.binary.Hex;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.message.BasicHeader;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.protocol.HTTP;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ruiqt.lianlian.utils.APPUtil;
import com.ultrapower.cloudup.utils.EmptyUtils;
import org.apache.http.ParseException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class SendRequest {
	private static final Logger _log = Logger.getRootLogger();
	private static final String SIGN_TYPE = "MD5";
	private static final String MD5_KEY = "5416b9dbff02358930b01496c9e09425";
	
	public static HttpClient httpClient = SpringContextHolder.getBean("httpClient");
	public static RequestConfig requestConfig = SpringContextHolder.getBean("requestConfig");
	
	/*
	 setConnectTimeout：设置连接超时时间，单位毫秒。
setConnectionRequestTimeout：设置从connect Manager获取Connection 超时时间，单位毫秒。
这个属性是新加的属性，因为目前版本是可以共享连接池的。
setSocketTimeout：请求获取数据的超时时间，单位毫秒。
如果访问一个接口，多少时间内无法返回数据，就直接放弃此次调用。
	 */
	public static int connectionTimeout=30000;
	public static int socketTimeout=15000;
	public static int poolTimeout=15000;
	
	public static String post(String url, Map<String,Object> reqParams){
		String reqStr = EmptyUtils.isEmpty(reqParams) ? "{}" : JSONObject.toJSONString(reqParams);
		JSONObject reqObject = JSON.parseObject(reqStr);
		reqObject.put("sign_type", SIGN_TYPE);
		String sign = APPUtil.addSign(reqObject, "", MD5_KEY);
		reqObject.put("sign", sign);
		_log.info("send request url -> " + url);
		_log.info("send request params -> " + reqObject.toString());
		//String result = HttpUtils.sendPost(url, reqObject.toString());
		String result = null;
		try{
			result = postSendHttp(url, reqObject.toString());
		}catch(Exception e){
			_log.error("post error",e);
		}
		_log.info("receive response --> " + result);
		JSONObject resultObject = JSON.parseObject(result);
		if (resultObject!=null && resultObject.containsKey("resultObject")){
		    Object obj = resultObject.get("resultObject");
		    if (obj instanceof JSONObject){
		    JSONObject accountObject=resultObject.getJSONObject("resultObject");
    		if(accountObject!= null && accountObject.containsKey("u")){
    		    String login_name = accountObject.getString("u");
    		    login_name = Hex.encodeHexString(login_name.getBytes());
    		    accountObject.put("u_hex", login_name);
    		    resultObject.put("resultObject",accountObject);
                result = resultObject.toString();
    		}
//    		_log.info("after hex --> " + result);
		    }
		}
		return result;
	}
	
	public static String post(String url, Object entity){
		String reqStr = (entity == null ? "{}" : JSONObject.toJSONString(entity));
		JSONObject reqObject = JSON.parseObject(reqStr);
		reqObject.put("sign_type", SIGN_TYPE);
		String sign = APPUtil.addSign(reqObject, "", MD5_KEY);
		reqObject.put("sign", sign);
		_log.info("send request url -> " + url);
		_log.info("send request params -> " + reqObject.toString());
		//String result = HttpUtils.sendPost(url, reqObject.toString());
		String result = null;
		try{
			result = postSendHttp(url, reqObject.toString());
		}catch(Exception e){
			_log.error("post error",e);
		}
//		_log.info("receive response --> " + result);
		JSONObject resultObject = JSON.parseObject(result);
		if (resultObject!=null && resultObject.containsKey("resultObject")){
		    Object obj = resultObject.get("resultObject");
		    if (obj instanceof JSONObject){
		    JSONObject accountObject=resultObject.getJSONObject("resultObject");
    		if(accountObject!= null && accountObject.containsKey("u")){
    		    String login_name = accountObject.getString("u");
    		    login_name = Hex.encodeHexString(login_name.getBytes());
    		    accountObject.put("u_hex", login_name);
    		    resultObject.put("resultObject",accountObject);
                result = resultObject.toString();
    		}
//    		_log.info("after hex --> " + result);
		    }
		}
		return result;
	}
	
	private static String postSendHttp(String url, String body) {
		long start = System.currentTimeMillis();
		if (url == null || "".equals(url)) {
			_log.debug("request url is empty.");
			return null;
		}
		//HttpClient httpClient = CustomHttpClient.GetHttpClient();
		HttpPost post = new HttpPost(url);
//		RequestConfig requestConfig = RequestConfig.custom()  
//		        .setConnectTimeout(connectionTimeout).setConnectionRequestTimeout(poolTimeout)  
//		        .setSocketTimeout(socketTimeout).build();  
		post.setConfig(requestConfig);  
		post.setHeader("Content-Type", "text/plain;charset=UTF-8");
		String resultString=null;
		try {
			StringEntity stringEntity = new StringEntity(body, "UTF-8");
			stringEntity.setContentEncoding(new BasicHeader(
					HTTP.CONTENT_ENCODING, "UTF-8"));
			// 设置请求主体
			post.setEntity(stringEntity);
			// 发起交易
			HttpResponse resp = httpClient.execute(post);
			int ret = resp.getStatusLine().getStatusCode();
			if (ret == HttpStatus.SC_OK) {
				// 响应分析
				HttpEntity entity = resp.getEntity();

				BufferedReader br = new BufferedReader(new InputStreamReader(
						entity.getContent(), "UTF-8"));
				StringBuffer responseString = new StringBuffer();
				String result = br.readLine();
				while (result != null) {
					responseString.append(result);
					result = br.readLine();
				}
				long end = System.currentTimeMillis();
				_log.debug("请求[" + url + "]消耗时间 " + (end - start) + "毫秒");
				resultString = responseString.toString();
			}
		} catch (ClientProtocolException e) {
			_log.error("Post ClientProtocolException",e);
		} catch (IOException e) {
			_log.error("Post IOException", e);
		}  finally {
			// 释放连接
			post.releaseConnection();
		}
		return resultString;
	}
    
    public static String requestByGetMethod(String url) {
        //创建默认的httpClient实例
        CloseableHttpClient client = HttpClients.createDefault();
        String resp = null;
        try {
            //用get方法发送http请求
            HttpGet get = new HttpGet(url);
            _log.info("执行get请求:...." + get.getURI());
            CloseableHttpResponse httpResponse = null;
            //发送get请求
            httpResponse = client.execute(get);
            try {
                //response实体
                HttpEntity entity = httpResponse.getEntity();
                if (null != entity) {
                    resp = EntityUtils.toString(entity);
                    _log.info("响应内容:" + resp);
                }
            } finally {
                httpResponse.close();
            }
        } catch (IOException | ParseException e) {
            e.printStackTrace();
        } finally {
            try {
                if (client != null) {
                    client.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return resp;
    }
     
}
