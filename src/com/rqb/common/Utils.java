package com.rqb.common;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

/**
 * 工具类
 * JsonObject 转 map
 * @author wangya
 * @since 2016-08-15
 */
public class Utils {
	
	public static void JsonObject2HashMap(JSONObject jo, List<Map<?, ?>> rstList) {  
        for (Iterator<String> keys = jo.keys(); keys.hasNext();) {  
            try {  
                String key1 = keys.next();  
                System.out.println("key1---" + key1 + "------" + jo.get(key1)  
                        + (jo.get(key1) instanceof JSONObject) + jo.get(key1)  
                        + (jo.get(key1) instanceof JSONArray));  
                if (jo.get(key1) instanceof JSONObject) {  
  
                    JsonObject2HashMap((JSONObject) jo.get(key1), rstList);  
                    continue;  
                }  
                if (jo.get(key1) instanceof JSONArray) {  
                    JsonArray2HashMap((JSONArray) jo.get(key1), rstList);  
                    continue;  
                }  
                System.out.println("key1:" + key1 + "----------jo.get(key1):"  
                        + jo.get(key1));  
                json2HashMap(key1, jo.get(key1), rstList);  
  
            } catch (JSONException e) {  
                e.printStackTrace();  
            }  
  
        }  
  
    }  
    public static void JsonArray2HashMap(JSONArray joArr,  
            List<Map<?, ?>> rstList) {  
        for (int i = 0; i < joArr.size(); i++) {
            try {  
                if (joArr.get(i) instanceof JSONObject) {  
  
                    JsonObject2HashMap((JSONObject) joArr.get(i), rstList);  
                    continue;  
                }  
                if (joArr.get(i) instanceof JSONArray) {  
  
                    JsonArray2HashMap((JSONArray) joArr.get(i), rstList);  
                    continue;  
                }  
                System.out.println("Excepton~~~~~");  
  
            } catch (JSONException e) {  
                e.printStackTrace();  
            }  
  
        }  
  
    }  
  
    public static void json2HashMap(String key, Object value,  
            List<Map<?, ?>> rstList) {  
        HashMap<String, Object> map = new HashMap<String, Object>();  
        map.put(key, value);  
        rstList.add(map);  
    }
    
    public static Map<String, String> parserToMap(JSONObject json, Map<String, String> map){  
        Iterator keys=json.keys();  
        while(keys.hasNext()){  
            String key=(String) keys.next();  
            String value=json.get(key)==null?"":json.get(key).toString();  
            map.put(key, value);  
        }  
        return map;  
    }  
}
