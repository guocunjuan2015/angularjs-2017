package com.rqb.controller.cgpay;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rqb.controller.abs.AbstractController;
import com.rqb.service.CgTradeService;

@Controller
@RequestMapping(value="/cg/trade")
public class CgTradeController extends AbstractController {
	private static final Logger log = Logger.getLogger(CgUserController.class);

	@Autowired
	private CgTradeService cgTradeService;
	
	/**
	 * 充值
	 * @param request
	 * @param response
	 */
    @RequestMapping(value = "/recharge.do", method = {RequestMethod.GET, RequestMethod.POST})
    public void register(HttpServletRequest request, HttpServletResponse response){
        log.info("CgTradeController.recharge start");
        String amount = request.getParameter("amount");
		String returnUrl = request.getParameter("returnUrl");
        //认证
        try {
            //已登录用户才可以实名认证
            Object userObj = request.getSession().getAttribute("userId");
            String userId = "";
            if(null != userObj && !"".equals(userObj.toString())){
            	userId = userObj.toString();
                Map<String,Object> authParam = new HashMap<String,Object>();
                authParam.put("userId", userId);
                authParam.put("amount", amount);
                authParam.put("returnUrl", returnUrl);
                String authRes = cgTradeService.recharge(authParam);
                sendResponse(cgTradeService, authRes, response);
                log.info("CgTradeController.recharge end result = "+authRes);
            }else{
                String result = getResult(0,"温馨提示 - 您还未登录,请先登录后操作!");
                sendResponse(cgTradeService, result, response);
                log.info("CgTradeController.recharge end result = "+result);
            }
        } catch (Exception e) {
            log.error("CgTradeController.recharge error " + e);
            sendResponse(false, "服务器错误", null, response);
        }
    }
    
    /**
	 * 提现
	 * @param request
	 * @param response
	 */
    @RequestMapping(value = "/withdraw.do", method = {RequestMethod.GET, RequestMethod.POST})
    public void withdraw(HttpServletRequest request, HttpServletResponse response){
        log.info("CgTradeController.recharge start");
        String amount = request.getParameter("amount");
		String returnUrl = request.getParameter("returnUrl");
		String memberCouponId = request.getParameter("memberCouponId");
        //认证
        try {
            //已登录用户才可以实名认证
            Object userObj = request.getSession().getAttribute("userId");
            String userId = "";
            if(null != userObj && !"".equals(userObj.toString())){
            	userId = userObj.toString();
                Map<String,Object> authParam = new HashMap<String,Object>();
                authParam.put("userId", userId);
                authParam.put("amount", amount);
                authParam.put("returnUrl", returnUrl);
                authParam.put("memberCouponId", memberCouponId);
                String authRes = cgTradeService.withdraw(authParam);
                sendResponse(cgTradeService, authRes, response);
                log.info("CgTradeController.recharge end result = "+authRes);
            }else{
                String result = getResult(0,"温馨提示 - 您还未登录,请先登录后操作!");
                sendResponse(cgTradeService, result, response);
                log.info("CgTradeController.recharge end result = "+result);
            }
        } catch (Exception e) {
            log.error("CgTradeController.recharge error " + e);
            sendResponse(false, "服务器错误", null, response);
        }
    }
    
    /**
	 * 投资
	 * @param request
	 * @param response
	 */
    @RequestMapping(value = "/invest.do", method = {RequestMethod.GET, RequestMethod.POST})
    public void invest(HttpServletRequest request, HttpServletResponse response){
        log.info("CgTradeController.recharge start");
		String investAmount = request.getParameter("investAmount");
		String bidId = request.getParameter("bidId");
		String morerateIds = request.getParameter("morerateIds");
		String morerateRate = request.getParameter("morerateRate");
		String couponIds = request.getParameter("couponIds");
		String couponAmount = request.getParameter("couponAmount"); // 红包金额
		String channel = request.getParameter("channel");
		String returnUrl = request.getParameter("returnUrl");
        //认证
        try {
            //已登录用户才可以实名认证
            Object userObj = request.getSession().getAttribute("userId");
            String userId = "";
            if(null != userObj && !"".equals(userObj.toString())){
            	userId = userObj.toString();
                Map<String,Object> authParam = new HashMap<String,Object>();
                authParam.put("userId", userId);
                authParam.put("investAmount", investAmount);
                authParam.put("bidId", bidId);
                authParam.put("morerateIds", morerateIds);
                authParam.put("morerateRate", morerateRate);
                authParam.put("couponIds", couponIds);
                authParam.put("couponAmount", couponAmount);
                authParam.put("channel", "22");
                authParam.put("returnUrl", returnUrl);
                String authRes = cgTradeService.invest(authParam);
                sendResponse(cgTradeService, authRes, response);
                log.info("CgTradeController.recharge end result = "+authRes);
            }else{
                String result = getResult(0,"温馨提示 - 您还未登录,请先登录后操作!");
                sendResponse(cgTradeService, result, response);
                log.info("CgTradeController.recharge end result = "+result);
            }
        } catch (Exception e) {
            log.error("CgTradeController.recharge error " + e);
            sendResponse(false, "服务器错误", null, response);
        }
    }
}
