package com.rqb.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rqb.controller.abs.AbstractController;
import com.rqb.service.NormalService;

@Controller
@RequestMapping(value = "/normal")
public class NormalController extends AbstractController {
    @Autowired
    NormalService normalService;
     
    // 获取配资比例
    @RequestMapping(value = "/peizi/rate/get.do")
    public void getPeiziRate(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String info = normalService.getPeiziRate();
        sendResponse(normalService, info, response);
    }
 // 获取配资比例
    @RequestMapping(value = "/oral/invest/list/get.do")
    public void getOralInvest(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String info = normalService.getOralInvest();
        sendResponse(normalService, info, response);
    }
    
 // 理财页显示活动图标
    @RequestMapping(value = "/active/logo/show.do")
    public void showActiveLogo(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String type = request.getParameter("type");
        String info = normalService.showActiveLogo(type);
        sendResponse(normalService, info, response);
    }
 // 显示投资返现合伙人收益排名
    @RequestMapping(value = "/reference/rank/list/get.do")
    public void getReferenceRankList(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String info = normalService.getReferenceRankList();
        sendResponse(normalService, info, response);
    }
 // 获得轮播banner图
    @RequestMapping(value = "/banner/list/get.do")
    public void getBannerList(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if(account == null){
            account = "";
        }
        String info = normalService.getBannerList(account);
        sendResponse(normalService, info, response);
    }
    
}
