package com.ruiqt.lianlian.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ruiqt.lianlian.enums.SignTypeEnum;
import com.ruiqt.lianlian.security.Md5Algorithm;
import com.ruiqt.lianlian.security.TraderRSAUtil;

/**
* 常用工具函数
* @author zhanglei
* @date:2013-6-25 下午05:23:05
* @version :1.0
*
*/
public class LLPayUtil{
    /**
     * str空判断
     * @param str
     * @return
     * @author guoyx
     */
    public static boolean isnull(String str)
    {
        if (null == str || str.equalsIgnoreCase("null") || str.equals(""))
        {
            return true;
        } else
            return false;
    }

    /**
     * 生成待签名串
     * @param paramMap
     * @return
     * @author guoyx
     */
    public static String genSignData(JSONObject jsonObject)
    {
        StringBuffer content = new StringBuffer();

        // 按照key做首字母升序排列
        List<String> keys = new ArrayList<String>(jsonObject.keySet());
        Collections.sort(keys, String.CASE_INSENSITIVE_ORDER);
        for (int i = 0; i < keys.size(); i++)
        {
            String key = (String) keys.get(i);
            if ("sign".equals(key))
            {
                continue;
            }
            String value = jsonObject.getString(key);
            // 空串不参与签名
            if (isnull(value))
            {
                continue;
            }
            content.append((i == 0 ? "" : "&") + key + "=" + value);

        }
        String signSrc = content.toString();
        if (signSrc.startsWith("&"))
        {
            signSrc = signSrc.replaceFirst("&", "");
        }
        return signSrc;
    }
    /**
     * 加签
     * 
     * @param reqObj
     * @param rsa_private
     * @param md5_key
     * @return
     * @author guoyx
     */
    public static String addSign(JSONObject reqObj, String rsa_private,
            String md5_key)
    {
        if (reqObj == null)
        {
            return "";
        }
        String sign_type = reqObj.getString("sign_type");
        if (SignTypeEnum.MD5.getCode().equals(sign_type))
        {
            return addSignMD5(reqObj, md5_key);
        } else
        {
            return addSignRSA(reqObj, rsa_private);
        }
    }

    /**
     * 签名验证
     * 
     * @param reqStr
     * @return
     */
    public static boolean checkSign(String reqStr, String rsa_public, String md5_key)
    {
    	JSONObject reqObj = JSON.parseObject(reqStr);
        if (reqObj == null)
        {
            return false;
        }
        String sign_type = reqObj.getString("sign_type");
        if (SignTypeEnum.MD5.getCode().equals(sign_type))
        {
            return checkSignMD5(reqObj, md5_key);
        } else
        {
            return checkSignRSA(reqObj, rsa_public);
        }
    }

    /**
     * RSA签名验证
     * 
     * @param reqObj
     * @return
     * @author guoyx
     */
    private static boolean checkSignRSA(JSONObject reqObj, String rsa_public)
    {

       /* System.out.println("进入商户[" + reqObj.getString("oid_partner")
                + "]RSA签名验证");*/
        if (reqObj == null)
        {
            return false;
        }
        String sign = reqObj.getString("sign");
        // 生成待签名串
        String sign_src = genSignData(reqObj);
    /*    System.out.println("商户[" + reqObj.getString("oid_partner") + "]待签名原串"
                + sign_src);
        System.out.println("商户[" + reqObj.getString("oid_partner") + "]签名串"
                + sign);*/
        try
        {
            if (TraderRSAUtil.checksign(rsa_public, sign_src, sign))
            {
               /* System.out.println("商户[" + reqObj.getString("oid_partner")
                        + "]RSA签名验证通过");*/
                return true;
            } else
            {
               /* System.out.println("商户[" + reqObj.getString("oid_partner")
                        + "]RSA签名验证未通过");*/
                return false;
            }
        } catch (Exception e)
        {
        	e.printStackTrace();
            /*System.out.println("商户[" + reqObj.getString("oid_partner")
                    + "]RSA签名验证异常" + e.getMessage());*/
            return false;
        }
    }

    /**
     * MD5签名验证
     * 
     * @param signSrc
     * @param sign
     * @return
     * @author guoyx
     */
    private static boolean checkSignMD5(JSONObject reqObj, String md5_key)
    {
        /*System.out.println("进入商户[" + reqObj.getString("oid_partner")
                + "]MD5签名验证");*/
        if (reqObj == null)
        {
            return false;
        }
        String sign = reqObj.getString("sign");
        // 生成待签名串
        String sign_src = genSignData(reqObj);
        /*System.out.println("商户[" + reqObj.getString("oid_partner") + "]待签名原串"
                + sign_src);
        System.out.println("商户[" + reqObj.getString("oid_partner") + "]签名串"
                + sign);*/
        sign_src += "&key=" + md5_key;
        //System.out.println("sign_src:" + sign_src);
        try
        {
        	/*System.out.println(Md5Algorithm.getInstance().md5Digest(
                    sign_src.getBytes("utf-8")));*/
            if (sign.equals(Md5Algorithm.getInstance().md5Digest(
                    sign_src.getBytes("utf-8"))))
            {
                //System.out.println("MD5签名验证通过");
                return true;
            } else
            {
                //System.out.println("MD5签名验证未通过");
                return false;
            }
        } catch (UnsupportedEncodingException e)
        {
        	e.printStackTrace();
           /* System.out.println("商户[" + reqObj.getString("oid_partner")
                    + "]MD5签名验证异常" + e.getMessage());*/
            return false;
        }
    }

