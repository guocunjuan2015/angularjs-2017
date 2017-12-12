package com.rqb.controller;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rqb.common.Constants.Msg;
import com.rqb.common.WeiXinConfig;
import com.rqb.controller.abs.AbstractController;

/**
 * 微信签名算法
 * @author wangliupeng
 *
 */
@Controller
@RequestMapping(value = "/weixin")
public class WeiXinSignController extends AbstractController{

	/**
	 * 获取微信签名 json
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 */
	@RequestMapping(value = "/getSignature.do")
	public void getSignature(HttpServletRequest request, HttpServletResponse response) {
		String jsapi_ticket = WeiXinConfig.getJsapiticket();
		System.out.println(jsapi_ticket);
		_log.info("jsapi_ticket:" + jsapi_ticket);
		String url = request.getParameter("url");
		_log.info("url - >:" + url);
		 
        Map<String, String> ret = sign(jsapi_ticket, url);
        ret.put("appId", WeiXinConfig.APPID);
        String result = JSONObject.fromObject(ret).toString();
        sendResponse(true, Msg.SUCCESS, result, response);
	}

	/**
	 * 签名选法
	 * @param jsapi_ticket 微信ticket
	 * @param url 当前页面URL
	 * @return 对string1作sha1加密，原数据｛noncestr、jsapi_ticket、timestamp、url｝及signature的Map集合
	 */
    private static Map<String, String> sign(String jsapi_ticket, String url) {
        Map<String, String> ret = new HashMap<String, String>();
        String nonce_str = create_nonce_str();
        String timestamp = create_timestamp();
        String string1;
        String signature = "";

        //注意这里参数名必须全部小写，且必须有序
        string1 = "jsapi_ticket=" + jsapi_ticket +
                  "&noncestr=" + nonce_str +
                  "&timestamp=" + timestamp +
                  "&url=" + url;
        System.out.println(string1);
        _log.info(string1);

        try
        {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(string1.getBytes("UTF-8"));
            signature = byteToHex(crypt.digest());
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        catch (UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }

        ret.put("url", url);
        ret.put("jsapi_ticket", jsapi_ticket);
        ret.put("nonceStr", nonce_str);
        ret.put("timestamp", timestamp);
        ret.put("signature", signature);
        _log.info("url:" + url);
        _log.info("jsapi_ticket:" + jsapi_ticket);
        _log.info("nonceStr:" + nonce_str);
        _log.info("timestamp:" + timestamp);
        _log.info("signature:" + signature);

        return ret;
    }

    private static String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }

    private static String create_nonce_str() {
        return UUID.randomUUID().toString();
    }

    private static String create_timestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }
}
