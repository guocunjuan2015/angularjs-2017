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
import com.ultrapower.cloudup.utils.EmptyUtils;
import com.ultrapower.cloudup.utils.StringUtils;

@Controller
@RequestMapping(value = "/account")
public class AccountController extends AbstractController {
    @Autowired
    AccountService accountService;

    @RequestMapping(value = "/check/login.do")
    public void checkLogin(HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        }  
    }
    
    @RequestMapping(value = "/detail/get.do")
    public void getDetail(HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getDetail(account);
            sendResponse(accountService, info, response);
        }
    }
    @RequestMapping(value = "/userhex/get.do")
    public void getUserHex(HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            
        } else {
            String info = accountService.getDetail(account);
            sendResponse(accountService, info, response);
        }
    }

    @RequestMapping(value = "/detail/whilelogin/get.do")
    public void getDetailWhileLogin(HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            // 没登录啥也不干
        } else {
            String info = accountService.getDetail(account);
            sendResponse(accountService, info, response);
        }
    }

    @RequestMapping(value = "/recordinfo/get.do")
    public void getRecordInfo(HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getRecordInfo(account);
            sendResponse(accountService, info, response);
        }
    }

    @RequestMapping(value = "/record/get.do")
    public void getRecord(HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getRecord(account);
            sendResponse(accountService, info, response);
        }
    }

    @RequestMapping(value = "/invest/get.do")
    public void getInvest(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String t = request.getParameter("t");
        String s = request.getParameter("s");
        String c = request.getParameter("c");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getInvest(account, t, s, c);
            sendResponse(accountService, info, response);
        }
    }
    @RequestMapping(value = "/transfer/invest/get.do")
    public void getTransferInvest(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String status = request.getParameter("status");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getTransferInvest(account,status);
            sendResponse(accountService, info, response);
        }
    }

    @RequestMapping(value = "/transfer/get.do")
    public void getTransfer(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getTransfer(account);
            sendResponse(accountService, info, response);
        }
    }
    
    

    @RequestMapping(value = "/coupon/get.do")
    public void getCoupon(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        Integer type = StringUtils.parseInteger(request.getParameter("type"));
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getCoupon(account, type);
            sendResponse(accountService, info, response);
        }
    }

    // 获取瑞钱币信息
    @RequestMapping(value = "/reward/getRuiqbInfo.do")
    public void getReward(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getRuiqb(account);
            sendResponse(accountService, info, response);
        }
    }

    // 积分兑换瑞钱币
    @RequestMapping(value = "/change/exchange.do")
    public void ExchangeRuiqb(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String numRqb = request.getParameter("numRqb");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.ToExchangeRuiqb(account, numRqb);
            sendResponse(accountService, info, response);
        }
    }

    // 获取可用积分信息
    @RequestMapping(value = "/change/getpoints.do")
    public void getPointsInfo(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getPointsInfo(account);
            sendResponse(accountService, info, response);
        }
    }

    // 展示用户积分兑换瑞钱币历史记录
    @RequestMapping(value = "/exchange/showhistory.do")
    public void showExchangeHistory(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.showExchangeHistory(account);
            sendResponse(accountService, info, response);
        }
    }

    // 获取用户积分信息以及VIP等级
    @RequestMapping(value = "/vip/getJifen.do")
    public void getJifenInfo(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getJifenInfo(account);
            sendResponse(accountService, info, response);
        }
    }

    // 展示用户积分兑换瑞钱币历史记录
    @RequestMapping(value = "/points/showhistory.do")
    public void showPointsHistory(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.showPointsHistory(account);
            sendResponse(accountService, info, response);
        }
    }

    // 用户积分排行榜
    @RequestMapping(value = "/points/showrank.do")
    public void showPointsRank(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.showPointsRank(account);
            sendResponse(accountService, info, response);
        }
    }

    // 每日签到
    @RequestMapping(value = "/day/signin.do")
    public void daySignIn(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.daySignIn(account);
            sendResponse(accountService, info, response);
        }
    }

    // 获取用户手机号码
    @RequestMapping(value = "/user/mobile.do")
    public void getUserMobile(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getUserMobile(account);
            sendResponse(accountService, info, response);
        }
    }

    // 检查用户是否是VIP会员
    @RequestMapping(value = "/check/vipmember.do")
    public void isVIPMember(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.isVIPMember(account);
            sendResponse(accountService, info, response);
        }
    }

    // 检查用户是否能加入VIP俱乐部
    @RequestMapping(value = "/check/joinvipclub.do")
    public void canJoinVIPOrNot(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.canJoinVIPOrNot(account);
            sendResponse(accountService, info, response);
        }
    }

    @RequestMapping(value = "/reward/get.do")
    public void getRuiqb(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String projectId = "";
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getReward(account, projectId);
            sendResponse(accountService, info, response);
        }
    }

    @RequestMapping(value = "/check.do")
    public void check(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.check(account);
            sendResponse(accountService, info, response);
        }
    }

    // 检查优惠券与投资金额的使用比例
    @RequestMapping(value = "/check/couponmax.do")
    public void checkCopMax(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String money = request.getParameter("money");
        String id = request.getParameter("id");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.checkCopMax(account, money, id);
            sendResponse(accountService, info, response);
        }
    }

    // 我的奖励页面，获得推荐投资返额比例
    @RequestMapping(value = "/getrate/percent.do")
    public void getRatePercent(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getRatePercent(account);
            sendResponse(accountService, info, response);
        }
    }

    // 个人中心 站内信
    @RequestMapping(value = "/message/hasread/check.do")
    public void checkMessageHasRead(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.checkMessageHasRead(account);
            sendResponse(accountService, info, response);
        }
    }

    // 消息中心 删除单条消息
    @RequestMapping(value = "/message/center/deletesinglemessage.do")
    public void deleteSingleMessage(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String msgid = request.getParameter("msgid");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.deleteSingleMessage(account, msgid);
            sendResponse(accountService, info, response);
        }
    }

    // 好友推荐奖励
    @RequestMapping(value = "/refer/reward/get.do")
    public void getReferReward(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getReferReward(account);
            sendResponse(accountService, info, response);
        }
    }

    // table列出好友推荐信息
    @RequestMapping(value = "/refer/myrefer/get.do")
    public void getMyRefer(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getMyRefer(account);
            sendResponse(accountService, info, response);
        }
    }

    // 站内信，消息中心
    @RequestMapping(value = "/message/center/get.do")
    public void getMessageCenter(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getMessageCenter(account);
            sendResponse(accountService, info, response);
        }
    }

    // 积分兑换明细
    @RequestMapping(value = "/change/record.do")
    public void changeRecord(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.changeRecord(account);
            sendResponse(accountService, info, response);
        }
    }

    // 获得积分信息
    @RequestMapping(value = "/points/details/get.do")
    public void getPointsDetails(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getPointsDetails(account);
            sendResponse(accountService, info, response);
        }
    }

    // 积分兑换瑞钱币
    @RequestMapping(value = "/points/tocoupon/exchange.do")
    public void pointsExchange(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String a = request.getParameter("a");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.pointsExchange(account, a);
            sendResponse(accountService, info, response);
        }
    }

    // 获取个人优惠券列表
    @RequestMapping(value = "/my/ticketinfo/get.do")
    public void getTicketInfo(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String projectId = request.getParameter("projectId");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = "";
            if(projectId !=null && projectId != ""){
                info = accountService.getTicketInfo(account,projectId);
            }else{
                info = accountService.getTicketInfo(account);
            }
            sendResponse(accountService, info, response);
        }
    }

    // 获取个人瑞钱币信息
    @RequestMapping(value = "/my/couponinfo/get.do")
    public void getCouponInfo(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String projectId = request.getParameter("projectId");
        String moneyInvest = request.getParameter("moneyInvest");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = "";
            if(projectId !=null && projectId != ""){
                info = accountService.getCouponInfo(account,projectId,moneyInvest);
            }else{
                info = accountService.getCouponInfo(account);
            }
            sendResponse(accountService, info, response);
        }
    }

    // 获取兑换瑞钱币明细
    @RequestMapping(value = "/coupon/details.do")
    public void getCouponDetails(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getCouponDetails(account);
            sendResponse(accountService, info, response);
        }
    }

    // 激活瑞钱币
    @RequestMapping(value = "/coupon/active.do")
    public void activeCoupon(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String n = (String) request.getParameter("n");
        String c = (String) request.getParameter("c");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.activeCoupon(account, n, c);
            sendResponse(accountService, info, response);
        }
    }

    // 激活优惠券
    @RequestMapping(value = "/ticket/active.do")
    public void activeTicket(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String n = (String) request.getParameter("n");
        String c = (String) request.getParameter("c");
        String account = (String) request.getParameter("p");
        if(account == null || account == ""){
            account = (String) session.getAttribute("loginUser");
        }
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.activeTicket(account, n, c);
            sendResponse(accountService, info, response);
        }
    }
 // 激活加息券
    @RequestMapping(value = "/morerate/active.do")
    public void activeMorerate(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String n = (String) request.getParameter("n");
        String c = (String) request.getParameter("c");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.activeMorerate(account, n, c);
            sendResponse(accountService, info, response);
        }
    }

    // 获取大伽汇列表信息
    @RequestMapping(value = "/market/list/get.do")
    public void getMarketList(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("userId");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getMarketList(account);
            sendResponse(accountService, info, response);
        }
    }

    // 大伽汇积分兑换优惠券
    @RequestMapping(value = "/market/coupon/exchange.do")
    public void couponExchange(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("userId");
        String shopid = request.getParameter("shopid");
        String point = request.getParameter("point");
        String method = request.getParameter("method");
        String channel = request.getParameter("channel");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.couponExchange(account, shopid, point,
                    method, channel);
            sendResponse(accountService, info, response);
        }
    }

    // 大伽汇项目列表点击进入详情
    @RequestMapping(value = "/market/details/get.do")
    public void marketDetails(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("userId");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.marketDetails();
            sendResponse(accountService, info, response);
        }

    }

    // 大伽汇积分兑换记录
    @RequestMapping(value = "/market/exchange/record.do")
    public void marketExchangeRecord(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("userId");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.marketExchangeRecord(account);
            sendResponse(accountService, info, response);
        }

    }

    // 大伽汇用户兑换记录更新
    @RequestMapping(value = "/market/update/record.do")
    public void updateUserRecord(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("userId");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.updateUserRecord(account);
            sendResponse(accountService, info, response);
        }

    }

    // 大伽汇用户兑换记录更新
    @RequestMapping(value = "/message/center/changeallmessage.do")
    public void changeallmessage(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.changeallmessage(account);
            sendResponse(accountService, info, response);
        }

    }
    
 // 获得用户充值记录
    @RequestMapping(value = "/recharge/record.do")
    public void getRechargeRecord(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getRechargeRecord(account);
            sendResponse(accountService, info, response);
        }

    }
 // 获得用户提现记录
    @RequestMapping(value = "/withdraw/record.do")
    public void getWithdrawRecord(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getWithdrawRecord(account);
            sendResponse(accountService, info, response);
        }

    }
 // 更改用户手机号码
    @RequestMapping(value = "/change/mobile.do")
    public void changeMobile(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String m = request.getParameter("m");
        String c = request.getParameter("c");
        String s = request.getParameter("s");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.changeMobile(account,m,c,s);
            sendResponse(accountService, info, response);
        }

    }
    
 // 债权转让
    @RequestMapping(value = "/project/transfer.do")
    public void realTransfer(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String userId = (String) session.getAttribute("userId");
        String loanId = request.getParameter("loanId");
        String loanAmount = request.getParameter("loanAmount");
        String discountAmount = request.getParameter("discountAmount");
        String description = request.getParameter("description");
        if (EmptyUtils.isEmpty(userId)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.realTransfer(userId,loanId,loanAmount,discountAmount,description);
            sendResponse(accountService, info, response);
        }
    }
    
 // 获取我的银行信息
    @RequestMapping(value = "/mybandcard/info/get.do")
    public void myBandCardInfo(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String user = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(user)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.myBandCardInfo(user);
            sendResponse(accountService, info, response);
        }
    }
    
    //获取用户真实姓名
    @RequestMapping(value = "/realname/get.do")
    public void getRealname(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getRealname(account);
            sendResponse(accountService, info, response);
        }
    }
    //更改银行卡，验证用户身份
    @RequestMapping(value = "/change/bandcard/identify.do")
    public void changeCardIdentify(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String account = (String) session.getAttribute("loginUser");
        String code = request.getParameter("code");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.changeCardIdentify(account,code);
            sendResponse(accountService, info, response);
        }
    }
  //自动投标，获取常量
    @RequestMapping(value = "/autoinvest/constant/get.do")
    public void getAutoConstant(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String userId = (String) session.getAttribute("userId");
        if (EmptyUtils.isEmpty(userId)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = accountService.getAutoConstant(userId);
            sendResponse(accountService, info, response);
        }
    }
  //自动投标，保存设置
    @RequestMapping(value = "/autoinvest/set/save.do")
    public void saveAutoSet(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String userId = (String) session.getAttribute("userId");
        String autoBidId = request.getParameter("autoBidId");
        String enable = request.getParameter("enable");
        String reserve = request.getParameter("reserve");
        String investType = request.getParameter("investType");
        String investMin = request.getParameter("investMin");
        String investMax = request.getParameter("investMax");
        String projectType = request.getParameter("projectType");
        String repaymentWay = request.getParameter("repaymentWay");
        String period = request.getParameter("period");
        String isNoLimitRate = request.getParameter("isNoLimitRate");
        String rateMin = request.getParameter("rateMin");
        String rateMax = request.getParameter("rateMax");
        if (EmptyUtils.isEmpty(userId)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("userId", userId);
            params.put("autoBidId", autoBidId);
            params.put("enable", enable);
            params.put("reserve", reserve);
            params.put("investType", investType);
            params.put("investMin", investMin);
            params.put("investMax", investMax);
            params.put("projectType", projectType);
            params.put("repaymentWay", repaymentWay);
            params.put("period", period);
            params.put("isNoLimitRate", isNoLimitRate);
            params.put("rateMin", rateMin);
            params.put("userId", userId);
            params.put("rateMax", rateMax);
            String info = accountService.saveAutoSet(params);
            sendResponse(accountService, info, response);
        }
    }
    
  //自动投标，获取自动投标列表
    @RequestMapping(value = "/autoinvest/set/query.do")
    public void getAutoList(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String userId = (String) session.getAttribute("userId");
        String autoBidId = request.getParameter("autoBidId");
        if (EmptyUtils.isEmpty(userId)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("userId", userId);
            params.put("autoBidId", autoBidId);
            String info = accountService.getAutoList(params);
            sendResponse(accountService, info, response);
        }
    }
  //自动投标，删除规则
    @RequestMapping(value = "/autoinvest/rule/delete.do")
    public void autoRuleDelete(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String userId = (String) session.getAttribute("userId");
        String autoBidId = request.getParameter("autoBidId");
        if (EmptyUtils.isEmpty(userId)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("userId", userId);
            params.put("autoBidId", autoBidId);
            String info = accountService.autoRuleDelete(params);
            sendResponse(accountService, info, response);
        }
    }
    //自动投标，删除规则
    @RequestMapping(value = "/transfer/cantransfer/get.do")
    public void getCanTransferList(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
        String userId = (String) session.getAttribute("userId");
        if (EmptyUtils.isEmpty(userId)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("userId", userId);
            String info = accountService.getCanTransferList(params);
            sendResponse(accountService, info, response);
        }
    }
    
     // 获取个人红包记录
        @RequestMapping(value = "/my/redenvelope/get.do")
        public void getRedEnvelopeInfo(HttpServletRequest request, HttpSession session,
                HttpServletResponse response) {
            String account = (String) session.getAttribute("userId");
            String projectId = request.getParameter("projectId");
            if (EmptyUtils.isEmpty(account)) {
                sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
            } else {
                String info = "";
                if(projectId !=null && projectId != ""){
                    info = accountService.getRedEnvelopeInfo(account,projectId);
                }else{
                    info = accountService.getRedEnvelopeInfo(account);
                }
                sendResponse(accountService, info, response);
            }
        }
     // 获取最新投资人
        @RequestMapping(value = "/recentlist/get.do")
        public void getRecentInvestList(HttpServletRequest request, HttpSession session,
                HttpServletResponse response) {
                String info = "";
                    info = accountService.getRecentInvestList();
                sendResponse(accountService, info, response);
        }
        
    //获取news list信息
    @RequestMapping(value = "/news/get.do")
    public void getNewsList(HttpServletRequest request,
            HttpSession session, HttpServletResponse response) {
            String info = accountService.getNewsList();
            sendResponse(accountService, info, response);
    }
    
    
 // 获取回款计划cardlist
    @RequestMapping(value = "repayment/plan/cardlist/get.do")
    public void getCardList(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("userId");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = "";
            info = accountService.getCardList(account);
            sendResponse(accountService, info, response);
        }
    }
 // 获取回款计划当月listDetails
    @RequestMapping(value = "/repayment/plan/listdetails/get.do")
    public void getCardListDetails(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String account = (String) session.getAttribute("userId");
        String paymentDate = request.getParameter("paymentDate");
        if (EmptyUtils.isEmpty(account)) {
            sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
        } else {
            String info = "";
            info = accountService.getCardListDetails(account,paymentDate);
            sendResponse(accountService, info, response);
        }
    }
    
    /**
     * 资金明细列表
     * @author wangya
     * @since 2017-02-06
     * @param request
     * @param session
     * @param response
     */
    @RequestMapping(value = "/getMyAccountList.do")
    public void getMyAccountList(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
    	Map<String, Object> params = new HashMap<String, Object>();
        String account = (String) session.getAttribute("userId");
        String currentPage = request.getParameter("currentPage");
        String pageSize = request.getParameter("pageSize");
        /*
         * type值描述 (1-全部；2-充值；3-提现；4-投资；5-回款；6-奖励；7-债权转让；)
         */
        String type = request.getParameter("type");
        try {
        	if (EmptyUtils.isEmpty(account)) {
                sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
            } else {
            	params.put("userId", account);
        		params.put("currentPage", currentPage);
        		params.put("pageSize", pageSize);
        		params.put("dataType", type);
                String info = "";
                info = accountService.getMyAccountList(params);
                sendResponse(accountService, info, response);
            }
        } catch (Exception e) {
        	e.printStackTrace();
        }
    }
    
    /**
     * 获取用户余额
     * @author wangya
     * @since 2017-07-02
     * @param request
     * @param session
     * @param response
     */
    @RequestMapping(value = "/getUserBalance.do")
    public void getUserBalance(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
    	Map<String, Object> params = new HashMap<String, Object>();
        String account = (String) session.getAttribute("userId");
        try {
        	if (EmptyUtils.isEmpty(account)) {
                sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
            } else {
            	params.put("userId", account);
                String info = "";
                info = accountService.getUserBalance(params);
                sendResponse(accountService, info, response);
            }
        } catch (Exception e) {
        	e.printStackTrace();
        }
    }
}
