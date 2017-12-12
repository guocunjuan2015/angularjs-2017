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
import com.rqb.service.CgUserService;

@Controller
@RequestMapping(value="/cg/user")
public class CgUserController extends AbstractController {
	private static final Logger log = Logger.getLogger(CgUserController.class);
	
	@Autowired
	private CgUserService cgUserService;

	/**
	 * 存管实名认证及注册
	 * 
	 */
    @RequestMapping(value = "/register.do", method = {RequestMethod.GET, RequestMethod.POST})
    public void register(HttpServletRequest request, HttpServletResponse response){
        log.info("RegisterController.realName start");
        String bizType = request.getParameter("bizType");
        String returnUrl = request.getParameter("returnUrl");
        //认证
        try {
            //已登录用户才可以实名认证
            Object userObj = request.getSession().getAttribute("userId");
            String userId = "";
            if(null != userObj && !"".equals(userObj.toString())){
            	userId = userObj.toString();
                Map<String,Object> authParam = new HashMap<String,Object>();
                authParam.put("userId", userId); //用户名
                authParam.put("bizType", bizType);
                authParam.put("returnUrl", returnUrl);
                String authRes = cgUserService.register(authParam);
                sendResponse(cgUserService, authRes, response);
                log.info("RegisterController.realName end result = "+authRes);
            }else{
                String result = getResult(0,"温馨提示 - 您还未登录,请先登录后操作!");
                sendResponse(cgUserService, result, response);
                log.info("RegisterController.realName end result = "+result);
            }
        } catch (Exception e) {
            log.error("RegisterController.realName error " + e);
            sendResponse(false, "服务器错误", null, response);
        }
    }
    
    /**
	 * 获取实名信息
	 * 
	 */
    @RequestMapping(value = "/getRegisterInfo.do", method = {RequestMethod.GET, RequestMethod.POST})
    public void getRegisterInfo(HttpServletRequest request, HttpServletResponse response){
        log.info("RegisterController.getRegisterInfo start");
        try {
            Object userObj = request.getSession().getAttribute("userId");
            String userId = "";
            if(null != userObj && !"".equals(userObj.toString())){
            	userId = userObj.toString();
                Map<String,Object> authParam = new HashMap<String,Object>();
                authParam.put("userId", userId); //用户名
                String authRes = cgUserService.getRegisterInfo(authParam);
                sendResponse(cgUserService, authRes, response);
                log.info("RegisterController.getRegisterInfo end result = "+authRes);
            }else{
                String result = getResult(0, "温馨提示 - 您还未登录,请先登录后操作!");
                sendResponse(cgUserService, result, response);
                log.info("RegisterController.getRegisterInfo end result = "+result);
            }
        } catch (Exception e) {
            log.error("RegisterController.getRegisterInfo error " + e);
            sendResponse(false, "服务器错误", null, response);
        }
    }
}
