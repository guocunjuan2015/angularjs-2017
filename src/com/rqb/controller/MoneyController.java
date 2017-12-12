package com.rqb.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rqb.common.Constants.Msg;
import com.rqb.controller.abs.AbstractController;
import com.rqb.service.MoneyService;
import com.ultrapower.cloudup.utils.EmptyUtils;
import com.ultrapower.cloudup.utils.StringUtils;
@Controller
@RequestMapping(value = "/money")
public class MoneyController extends AbstractController{
	@Autowired MoneyService moneyService;
	
	@RequestMapping(value = "/card/get.do")
	public void getCard(HttpSession session, HttpServletResponse response) {
		String account = (String) session.getAttribute("loginUser");
		if(EmptyUtils.isEmpty(account)){
			sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
		}else{
			String info = moneyService.getCard(account);
			sendResponse(moneyService, info, response);
		}
	}
	
	@RequestMapping(value = "/card/bind.do")
	public void bindCard(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String account = (String) session.getAttribute("loginUser");
		String cardNo = request.getParameter("cardNo");
		String province = request.getParameter("province");
		String city = request.getParameter("city");
		String brabank = request.getParameter("brabank");
		String cardCode = request.getParameter("cardCode");
		String password = request.getParameter("password");
		if(EmptyUtils.isEmpty(account)){
			sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
		}else{
			String info = moneyService.bindCard(cardNo, province, city, brabank, cardCode, password, account);
			sendResponse(moneyService, info, response);
		}
	}
	
	@RequestMapping(value = "/info/get.do")
	public void getInfo(HttpSession session, HttpServletResponse response) {
		String account = (String) session.getAttribute("loginUser");
		if(EmptyUtils.isEmpty(account)){
			sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
		}else{
			String info = moneyService.getInfo(account);
			sendResponse(moneyService, info, response);
		}
	}
	
	@RequestMapping(value = "/recharge.do")
	public void recharge(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String account = (String) session.getAttribute("loginUser");
		Double amount = StringUtils.parseDouble(request.getParameter("money"));
		
		if(EmptyUtils.isEmpty(account)){
			sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
		}else{
			String info = moneyService.recharge(account, amount);
			sendResponse(moneyService, info, response);
		}
	}
	
	@RequestMapping(value = "/cash.do")
	public void cash(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String account = (String) session.getAttribute("loginUser");
		String password = request.getParameter("password");
		String money = request.getParameter("money");
		if(EmptyUtils.isEmpty(account)){
			sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
		}else{
			String info = moneyService.cash(account, password, money);
			sendResponse(moneyService, info, response);
		}
	}
	//搜索获取支行信息
	@RequestMapping(value = "/search/bankbra.do")
	public void searchBranch(HttpServletRequest request, 
			HttpServletResponse response) {
		    String cityCode = request.getParameter("cityCode");
		    String branchName = request.getParameter("branchName");
		    String bankCode = request.getParameter("bankCode");
			String info = moneyService.searchBranch(cityCode,bankCode,branchName);
			sendResponse(moneyService, info, response);
	}
}
