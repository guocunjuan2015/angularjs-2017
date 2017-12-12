package com.ruiqt.lianlian.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.SocketTimeoutException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ClientConnectionRequest;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.entity.StringEntity;
import org.apache.http.message.BasicHeader;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.protocol.HTTP;
import org.apache.log4j.Logger;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;

import com.rqb.common.SpringContextHolder;
import com.ruiqt.lianlian.conn.CustomHttpClient;

public class RqbHttpUtils {
	public static HttpClient httpClient = SpringContextHolder.getBean("httpClient");
	private static Logger log = Logger.getLogger(RqbHttpUtils.class);
	
	public static int connectionTimeout=3000;
	public static int socketTimeout=8000;
	public static int poolTimeout=1000;
	/*
	 setConnectTimeout：设置连接超时时间，单位毫秒。
setConnectionRequestTimeout：设置从connect Manager获取Connection 超时时间，单位毫秒。
这个属性是新加的属性，因为目前版本是可以共享连接池的。
setSocketTimeout：请求获取数据的超时时间，单位毫秒。
 如果访问一个接口，多少时间内无法返回数据，就直接放弃此次调用。
	 */

	public static String postSendHttp(String url, String body) {
		long start = System.currentTimeMillis();
		if (url == null || "".equals(url)) {
			log.debug("request url is empty.");
			return null;
		}
		//HttpClient httpClient = CustomHttpClient.GetHttpClient();
		HttpPost post = new HttpPost(url);
		RequestConfig requestConfig = RequestConfig.custom()  
		        .setConnectTimeout(connectionTimeout).setConnectionRequestTimeout(poolTimeout)  
		        .setSocketTimeout(socketTimeout).build();  
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
				log.debug("请求[" + url + "]消耗时间 " + (end - start) + "毫秒");
				resultString = responseString.toString();
			}
		} catch (ConnectTimeoutException cte) {
			log.error("微信链接超时",cte);
		} catch (SocketTimeoutException cte) {
			log.error("微信读取超时",cte);
		} catch (Exception e) {
			log.error("微信remote request错误",e);
		} finally {
			// 释放连接
			post.releaseConnection();
		}
		return resultString;
	}
}
