package com.rqb.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rqb.common.Constants.Msg;
import com.rqb.controller.abs.AbstractController;
import com.rqb.service.AccountService;
import com.rqb.service.ActivityService;
import com.ultrapower.cloudup.utils.EmptyUtils;
import com.ultrapower.cloudup.utils.StringUtils;

@Controller
@RequestMapping(value = "/activity")
public class ActivityController extends AbstractController {
    @Autowired
    ActivityService activityService;

    @RequestMapping(value = "/morerate.do")
    public void morerate(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> params = new HashMap<String, Object>();
        String account = (String) session.getAttribute("userId");
        String userId = request.getParameter("userId");
        try {
        	if (EmptyUtils.isEmpty(userId)) {
                sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
            } else {
            	params.put("userId", userId);
                String info = "";
                info = activityService.morerate(params);
                sendResponse(activityService, info, response);
            }
        } catch (Exception e) {
        	e.printStackTrace();
        }
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        }  
    }
    
    @RequestMapping(value = "/morerateUserLt.do")
    public void morerateUserLt(HttpSession session,HttpServletRequest request,  HttpServletResponse response) {
    	 Map<String, Object> params = new HashMap<String, Object>();
         String account = (String) session.getAttribute("userId");
         String userId = request.getParameter("userId");
         try {
         	if (EmptyUtils.isEmpty(userId)) {
                 sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
             } else {
             	params.put("userId", userId);
                 String info = "";
                 info = activityService.morerateUserLt(params);
                 sendResponse(activityService, info, response);
             }
         } catch (Exception e) {
         	e.printStackTrace();
         }
         if (EmptyUtils.isEmpty(account)) {
             sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
         }  
    }
}
