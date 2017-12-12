package com.rqb.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rqb.common.Constants.Msg;
import com.rqb.controller.abs.AbstractController;
import com.rqb.service.UMPService;
import com.ultrapower.cloudup.utils.EmptyUtils;

@Controller
@RequestMapping(value = "/ump")
public class UMPController extends AbstractController {
	@Autowired
	UMPService umpService;

	// 易宝注册,判断结果是否成功
	@RequestMapping(value = "/open/get.do")
	public void getResult(HttpServletRequest request,
			HttpServletResponse response) {
		String xml = request.getParameter("resp");
//		String sign = request.getParameter("sign");
		String resCode = getXMLSpinner(xml, "code");
		int res = -1;
		if ("1".equals(resCode)) {
			res = 1;
		} else {
			res = 0;
		}
		try {
			response.sendRedirect("/rqb/ep_reg_result.jsp?res=" + res
					+ "&resCode=" + resCode);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 易宝提现,判断结果是否成功 回调页面
	@RequestMapping(value = "/cash/get.do")
	public void cashResult(HttpServletRequest request,
			HttpServletResponse response) {
		String xml = request.getParameter("resp");
//		String sign = request.getParameter("sign");
		String resCode = getXMLSpinner(xml, "code");
		int res = -1;
		if ("1".equals(resCode)) {
			res = 1;
		} else {
			res = 0;
		}
		try {
			response.sendRedirect("/rqb/ep_cash_result.jsp?res=" + res
					+ "&resCode=" + resCode);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 易宝充值,判断结果是否成功 回调页面
	@RequestMapping(value = "/recharge/get.do")
	public void rechargeResult(HttpServletRequest request,
			HttpServletResponse response) {
		String xml = request.getParameter("resp");
//		String sign = request.getParameter("sign");
		String resCode = getXMLSpinner(xml, "code");
		int res = -1;
		if ("1".equals(resCode)) {
			res = 1;
		} else {
			res = 0;
		}
		try {
			response.sendRedirect("/rqb/ep_recharge_result.jsp?res=" + res
					+ "&resCode=" + resCode);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 易宝修改交易密码，判断结果是否成功，回调页面
	@RequestMapping(value = "/modifypassword/get.do")
	public void modifyPswResult(HttpServletRequest request,
			HttpServletResponse response) {
		String xml = request.getParameter("resp");
//		String sign = request.getParameter("sign");
		String resCode = getXMLSpinner(xml, "code");
		int res = -1;
		if ("1".equals(resCode)) {
			res = 1;
		} else {
			res = 0;
		}
		try {
			response.sendRedirect("/rqb/ep_modify_result.jsp?res=" + res
					+ "&resCode=" + resCode);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 易宝投资，判断结果是否成功，回调页面
		@RequestMapping(value = "/invest/get.do")
		public void investResult(HttpServletRequest request,
				HttpServletResponse response) {
			String xml = request.getParameter("resp");
//			String sign = request.getParameter("sign");
			String resCode = getXMLSpinner(xml, "code");
			int res = -1;
			if ("1".equals(resCode)) {
				res = 1;
			} else {
				res = 0;
			}
			try {
				response.sendRedirect("/rqb/ep_invest_result.jsp?res=" + res
						+ "&resCode=" + resCode);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}


	
	// UMP,检查开启时间，注册状态
    @RequestMapping(value = "/check/register/status.do")
    public void checkRegisterStatus(HttpSession session, HttpServletRequest request,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String loginPassword = (String) session.getAttribute("loginPassword");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = umpService.checkRegisterStatus(account,loginPassword);
            sendResponse(umpService, info, response);
        }
    }
    
 // UMP,检查开启时间，注册状态
    @RequestMapping(value = "/check/registerwhilelogin/status.do")
    public void checkRegisterStatusWhileLogin(HttpSession session, HttpServletRequest request,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String loginPassword = (String) session.getAttribute("loginPassword");
        if (EmptyUtils.isEmpty(account)) {
            //没登录啥也不做
        } else {
            String info = umpService.checkRegisterStatus(account,loginPassword);
            sendResponse(umpService, info, response);
        }
    }
    
     // UMP,注册页面检查联动优势开启时间
        @RequestMapping(value = "/check/start/status.do")
        public void checkUMPStart(HttpSession session, HttpServletRequest request,
                HttpServletResponse response) {
                String info = umpService.checkUMPStart();
                sendResponse(umpService, info, response);
        }

 // UMP绑卡
    @RequestMapping(value = "/change/bindcard.do")
    public void umpBindCard(HttpSession session, HttpServletRequest request,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String isOpenFastPayment = request.getParameter("iop");
        String cardId = request.getParameter("cardId");
        String retUrl = request.getParameter("retUrl");
        String cardCode = request.getParameter("cardCode");
        String bindType = request.getParameter("bindType");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            if("change".equals(bindType)){
                String info = umpService.umpChangeCard(account, isOpenFastPayment,cardId,retUrl,cardCode);
                sendResponse(umpService, info, response);
            }else{
                String info = umpService.umpBindCard(account, isOpenFastPayment,cardId,retUrl,cardCode);
                sendResponse(umpService, info, response);
            }
        }
    }
 // UMP充值
    @RequestMapping(value = "/money/recharge.do")
    public void umpMoneyRecharge(HttpSession session, HttpServletRequest request,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String amount = request.getParameter("amount");
        String payType = request.getParameter("payType");
        String retUrl = request.getParameter("retUrl");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = umpService.umpMoneyRecharge(account, amount,payType,retUrl);
            sendResponse(umpService, info, response);
        }
    }
    
 // UMP提现
    @RequestMapping(value = "/money/cash.do")
    public void umpMoneyCash(HttpSession session, HttpServletRequest request,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String amount = request.getParameter("amount");
        String retUrl = request.getParameter("retUrl");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = umpService.umpMoneyCash(account, amount,retUrl);
            sendResponse(umpService, info, response);
        }
    }
 // UMP投资
    @RequestMapping(value = "/invest.do")
    public void umpInvest(HttpSession session, HttpServletRequest request,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String amount = request.getParameter("amount");
        String loanId = request.getParameter("loanId");
        String ticketId = request.getParameter("ticketId");
        String couponId = request.getParameter("couponId");
        String moreRateId = request.getParameter("moreRateId");
        String channel = request.getParameter("channel");
        String retUrl = request.getParameter("retUrl");
        String utm_source = request.getParameter("utm_source");
        String uid = request.getParameter("uid");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            if(utm_source != null && utm_source != "" && uid != null && uid != ""){
                String info = umpService.umpInvestFbaba(account, amount,loanId,ticketId,couponId,moreRateId,channel,retUrl,utm_source,uid);
                sendResponse(umpService, info, response);
            }else{
            	if (StringUtils.isBlank(channel)) {
            		channel = "22";
            	}
                String info = umpService.umpInvest(account, amount,loanId,ticketId,couponId,moreRateId,channel,retUrl);
                sendResponse(umpService, info, response);
            }
        }
    }
 // UMP投资
    @RequestMapping(value = " /transfer/invest.do")
    public void umpTransferInvest(HttpSession session, HttpServletRequest request,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String amount = request.getParameter("amount");
        String loanId = request.getParameter("loanId");
        String ticketId = request.getParameter("ticketId");
        String couponId = request.getParameter("couponId");
        String moreRateId = request.getParameter("moreRateId");
        String channel = request.getParameter("channel");
        String retUrl = request.getParameter("retUrl");
        String utm_source = request.getParameter("utm_source");
        String uid = request.getParameter("uid");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            if(utm_source != null && utm_source != "" && uid != null && uid != ""){
                String info = umpService.umpTransferInvestFbaba(account, amount,loanId,ticketId,couponId,moreRateId,channel,retUrl,utm_source,uid);
                sendResponse(umpService, info, response);
            }else{
                String info = umpService.umpTransferInvest(account, amount,loanId,ticketId,couponId,moreRateId,channel,retUrl);
                sendResponse(umpService, info, response);
            }
        }
    }
    
 // UMP重置密码
    @RequestMapping(value = "/paypassword/reset.do")
    public void payPswReset(HttpSession session, HttpServletRequest request,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = umpService.payPswReset(account);
            sendResponse(umpService, info, response);
        }
    }
    
 // UMP开通协议
    @RequestMapping(value = "/payment/open.do")
    public void openPayment(HttpSession session, HttpServletRequest request,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String payment = request.getParameter("payment");
        String returl = request.getParameter("returl");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = umpService.openPayment(account,payment,returl);
            sendResponse(umpService, info, response);
        }
    }
 // UMP关闭协议
    @RequestMapping(value = "/payment/close.do")
    public void cloasePayment(HttpSession session, HttpServletRequest request,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("userId");
        String payment = request.getParameter("payment");
        String returl = request.getParameter("returl");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = umpService.cloasePayment(account,payment,returl);
            sendResponse(umpService, info, response);
        }
    }

	// 解析XML
	private String getXMLSpinner(String xml, String nodeName) {
		String startNode = "<" + nodeName + ">";
		String endNode = "</" + nodeName + ">";
		int start = xml.indexOf(startNode);
		int end = xml.indexOf(endNode);
		if (start > 0 && end > start)
			return xml.substring(start + startNode.length(), end);
		else
			return null;
	}
}
