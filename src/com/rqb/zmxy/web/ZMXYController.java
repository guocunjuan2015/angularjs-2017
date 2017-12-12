package com.rqb.zmxy.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson.JSONObject;
import com.rqb.controller.abs.AbstractController;
import com.rqb.zmxy.service.ZmxyService;
import com.ruiqt.lianlian.utils.HttpsUtils;
import com.ruiqt.lianlian.utils.LLPayUtil;

/**
 * 芝麻信用
 * @author wangya
 *
 */
@Controller
@RequestMapping(value = "zmxy")
public class ZMXYController extends AbstractController {
	
	private Logger logger = Logger.getLogger(ZMXYController.class);
	
	@Resource
    private ZmxyService zmxyService;

	/**
     * 芝麻信用授权(H5)
     *
     * @param response
     * @param request
     */
    @RequestMapping(value = "ZMAuthorization.do")
    public void ZMAuthorization(HttpServletResponse response, HttpServletRequest request) {
    	Map<String, Object> params = new HashMap<String, Object>();
    	String userId = (String) request.getSession().getAttribute("userId");
		String info = "";
		try {
			if (null != userId && !"".equals(userId)) {
				params.put("userId", userId);
				params.put("platform", "H5");
				info = zmxyService.ZMAuthorization(params);
				sendResponse(zmxyService, info, response);
			} else {
				String result = getResult(0,"温馨提示-您还未登录,请先登录");
				sendResponse(zmxyService, result, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			String result = getResult(0,"温馨提示-服务器错误,请稍候重试");
			sendResponse(zmxyService, result, response);
		}
    }
    
    public String getResult(int result, String message){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("errInfo", message); 
		param.put("result", result); 
		String res = JSONObject.toJSONString(param);
		return res;
	}
}
