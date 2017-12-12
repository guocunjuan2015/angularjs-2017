package com.rqb.rlife.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rqb.common.ConfigManager;
import com.rqb.common.Constants.Pks;
import com.rqb.controller.abs.AbstractController;
import com.rqb.common.JsonUtil;
import com.rqb.common.Utils;
import com.ruiqt.lianlian.utils.LLPayUtil;
import com.ruiqt.lianlian.utils.OperateResult;

import net.sf.json.JSONObject;

/**
 * App 积分控制类
 * @author wangya
 * @since 2016-08-08
 */
@Controller
@RequestMapping(value = "appPoint")
public class AppPointController extends AbstractController {
	
	private Logger logger = Logger.getLogger(AppPointController.class);
	
	/**
	 * 获取用户可用积分
	 * @author wangya
	 * @since 2016-08-15
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getAvailablePoints.do", method = RequestMethod.POST)
	@ResponseBody
	public String getAvailablePoints(HttpServletRequest request, 
    		HttpServletResponse response) {
		Map<String, String> map = LLPayUtil.parse2Map(request);
		try {
			String target = ConfigManager.getInstance().getRlife(Pks.RLIFE_POINT_GETAVAILABLEPOINTS);
			String json = AbstractController.post(target, map);
			logger.debug("获取积分----》 " + json);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return JsonUtil.bean2json(new OperateResult(0, "温馨提示-服务器错误"));
		}
	}
	
	/**
	 * 获取用户vip级别
	 * @author wangya
	 * @since 2016-08-15
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getVipLevel.do", method = RequestMethod.POST)
	@ResponseBody
	public String getVipLevel(HttpServletRequest request, 
    		HttpServletResponse response) {
		Map<String, String> map = LLPayUtil.parse2Map(request);
		try {
			String target = ConfigManager.getInstance().getRlife(Pks.RLIFE_POINT_GETVIPLEVEL);
			String json = AbstractController.post(target, map);
			logger.debug("获取积分----》 " + json);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return JsonUtil.bean2json(new OperateResult(0, "温馨提示-服务器错误"));
		}
	}

}
