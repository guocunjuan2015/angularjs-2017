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
import com.rqb.common.JsonUtil;
import com.rqb.common.Utils;
import com.rqb.common.Constants.Pks;
import com.rqb.controller.abs.AbstractController;
import com.ruiqt.lianlian.utils.LLPayUtil;
import com.ruiqt.lianlian.utils.OperateResult;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

/**
 * app 瑞生活商品控制类
 * @author wangya
 * @since 2016-08-02
 *
 */
@Controller
@RequestMapping(value = "appRlifeGoods")
public class AppRlifeGoodsController {
	
	private Logger logger = Logger.getLogger(AppRlifeGoodsController.class);
	
	/**
	 * 获取商品列表信息
	 * @author wangya
	 * @since 2016-08-02
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/rLifeGoodsList.do", method = RequestMethod.POST)
	@ResponseBody
    public String getRLifeGoodsList(HttpServletRequest request, 
    		HttpServletResponse response) {
		String kind = request.getParameter("kind");
		System.out.println("kind-----------> " + kind);
		Map<String, String> map = LLPayUtil.parse2Map(request);
		try {
			String target = ConfigManager.getInstance().getRlife(Pks.RLIFE_GOODS_RLIFEGOODSLIST);
			System.out.println("接收参数---getRLifeGoodsList---" + JsonUtil.bean2json(map));
			String json = AbstractController.post(target, map);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return JsonUtil.bean2json(new OperateResult(0, "温馨提示-服务器错误"));
		}
    }
	
	/**
	 * 获取商品详情信息
	 * @author wangya
	 * @since 2016-08-02
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/rLifeGood.do", method = RequestMethod.POST)
	@ResponseBody
    public String getRlifeGood(HttpServletRequest request, 
    		HttpServletResponse response) {
		Map<String, String> map = LLPayUtil.parse2Map(request);
		try {
			String target = ConfigManager.getInstance().getRlife(Pks.RLIFE_GOODS_RLIFEGOOD);
			System.out.println("接收参数---getRlifeGood---" + JsonUtil.bean2json(map));
			String json = AbstractController.post(target, map);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return JsonUtil.bean2json(new OperateResult(0, "温馨提示-服务器错误"));
		}
    }
	
	/**
	 * 获取商品详情信息
	 * @author wangya
	 * @since 2016-08-02
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getGoodsByType.do", method = RequestMethod.POST)
	@ResponseBody
    public String getGoodsByType(HttpServletRequest request, 
    		HttpServletResponse response) {
		Map<String, String> map = LLPayUtil.parse2Map(request);
		try {
			String target = ConfigManager.getInstance().getRlife(Pks.RLIFE_GOODS_GETGOODSBYTYPE);
			System.out.println("接收参数---getGoodsByType---" + JsonUtil.bean2json(map));
			String json = AbstractController.post(target, map);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return JsonUtil.bean2json(new OperateResult(0, "温馨提示-服务器错误"));
		}
    }

}
