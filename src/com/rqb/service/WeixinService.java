package com.rqb.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.rqb.common.ConfigManager;
import com.rqb.common.Constants.Pks;
import com.rqb.dto.WxInfoDto;
import com.rqb.service.abs.AbstractService;
import com.ruiqt.lianlian.utils.HttpsUtils;
import com.ultrapower.cloudup.utils.EmptyUtils;
import com.ultrapower.cloudup.utils.StringUtils;

@Service
public class WeixinService  extends AbstractService{
	private static ConfigManager config = ConfigManager.getInstance();
	private static final String MSG_NULL = "";
	private static final String EVENT_SUBSCRIBE = "subscribe";
	private static Long SAVE_WITH_COUNT;
	private static Long DEFAULT_SAVE_WITH_COUNT = 100l;
	private static String APP_ID;
	private static String APP_SECRET;
	private static String path;
	private static Map<String, WxInfoDto> countMap;
	
	private static int VISIT_COUNT = 0;
	
	static{
		path = WeixinService.class.getClassLoader().getResource("share_result.txt").getPath();
		APP_ID = config.get(Pks.WEIXIN_APP_ID);
		APP_SECRET = config.get(Pks.WEIXIN_APP_SECRET);
		SAVE_WITH_COUNT = StringUtils.parseLong(config.get(Pks.SAVE_WITH_VISIT_COUNT));
		
		if(EmptyUtils.isEmpty(SAVE_WITH_COUNT) || SAVE_WITH_COUNT < 0){
			SAVE_WITH_COUNT = DEFAULT_SAVE_WITH_COUNT;
		}
		countMap = new HashMap<String, WxInfoDto>();
		load();
	}
	
	public static void load(){
		_log.info("system load result");
		File file = new File(path);
		if(!file.exists()){
			_log.info("nothing to load");
			return;
		}
		BufferedReader br = null;
		try{
			br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "utf-8"));
			String result = "";
			String line;
            while ((line = br.readLine()) != null) {
                result += line;
            }
            
