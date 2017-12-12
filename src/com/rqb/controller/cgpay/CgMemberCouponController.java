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
import com.rqb.service.CgMemberCouponService;
import com.rqb.service.CgUserService;

@Controller
@RequestMapping(value="/cg/mem/coupon")
public class CgMemberCouponController extends AbstractController {
	private static final Logger log = Logger.getLogger(CgMemberCouponController.class);
	
	@Autowired
	private CgMemberCouponService cgMemberCouponService;

	/**
	 * 存管实名认证及注册
	 * 
	 */
    @RequestMapping(value = "/list.do", method = {RequestMethod.GET, RequestMethod.POST})
    public void getList(HttpServletRequest request, HttpServletResponse response){
        log.info("CgMemberCouponController.getList start");
        String status = request.getParameter("status");
        String currentPage = request.getParameter("currentPage");
        String pageSize = request.getParameter("pageSize");
        //认证
        try {
            //已登录用户才可以实名认证
            String userId = (String) request.getSession().getAttribute("userId");
            if(null != userId && !"".equals(userId)){
                Map<String,Object> authParam = new HashMap<String,Object>();
                authParam.put("userId", userId); //用户名
                authParam.put("status", status);
                authParam.put("current", currentPage);
                authParam.put("pageSize", pageSize);
                String authRes = cgMemberCouponService.getList(authParam);
                sendResponse(cgMemberCouponService, authRes, response);
                log.info("RegisterController.realName end result = "+authRes);
            }else{
                String result = getResult(0,"温馨提示 - 您还未登录,请先登录后操作!");
                sendResponse(cgMemberCouponService, result, response);
                log.info("RegisterController.realName end result = "+result);
            }
        } catch (Exception e) {
            log.error("RegisterController.realName error " + e);
            sendResponse(false, "服务器错误", null, response);
        }
    }
    
}