    /**
     * RSA加签名
     * 
     * @param reqObj
     * @param rsa_private
     * @return
     * @author guoyx
     */
    private static String addSignRSA(JSONObject reqObj, String rsa_private)
    {
        if (reqObj == null)
        {
            return "";
        }
        // 生成待签名串
        String sign_src = genSignData(reqObj);
        try
        {
            return TraderRSAUtil.sign(rsa_private, sign_src);
        } catch (Exception e)
        {
        	e.printStackTrace();
            return "";
        }
    }

    /**
     * MD5加签名
     * 
     * @param reqObj
     * @param md5_key
     * @return
     * @author guoyx
     */
    private static String addSignMD5(JSONObject reqObj, String md5_key)
    {
        if (reqObj == null)
        {
            return "";
        }
        // 生成待签名串
        String sign_src = genSignData(reqObj);
        sign_src += "&key=" + md5_key;
        try
        {
            return Md5Algorithm.getInstance().md5Digest(
                    sign_src.getBytes("utf-8"));
        } catch (Exception e)
        {
        	e.printStackTrace();
            return "";
        }
    }

    /**
     * 读取request流
     * @param req
     * @return
     * @author guoyx
     */
    public static String readReqStr(HttpServletRequest request)
    {
        StringBuilder sb = new StringBuilder();
        try
        {
        	BufferedReader reader = new BufferedReader(new InputStreamReader(request
        			.getInputStream(), "utf-8"));
            String line = null;

            while ((line = reader.readLine()) != null)
            {
                sb.append(line);
            }
            reader.close();
        } catch (IOException e)
        {
            e.printStackTrace();
        }/* finally
        {
            try
            {
                if (null != reader)
                {
                    reader.close();
                }
            } catch (IOException e)
            {

            }
        }*/
        return sb.toString();
        //return loadSession(sb.toString());
    }
    
    /**
     * 设置request流
     * @param request
     * @return
     * @author zhanglei
     */
    public static String setRequest(HttpServletRequest request){
    	String reqStr=LLPayUtil.readReqStr(request);
    	JSONObject reqObj = JSON.parseObject(reqStr);
    	reqObj.put("sign_type", PartnerConfig.SIGN_MD5_TYPE);
    	String sign=addSignMD5(reqObj,PartnerConfig.MD5_KEY);
    	reqObj.put("sign", sign);
    	//String jsonString = reqObj.toJSONString();
    	//System.out.println(jsonString);
    	return reqObj.toJSONString();
    	
    }
    
    /**
     * 处理请求参数：解析请求参数，如果不含有u参数，则根据sessionid参数，读取session中的username作为u参数传递
     * 给后端
     * @param reqStr
     * @return
     */
//    public static String loadSession(String reqStr){
//    	JSONObject reqObj = JSON.parseObject(reqStr);
//    	String username = reqObj.getString("u");
//    	if(StringUtils.isEmpty(username)){
//    		String sessionid = reqObj.getString("sessionid");
//    		System.out.println(sessionid);
//        	String usernameFromSession = SessionUtil.getUserName(sessionid);
//        	System.out.println(usernameFromSession);
//        	reqObj.put("u", usernameFromSession);
//    	}
//    	//测试
//    	String jsonString = reqObj.toJSONString();
//    	System.out.println(jsonString);
//    	return reqObj.toJSONString();
//    }
    
    //签名验证返回JSONObject
    public static net.sf.json.JSONObject getJSONObject(HttpServletRequest request){
    	String reqStr = LLPayUtil.readReqStr(request);
    	if(reqStr == null || reqStr.equals("")){
    		reqStr = "{}";
    	}
    	//System.out.println("reqStr:"+reqStr);
		// if (checkSign(reqStr, PartnerConfig.YT_PUB_KEY,
		//		PartnerConfig.MD5_KEY)){
			 return net.sf.json.JSONObject.fromObject(reqStr);
		// }else{
		//	return null;
		//}
	}
    
    /**
     * 将request 转成map
     * @author wangya
     * @param request
     * @return
     */
    public static Map<String, String> parse2Map(HttpServletRequest request) {
    	Map<String, String> map = new HashMap<String, String>();
		Enumeration<?> enume = request.getParameterNames();
		while(enume.hasMoreElements()){
			Object item = enume.nextElement();
			String paramName = item.toString();
			String value = request.getParameter(paramName);
			String[] values = request.getParameterValues(paramName);
			if(values.length>1){
				String va=values[0];
				for(int i=1;i<values.length;i++){
					va+=","+values[i];
				}
				value=va;
			}
			map.put(paramName, value);
		}
		return map;
	}
}
