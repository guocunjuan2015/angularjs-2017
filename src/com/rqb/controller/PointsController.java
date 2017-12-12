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
import com.rqb.service.NormalService;
import com.rqb.service.PointsService;
import com.ultrapower.cloudup.utils.EmptyUtils;

@Controller
@RequestMapping(value = "/points")
public class PointsController extends AbstractController {
    @Autowired
    PointsService pointsService;
     
    //积分任务信息
    @RequestMapping(value = "/task/detail/get.do")
    public void getTaskDetails(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String userId = (String) session.getAttribute("userId");
        if (EmptyUtils.isEmpty(userId)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("userId", userId);
            String info = pointsService.getTaskDetails(params);
            sendResponse(pointsService, info, response);
        }
    }
    
  //摇一摇签到信息
    @RequestMapping(value = "/shakesign/info/get.do")
    public void getShakeSignInfo(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String userId = (String) session.getAttribute("userId");
        if (EmptyUtils.isEmpty(userId)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("userId", userId);
            String info = pointsService.getShakeSignInfo(params);
            sendResponse(pointsService, info, response);
        }
    }
    
  //签到 - 补签
    @RequestMapping(value = "/day/sign/save.do")
    public void saveSign(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String userId = (String) session.getAttribute("userId");
        String date = request.getParameter("date");
        if (EmptyUtils.isEmpty(userId)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("userId", userId);
            params.put("date", date);
            String info = pointsService.saveSign(params);
            sendResponse(pointsService, info, response);
        }
    }
    
}
