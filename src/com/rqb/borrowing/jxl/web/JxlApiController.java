package com.rqb.borrowing.jxl.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//import com.alibaba.fastjson.JSONObject;
import com.rqb.borrowing.jxl.service.JxlApiservice;
import com.rqb.borrowing.jxl.vo.ApplyInfo;
import com.rqb.borrowing.jxl.vo.ReqMsg;
import com.rqb.controller.abs.AbstractController;
import com.ruiqt.lianlian.utils.LLPayUtil;

import net.sf.json.JSONObject;

/**
 * 聚信立控制类
 * @author wangya
 * @since 2017-02-16
 */
@Controller
@RequestMapping(value = "/jxl/api")
public class JxlApiController extends AbstractController {
	private static final Logger logger = Logger.getLogger(JxlApiController.class);
	
	@Resource
	JxlApiservice JxlApiservice;
	
	/**
	 * 提交数据源采集请求
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/collect/req.do", method = {RequestMethod.GET, 
			RequestMethod.POST}, produces = "application/json;charset=UTF-8")
	public void collectReq(HttpServletRequest request,
			HttpServletResponse response) {
		JSONObject jsonObject = LLPayUtil.getJSONObject(request);
		logger.info("jsonObject - " + jsonObject);
		Object userId = request.getSession().getAttribute("userId");
		try {
			if (null != userId && !"".equals(userId.toString())) {
				jsonObject.put("userId", userId.toString());
				String info = JxlApiservice.collectReq(jsonObject);
				sendResponse(JxlApiservice, info, response);
			} else {
				String result = getResult(0,"温馨提示-您还未登录,请先登录");
				sendResponse(JxlApiservice, result, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			String result = getResult(0,"温馨提示-服务器错误,请稍候重试");
			sendResponse(JxlApiservice, result, response);
		}
	}
	
	/**
	 * 获取支持的数据源列表
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/datasources.do", method = {RequestMethod.GET, 
			RequestMethod.POST})
	public void datasources(HttpServletRequest request, HttpServletResponse response) {
		try {
			String info = JxlApiservice.datasources();
			sendResponse(JxlApiservice, info, response);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			String result = getResult(0,"温馨提示-服务器错误,请稍候重试");
			sendResponse(JxlApiservice, result, response);
		}
	}
	
	/**
	 * 提交申请表单获取回执信息
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/apply.do", method = {RequestMethod.GET, 
			RequestMethod.POST}, produces = "application/json;charset=UTF-8")
	public void apply(HttpServletRequest request, 
			HttpServletResponse response) {
		JSONObject jsonObject = LLPayUtil.getJSONObject(request);
		logger.info("jsonObject - " + jsonObject);
		Object userId = request.getSession().getAttribute("userId");
		try {
			if (null != userId && !"".equals(userId.toString())) {
				jsonObject.put("userId", userId.toString());
				String info = JxlApiservice.apply(jsonObject);
				sendResponse(JxlApiservice, info, response);
			} else {
				String result = getResult(0,"温馨提示-您还未登录,请先登录");
				sendResponse(JxlApiservice, result, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			String result = getResult(0,"温馨提示-服务器错误,请稍候重试");
			sendResponse(JxlApiservice, result, response);
		}
	}
	
	/**
	 * 提交申请表单接口
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/creditcard/applications.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public void applications(HttpServletRequest request,
			HttpServletResponse response) {
		JSONObject jsonObject = LLPayUtil.getJSONObject(request);
		logger.info("jsonObject - " + jsonObject);
		Object userId = request.getSession().getAttribute("userId");
		try {
			if (null != userId && !"".equals(userId.toString())) {
				jsonObject.put("userId", userId.toString());
				String info = JxlApiservice.applications(jsonObject);
				sendResponse(JxlApiservice, info, response);
			} else {
				String result = getResult(0,"温馨提示-您还未登录,请先登录");
				sendResponse(JxlApiservice, result, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			String result = getResult(0,"温馨提示-服务器错误,请稍候重试");
			sendResponse(JxlApiservice, result, response);
		}
	}
	
	/**
	 * 信用卡-提交采集请求接口
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/creditcard/message/collect/req.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public void messageReq(HttpServletRequest request,
			HttpServletResponse response) {
		JSONObject jsonObject = LLPayUtil.getJSONObject(request);
		logger.info("jsonObject - " + jsonObject);
		Object userId = request.getSession().getAttribute("userId");
		try {
			if (null != userId && !"".equals(userId.toString())) {
				jsonObject.put("userId", userId.toString());
				String info = JxlApiservice.messageReq(jsonObject);
				sendResponse(JxlApiservice, info, response);
			} else {
				String result = getResult(0,"温馨提示-您还未登录,请先登录");
				sendResponse(JxlApiservice, result, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			String result = getResult(0,"温馨提示-服务器错误,请稍候重试");
			sendResponse(JxlApiservice, result, response);
		}
	}
	
	/**
	 * 信用卡响应接口(二维码登录方式才需要)
	 * @author wangya
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/creditcard/messages/qrcodeCollect/resp.do", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public void messageResp(HttpServletRequest request,
			HttpServletResponse response) {
		JSONObject jsonObject = LLPayUtil.getJSONObject(request);
		logger.info("jsonObject - " + jsonObject);
		Object userId = request.getSession().getAttribute("userId");
		try {
			if (null != userId && !"".equals(userId.toString())) {
				jsonObject.put("userId", userId.toString());
				String info = JxlApiservice.messageReq(jsonObject);
				sendResponse(JxlApiservice, info, response);
			} else {
				String result = getResult(0,"温馨提示-您还未登录,请先登录");
				sendResponse(JxlApiservice, result, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			String result = getResult(0,"温馨提示-服务器错误,请稍候重试");
			sendResponse(JxlApiservice, result, response);
		}
	}
	
	public String getResult(int result, String message){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("errInfo", message); 
		param.put("result", result); 
		String res = JSONObject.fromObject(param).toString();
		return res;
	}
}
