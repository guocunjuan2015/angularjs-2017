package com.rqb.rlife.web;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
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

/**
 * App 订单控制类
 * @author wangya
 * @since 2016-08-03
 */
@Controller
@RequestMapping(value = "appRlifeOrder")
public class AppRlifeOrderController {
	
	private Logger logger = Logger.getLogger(AppRlifeOrderController.class);

	/**
	 * 获取参与项目活动的人数
	 * @author wangya
	 * @since 2016-08-08
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getPartInCount.do", method = RequestMethod.POST)
	@ResponseBody
	public String getPartInCount(HttpServletRequest request, 
    		HttpServletResponse response) {
		Map<String, String> map = LLPayUtil.parse2Map(request);
		try {
			String target = ConfigManager.getInstance().getRlife(Pks.RLIFE_GOODS_GETPARTINCOUNT);
			String json = AbstractController.post(target, map);
			logger.debug("获取商品列表信息----》 " + json);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return JsonUtil.bean2json(new OperateResult(0, "温馨提示-服务器错误"));
		}
	}
	
	/**
	 * 报名参加活动
	 * @author wangya
	 * @since 2016-08-08
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/signUp.do", method = RequestMethod.POST)
	@ResponseBody
	public String signUp(HttpServletRequest request, 
    		HttpServletResponse response) {
		Map<String, String> map = LLPayUtil.parse2Map(request);
		try {
			String target = ConfigManager.getInstance().getRlife(Pks.RLIFE_GOODS_SIGNUP);
			String json = AbstractController.post(target, map);
			logger.debug("获取商品列表信息----》 " + json);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return JsonUtil.bean2json(new OperateResult(0, "温馨提示-服务器错误"));
		}
	}
	
	/**
	 * 判断用户是否参加过活动
	 * @author wangya
	 * @since 2016-08-08
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/isAttendedActive.do", method = RequestMethod.POST)
	@ResponseBody
	public String isAttendedActive(HttpServletRequest request, 
    		HttpServletResponse response) {
		Map<String, String> map = LLPayUtil.parse2Map(request);
		try {
			String target = ConfigManager.getInstance().getRlife(Pks.RLIFE_GOODS_ISATTENDEDACTIVE);
			System.out.println("接收参数---isAttendedActive-----》 " + JsonUtil.bean2json(map));
			String json = AbstractController.post(target, map);
			logger.debug("获取商品列表信息----》 " + json);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return JsonUtil.bean2json(new OperateResult(0, "温馨提示-服务器错误"));
		}
	}
	
	/**
	 * 瑞友汇, vip, 积分兑换方法
	 * @author wangya
	 * @since 2016-08-08
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
    @RequestMapping(value = "/exchange.do", method=RequestMethod.POST)
    @ResponseBody
    public String exchange(HttpServletRequest request, 
    		HttpServletResponse response) {
    	Map<String, String> map = LLPayUtil.parse2Map(request);
		try {
			String target = ConfigManager.getInstance().getRlife(Pks.RLIFE_GOODS_EXCHANGE);
			String json = AbstractController.post(target, map);
			logger.debug("获取商品列表信息----》 " + json);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return JsonUtil.bean2json(new OperateResult(0, "温馨提示-服务器错误"));
		}
    }
    
    /**
	 * 更新订单状态
	 * @author wangya
	 * @since 2016-08-09
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
    @RequestMapping(value = {"/updateROrder.do"})
    @ResponseBody
    public String updateROrder(HttpServletRequest request, 
    		HttpServletResponse response) {
    	Map<String, String> map = LLPayUtil.parse2Map(request);
		try {
			String target = ConfigManager.getInstance().getRlife(Pks.RLIFE_GOODS_UPDATERORDER);
			String json = AbstractController.post(target, map);
			logger.debug("获取商品列表信息----》 " + json);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return JsonUtil.bean2json(new OperateResult(0, "温馨提示-服务器错误"));
		}
    }
    
    /**
	 * 获取用户参与的瑞服务、瑞友汇、vip、积分
	 * @author wangya
	 * @since 2016-08-11
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/getUserROrderList.do", method = RequestMethod.POST)
	@ResponseBody
	public String getUserROrderList(HttpServletRequest request, 
    		HttpServletResponse response) {
		Map<String, String> map = LLPayUtil.parse2Map(request);
		try {
			String target = ConfigManager.getInstance().getRlife(Pks.RLIFE_GOODS_GETUSERRORDERLIST);
			String json = AbstractController.post(target, map);
			logger.debug("获取商品列表信息----》 " + json);
			return json;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return JsonUtil.bean2json(new OperateResult(0, "温馨提示-服务器错误"));
		}
	}
	
}
