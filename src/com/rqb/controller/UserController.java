package com.rqb.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.rqb.controller.abs.AbstractController;
import com.rqb.service.UserAwardService;
import com.rqb.service.UserService;

@Controller
@RequestMapping(value = "/user")
public class UserController extends AbstractController {

	@Resource
	UserService userService;
	
	/**
	 * 用户中心
	 * @author wangya
	 * @since 2017-01-10
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/getUserCenter.do", method = { RequestMethod.GET,
			RequestMethod.POST })
	public void getUserCenter(HttpServletRequest request, 
			HttpServletResponse response) {
		Map<String, Object> params = new HashMap<String, Object>();
		
		String userId = request.getParameter("userId");
		params.put("userId", userId);
		String info = "";
		try {
			info = userService.getUserCenter(params);
			sendResponse(userService, info, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取我的回款计划明细
	 * @author wangya
	 * @since 2017-01-10
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getPaymentPlanDetail.do", method=RequestMethod.POST)
	@ResponseBody
	public void getPaymentPlanDetail (HttpServletRequest request,
			HttpServletResponse response) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		String userId = request.getParameter("userId");
		String loanId = request.getParameter("loanId");
		/**
		 * 1:非债权购买  2:债权购买项目
		 */
		String loanType = request.getParameter("loanType");
		params.put("userId", userId);
		params.put("loanId", loanId);
		params.put("loanType", loanType);
		
		String info = "";
		try {
			info = userService.getPaymentPlanDetail(params);
			sendResponse(userService, info, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 身份证上传
	 * @author wangya
	 * @since 2017-02-17
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/credit/uploadImg.do", method = RequestMethod.POST)
	public void uploadImg(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> params = new HashMap<String, Object>();
		String userId = (String) request.getSession().getAttribute("userId");
		String phone = (String) request.getSession().getAttribute("tel");
		String image = request.getParameter("image");
		String image2 = request.getParameter("image2");
		String image3 = request.getParameter("image3");
		String type = request.getParameter("type");
		String type2 = request.getParameter("type2");
		String type3 = request.getParameter("type3");
		
		String info = "";
		try {
			if (null != userId && !"".equals(userId)) {
				params.put("userId", userId);
				params.put("phone", phone);
				params.put("image", image);
				params.put("image2", image2);
				params.put("image3", image3);
				params.put("type", type);
				params.put("type2", type2);
				params.put("type3", type3);
				info = userService.uploadImg(params);
				sendResponse(userService, info, response);
			} else {
				String result = getResult(0,"温馨提示-您还未登录,请先登录");
				sendResponse(userService, result, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			String result = getResult(0,"温馨提示-服务器错误,请稍候重试");
			sendResponse(userService, result, response);
		}
	}
	
	/**
	 * 用户认证信息接口
	 * @author wangya
	 * @since 2017-02-17
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/credit/userAuthenInfo.do", method = RequestMethod.POST)
	public void userAuthenInfo(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> params = new HashMap<String, Object>();
		String userId = (String) request.getSession().getAttribute("userId");
		String info = "";
		try {
			if (null != userId && !"".equals(userId)) {
				params.put("userId", userId);
				info = userService.userAuthenInfo(params);
				sendResponse(userService, info, response);
			} else {
				String result = getResult(0,"温馨提示-您还未登录,请先登录");
				sendResponse(userService, result, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			String result = getResult(0,"温馨提示-服务器错误,请稍候重试");
			sendResponse(userService, result, response);
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
