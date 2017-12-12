package com.rqb.controller.abs;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import com.ultrapower.cloudup.common.abs.Component;
import com.ultrapower.cloudup.utils.EmptyUtils;

public abstract class AbstractController {
	protected static Logger _log = Logger.getRootLogger();
	protected static String LOGIN_PAGE = "login.jsp";
	
	/**
	 * 返回结果
	 * @param success 是否运行成功
	 * @param msg 说明
	 * @param result 结果
	 * @param jsonp js方法
	 * @param response 当前响应
	 */
	protected void sendResponse(Boolean success, String msg, Object result, String jsonp, HttpServletResponse response){
		response.setContentType("application/json;charset=UTF-8");
		//可以实现本地html请求
		//response.addHeader("Access-Control-Allow-Origin", "null");
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("success", success);
		returnMap.put("msg", msg);
		returnMap.put("result", result);
		
		String returnStr = JSONObject.fromObject(returnMap).toString();
		try {
			if(EmptyUtils.isEmpty(jsonp)){
				response.getWriter().print(returnStr);
			}else{
				response.getWriter().print(jsonp + "(" + returnStr + ")");
			}
		} catch (IOException e) {
			_log.error("send response error -> " + e);
			e.printStackTrace();
		}
	}
	
	/**
	 * 返回结果
	 * @param success 是否运行成功
	 * @param msg 说明
	 * @param result 结果
	 * @param response 当前响应
	 */
	protected void sendResponse(Boolean success, String msg, Object result, HttpServletResponse response){
		sendResponse(success, msg, result, null, response);
	}
	
	/**
	 * 返回结果
	 * @param component 运行的控件
	 * @param result 结果
	 * @param response 当前响应
	 */
	protected void sendResponse(Component component, Object result, HttpServletResponse response){
		sendResponse(component, result, null, response);
	}
	
	/**
	 * 返回结果
	 * @param component 运行的控件
	 * @param result 结果
	 * @param jsonp js方法
	 * @param response 当前响应
	 */
	protected void sendResponse(Component component, Object result, String jsonp, HttpServletResponse response){
		sendResponse(component.success(), component.getMsg(), result, jsonp, response);
	}
	
	/**
	 * 解析uri编码
	 * @param str 需要编码的字符串
	 * @return 如果编码错误，则返回null
	 */
	protected String decode(String str){
		String target = null;
		try {
			target = URLDecoder.decode(str, "utf-8");
		} catch (Exception e) {
			_log.info("param decode error");
		}
		return target;
	}
	
	public static String post(String url, Map<String, String> params) {  
        DefaultHttpClient httpclient = new DefaultHttpClient();  
        String body = null;
          
        _log.info("create httppost:" + url);  
        HttpPost post = postForm(url, params);  
          
        body = invoke(httpclient, post);  
          
        httpclient.getConnectionManager().shutdown();  
          
        return body;  
    }
	
	private static HttpPost postForm(String url, Map<String, String> params){  
        
        HttpPost httpost = new HttpPost(url);
        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
          
        Set<String> keySet = params.keySet();  
        for(String key : keySet) {
            nvps.add(new BasicNameValuePair(key, params.get(key)));  
        }  
          
        try {
        	_log.info("set utf-8 form entity to httppost");  
            httpost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));  
        } catch (UnsupportedEncodingException e) {  
            e.printStackTrace();  
        }  
          
        return httpost;  
    }
	
	private static String invoke(DefaultHttpClient httpclient,  
            HttpUriRequest httpost) {  
          
        HttpResponse response = sendRequest(httpclient, httpost);  
        String body = paseResponse(response);  
          
        return body;  
    }
	
	private static HttpResponse sendRequest(DefaultHttpClient httpclient,  
            HttpUriRequest httpost) {  
        _log.info("execute post...");  
        HttpResponse response = null;  
          
        try {  
            response = httpclient.execute(httpost);  
        } catch (ClientProtocolException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        return response;  
    }
  
    private static String paseResponse(HttpResponse response) {  
        _log.info("get response from http server..");  
        HttpEntity entity = response.getEntity();  
          
        _log.info("response status: " + response.getStatusLine());  
        String charset = EntityUtils.getContentCharSet(entity);  
        _log.info(charset);  
          
        String body = null;  
        try {  
            body = EntityUtils.toString(entity);  
            _log.info(body);  
        } catch (ParseException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
          
        return body;  
    }
    
    public String getResult(int result, String message){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("errInfo", message); 
		param.put("result", result); 
		String res = com.alibaba.fastjson.JSONObject.toJSONString(param);
		return res;
	}
}