            JSONObject map_jo = JSONObject.fromObject(result);
            for(Object key : map_jo.keySet()){
            	WxInfoDto dto = new WxInfoDto();
            	JSONObject dto_jo = map_jo.getJSONObject(key.toString());
            	dto.setName(dto_jo.getString("name"));
            	dto.setOpenid(dto_jo.getString("openid"));
            	try {
					dto.setDate(new Date(StringUtils.parseLong(dto_jo.getJSONObject("date").getString("time"))));
					dto.setCount(StringUtils.parseLong(dto_jo.getString("count")));
				} catch (Exception e) {}
            	countMap.put(key.toString(), dto);
            }
		}catch (Exception e) {
			_log.error("load result error -> " + e);
			e.printStackTrace();
		}finally{
			try {
				if(br != null){
					br.close();
				}
			} catch (IOException e) {
				_log.error("close file error -> " + e);
				e.printStackTrace();
			}
		}
	}
	
	public static void save(){
		_log.info("system save result");
		String json = JSONObject.fromObject(countMap).toString();
		File file = new File(path);
		OutputStream out = null;
		try{
			if(!file.exists()){
				file.createNewFile();
			}
			out = new FileOutputStream(file);
			out.write(json.getBytes("utf-8"));
		}catch (Exception e) {
			_log.error("save result error -> " + e);
			e.printStackTrace();
		}finally{
			try {
				if(out != null){
					out.close();
				}
			} catch (IOException e) {
				_log.error("close file error -> " + e);
				e.printStackTrace();
			}
		}
		
		config.config();
		SAVE_WITH_COUNT = StringUtils.parseLong(config.get(Pks.SAVE_WITH_VISIT_COUNT));
		
		if(EmptyUtils.isEmpty(SAVE_WITH_COUNT) || SAVE_WITH_COUNT < 0){
			SAVE_WITH_COUNT = DEFAULT_SAVE_WITH_COUNT;
		}
	}
	
	public String valid(String echostr){
		return echostr;
	}
	
	public String getOpenId(String code){
		String params = "appid=" + APP_ID + "&secret=" + APP_SECRET + "&code=" 
				+ code + "&grant_type=authorization_code";
		_log.info("request to weixin for openid -> params = " + params);
		String result = HttpsUtils.sendPost(config.get(Pks.WEIXIN_CHECK_CODE_URL), params);
		_log.info("request to weixin for openid -> result = " + result);
		
		JSONObject result_jo = JSONObject.fromObject(result);
		try {
			if(result_jo.containsKey("openid")){
				String openid = result_jo.getString("openid");
				WxInfoDto dto = countMap.get(openid);
				if(dto == null){
					dto = new WxInfoDto();
					dto.setOpenid(openid);
				}
				
				if(dto.getName() == null && result_jo.containsKey("access_token")){
					String accessToken = result_jo.getString("access_token");
					String userParams = "access_token=" + accessToken + "&openid=" + openid;
					_log.info("request to weixin for userinfo -> params = " + userParams);
					String userInfo = HttpsUtils.sendGet(config.get(Pks.WEIXIN_USER_INFO_URL), userParams);
					_log.info("request to weixin for userinfo -> result = " + userInfo);
					JSONObject userInfo_jo = JSONObject.fromObject(userInfo);
					if(userInfo_jo.containsKey("nickname")){
						//获取用户信息
						dto.setName(userInfo_jo.getString("nickname"));
					}
				}
				
				countMap.put(openid, dto);
			}
		} catch (Exception e) { 
			_log.error("analyze weixin result error -> " + result);
		}
		
		return result;
	}
	
	public void visit(String openId, String addr){
		if(openId == null || "undefined".equals(openId) || "null".equals(openId)){
			return;
		}
		if(countMap.get(openId) != null){
			countMap.get(openId).visit();
		}else{
			WxInfoDto dto = new WxInfoDto();
			dto.setOpenid(openId);
			dto.visit();
			countMap.put(openId, dto);
		}
		VISIT_COUNT ++;
		if(VISIT_COUNT >= SAVE_WITH_COUNT){
			save();
			VISIT_COUNT = 0;
		}
		_log.fatal("visit share page -> address = " + addr + ", openid = " + openId);
	}
	
	public List<WxInfoDto> getResult(){
		List<WxInfoDto> list = new ArrayList<WxInfoDto>();
		list.addAll(countMap.values());
		Collections.sort(list);
		return list;
	}
	
	public String getReturnMsg(Document doc){
		String result = MSG_NULL;
		
		NodeList eventsList = doc.getElementsByTagName("Event");
		NodeList appUserList = doc.getElementsByTagName("ToUserName");
		NodeList clientUserList = doc.getElementsByTagName("FromUserName");
		NodeList createTimeList = doc.getElementsByTagName("CreateTime");
		
		if(eventsList.getLength() == 0 || appUserList.getLength() == 0 || clientUserList.getLength() == 0 || createTimeList.getLength() == 0){
			return result;
		}
		
		String event = eventsList.item(0).getFirstChild().getNodeValue();
		String appUser = appUserList.item(0).getFirstChild().getNodeValue();
		String clientUser = clientUserList.item(0).getFirstChild().getNodeValue();
		String createTime = createTimeList.item(0).getFirstChild().getNodeValue();
		
		if(!EVENT_SUBSCRIBE.equals(event)){
			return result;
		}
		
		String xml = "<xml>";
		xml += "<ToUserName>" + clientUser + "</ToUserName>";
		xml += "<FromUserName>" + appUser + "</FromUserName>";
		xml += "<CreateTime>" + createTime + "</CreateTime>";
		xml += "<MsgType>text</MsgType>";
		xml += "<Content>尊敬的用户，有问题请联系客服：\nQQ群：421348328\n客服电话：400-082-7002</Content>";
		xml += "</xml>";
		
		return xml;
	}
}
