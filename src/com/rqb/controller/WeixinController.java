package com.rqb.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.w3c.dom.Document;

import com.rqb.controller.abs.AbstractController;
import com.rqb.dto.WxInfoDto;
import com.rqb.service.WeixinService;
import com.ultrapower.cloudup.utils.EmptyUtils;

@Controller
@RequestMapping(value = "/weixin")
public class WeixinController extends AbstractController{
	@Autowired WeixinService weixinService;
	
	@RequestMapping(value = "/valid.do")
	public void valid(HttpServletRequest request, HttpServletResponse response) {
		String echostr = request.getParameter("echostr");
		if(!EmptyUtils.isEmpty(echostr)){
			sendGeneralResponse(response, weixinService.valid(echostr));
		}else if("text/xml".equals(request.getContentType())){
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db;
			Document doc;
			try {
				db = dbf.newDocumentBuilder();
				doc = db.parse(request.getInputStream());
			} catch (Exception e) {
				_log.fatal("analyze xml data error -> " + e);
				sendGeneralResponse(response, "");
				return;
			}
			
			sendXmlResponse(response, weixinService.getReturnMsg(doc));
			
		}else{
			sendGeneralResponse(response, "");
		}
	}
	
	@RequestMapping(value = "/openid/get.do")
	public void getOpenId(HttpServletRequest request, HttpServletResponse response) {
		String code = request.getParameter("code");
		String info = weixinService.getOpenId(code);
		_log.error("login id id id id id id  -> " + info);
		sendResponse(weixinService, info, response);
	}
	
	@RequestMapping(value = "/openid/visit.do")
	public void Visit(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Boolean flag = (Boolean) session.getAttribute("visit");
		if(flag == null || flag == false){
			session.setAttribute("visit", true);
		
			String openId = request.getParameter("openid");
			String addr = request.getRemoteAddr();
			weixinService.visit(openId, addr);
			sendResponse(weixinService, null, response);
		}
	}
	
	@RequestMapping(value = "/result/get.do")
	public void getResult(HttpServletResponse response) {
		List<WxInfoDto> result = weixinService.getResult();
		sendResponse(weixinService, result, response);
	}
	
	private void sendGeneralResponse(HttpServletResponse response, String content){
		try {
			response.getWriter().print(content);
		} catch (IOException e) {
			_log.error("send response error -> " + e);
			e.printStackTrace();
		}
	}
	
	private void sendXmlResponse(HttpServletResponse response, String content){
		if(EmptyUtils.isEmpty(content)){
			sendGeneralResponse(response, content);
		}
		response.setContentType("text/xml;charset=UTF-8");
		try {
			response.getWriter().print(content);
		} catch (IOException e) {
			_log.error("send response error -> " + e);
			e.printStackTrace();
		}
	}
}
