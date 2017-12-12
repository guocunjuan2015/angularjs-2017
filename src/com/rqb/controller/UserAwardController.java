package com.rqb.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rqb.controller.abs.AbstractController;
import com.rqb.service.UserAwardService;

@Controller
@RequestMapping(value = "/userAward")
public class UserAwardController extends AbstractController {
	
	private static Logger log = Logger.getLogger(UserAwardController.class);

	@Resource
	UserAwardService userAwardService;
	
	@RequestMapping(value = "/getUserAwardList.do", method = { RequestMethod.GET,
			RequestMethod.POST })
	public void getUserAwardList(HttpServletRequest request, 
			HttpServletResponse response) {
		Map<String, Object> params = new HashMap<String, Object>();
		/**
		 * 1:奖品, 2:红包, 3:加息券
		 */
		String awardType = request.getParameter("awardType");
		String current = request.getParameter("current");
		String pageSize = request.getParameter("pageSize");
		String userId = request.getParameter("userId");
		
		params.put("current", current);
		params.put("pageSize", pageSize);
		params.put("userId", userId);
		String info = "";
		try {
			if (awardType != null && !"".equals(awardType)) {
				if ("1".equals(awardType)) {
					// 奖品
					info = userAwardService.getUserAward(params);
					sendResponse(userAwardService, info, response);
				} else if ("2".equals(awardType)) {
					// 红包					
					info = userAwardService.getCouponList(params);
					sendResponse(userAwardService, info, response);
				} else if ("3".equals(awardType)) {
					// 加息券
					info = userAwardService.getMoreateList(params);
					sendResponse(userAwardService, info, response);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取投资时用户的可用红包与加息券
	 * @author wangya
	 * @since 2017-01-09
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/getUserCanUseCouponList.do", method = { RequestMethod.GET,
			RequestMethod.POST })
	public void getUserCanUseCouponList(HttpServletRequest request, 
			HttpServletResponse response) {
		Map<String, Object> params = new HashMap<String, Object>();
		String projectId = request.getParameter("projectId");
		String investAmount = request.getParameter("investAmount");
		String userId = request.getParameter("userId");
		
		params.put("projectId", projectId);
		params.put("investAmount", investAmount);
		params.put("userId", userId);
		log.debug("projectId - " + projectId + " - investAmount - " + investAmount + " - userId - " + userId);
		String info = "";
		try {
			info = userAwardService.getUserCanUseCouponList(params);
			sendResponse(userAwardService, info, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
