package com.rqb.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.rqb.common.Constants.Pks;
import com.rqb.common.SendRequest;
import com.rqb.service.abs.AbstractService;

@Service
public class AccountService extends AbstractService{
	public static final String INVEST_START = "1";
	public static final String INVEST_CHECK = "2";
	public static final String INVEST_SUCCESS = "3";
	
	public String getDetail(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.ACCOUNT_INFO_INCOME), params);
	}
	public String getRecordInfo(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.ACCOUNT_RECORD_INFO), params);
	}
	
	public String getRecord(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.ACCOUNT_INFO_RECORD), params);
	}
	
	public String getInvest(String account, String t,String s,String c){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		params.put("s", s);
		params.put("t", t);
		params.put("c", c);
		return SendRequest.post(config.get(Pks.ACCOUNT_INFO_SEARCHMYINVEST), params);
	}
	
	public String getTransferInvest(String account, String status){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("loginName", account);
        params.put("status", status);
        return SendRequest.post(config.get(Pks.ACCOUNT_INFO_SEARCH_TRANSFER_INVEST), params);
	}
	
	public String getTransfer(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.ACCOUNT_INFO_TRANSFOR), params);
	}
	
	public String getCoupon(String account, Integer type){
		String typeString = "";
		switch (type) {
		case 1: typeString = "ACTIVED_SUCCESSFULLY"; break;
		case 2:typeString = "INVESTED_SUCCESSFULLY,INVESTED_WAITING"; break;
		case 3:typeString = "EXPIRE_FOR_ACTIVE,EXPIRE_FOR_INVEST"; break;
		default:typeString = "ACTIVED_SUCCESSFULLY"; break;
		}
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		params.put("s", typeString);
		return SendRequest.post(config.get(Pks.VOUCHER_COUPON), params);
	}

	public String getReward(String account, String projectId){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		params.put("k", projectId);
		return SendRequest.post(config.get(Pks.VOUCHER_REWARD), params);
	}
	
	public String getRuiqb(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.GET_REWARD_RUIQB), params);
	}
	
	public String ToExchangeRuiqb(String account, String numRqb){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		params.put("a", numRqb);
		return SendRequest.post(config.get(Pks.EXCHANGE_RUIQB), params);
	}
	
	public String getPointsInfo(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.GET_POINTS_INFO), params);
	}
	
	public String showExchangeHistory(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.SHOW_EXCHANGE_HISTORY), params);
	}
	
	public String getJifenInfo(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.VIP_CLUB_INFO), params);
	}
	
	public String showPointsHistory(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.POINTS_EXCHANGE_HISTORY), params);
	}
	
	public String showPointsRank(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.VIP_POINTS_RANK), params);
	}
	
	public String daySignIn(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.DAY_SIGN_IN), params);
	}
	public String getUserMobile(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.FIND_USER_NUMBER), params);
	}
	
	public String isVIPMember(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.CHECK_WHETHER_VIP_MEMBER), params);
	}
	
	public String canJoinVIPOrNot(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.CHECK_CAN_JOIN_VIP_CLUB), params);
	}
	
	public String check(String account){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		return SendRequest.post(config.get(Pks.REGISTER_CHECK_REGISTER_STATUS), params);
	}
	
	public String checkCopMax(String account,String money,String id){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		params.put("k", id);
		params.put("a", money);
		return SendRequest.post(config.get(Pks.CHECK_MAX_COUPON_CAN_USE), params);
	}
	public String getRatePercent(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("u", account);
	    return SendRequest.post(config.get(Pks.MY_REWARD_GET_RATE_PERCENT), params);
	}
	
	public String checkMessageHasRead(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("u", account);
	    return SendRequest.post(config.get(Pks.PERSONAL_CENTER_CEHCK_MESSAGE_HAS_READ), params);
	}
	public String deleteSingleMessage(String account,String msgid){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        params.put("id", msgid);
        return SendRequest.post(config.get(Pks.MESENGE_CENTER_DELETE_SINGLE_MESSAGE), params);
	}
	
	public String getReferReward(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.GET_REFER_REWARD), params);
	}
	
	public String getMyRefer(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.GET_REFER_OF_MY_FRIENTDS), params);
	}
	
	public String getMessageCenter(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.GET_MESSAGE_CENTER_INFO), params);
	}
	
	public String changeRecord(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.GET_CHANGE_RECORD_INFO), params);
	}
	
	public String getPointsDetails(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.GET_POINTS_DETAILS), params);
	}
	
	public String pointsExchange(String account,String a){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        params.put("a", a);
        return SendRequest.post(config.get(Pks.POINTS_EXCHANGE_COUPON), params);
	}
	
	public String getTicketInfo(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.GET_PERSONAL_TICKET_INFO), params);
	}
	public String getRedEnvelopeInfo(String account,String projectId){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", account);
        params.put("projectId", projectId);
        return SendRequest.post(config.get(Pks.GET_PERSONAL_RED_ENVELOPE_INFO), params);
	}
	public String getRedEnvelopeInfo(String account){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", account);
        return SendRequest.post(config.get(Pks.GET_PERSONAL_RED_ENVELOPE_INFO), params);
    }
	public String getRecentInvestList(){
	    return SendRequest.post(config.get(Pks.GET_RECENT_INVEST_LIST), null); 
	}
    public String getTicketInfo(String account,String projectId){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        params.put("projectId", projectId);
        return SendRequest.post(config.get(Pks.GET_PERSONAL_TICKET_INFO), params);
    }
	public String getCouponInfo(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.GET_PERSONAL_COUPON_INFO), params);
	}
	public String getCouponInfo(String account,String projectId,String moneyInvest){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        params.put("projectId", projectId);
        params.put("investAmount", moneyInvest);
        return SendRequest.post(config.get(Pks.GET_PERSONAL_COUPON_INFO), params);
    }
	public String getCouponDetails(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.GET_EXCHANGE_COUPON_DETAILS), params);
	}
	
	public String activeCoupon(String account,String n,String c){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        params.put("n", n);
        params.put("c", c);
        return SendRequest.post(config.get(Pks.COUPON_ACTIVE), params);
	}
	public String activeTicket(String account,String n,String c){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        params.put("n", n);
        params.put("c", c);
        return SendRequest.post(config.get(Pks.TICKET_ACTIVE), params);
    }
	public String activeMorerate(String account,String n,String c){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        params.put("n", n);
        params.put("c", c);
        return SendRequest.post(config.get(Pks.MORERATE_ACTIVE), params);
	}
	public String getMarketList(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", account);
        return SendRequest.post(config.get(Pks.ACCOUNT_MARKET_GET_LIST), params);
	}
	public String couponExchange(String account,String shopid,String point,String method,String channel){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", account);
        params.put("points", point);
        params.put("shopId", shopid);
        params.put("type", method);
        params.put("channel", channel);
        return SendRequest.post(config.get(Pks.ACCOUNT_MARKET_COUPON_EXCHANGE), params);
	}
	public String marketDetails(){
	    return SendRequest.post(config.get(Pks.ACCOUNT_MARKET_GET_DETAILS), null);
	}
	public String marketExchangeRecord(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", account);
        return SendRequest.post(config.get(Pks.ACCOUNT_MARKET_EXCHANGE_RECORD), params);
	}
	public String updateUserRecord(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", account);
        return SendRequest.post(config.get(Pks.ACCOUNT_MARKET_UPDATE_USER_RECORD), params);
	}
	public String changeallmessage(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.MESSAGE_CENTER_CHANGE_ALL_MESSAGE_STATUS), params);
	}
	public String getRechargeRecord(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.RQB_ACCOUNT_RECHARGE_RECORD), params);
	}
	public String getWithdrawRecord(String account){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.RQB_ACCOUNT_WITHDRAW_RECORD), params);
    }
	public String changeMobile(String account,String m,String c,String s){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        params.put("m", m);
        params.put("c", c);
        params.put("s", s);
        return SendRequest.post(config.get(Pks.RQB_ACCOUNT_CHANGE_MOBILE), params);
	}
	public String realTransfer(String userId,String loanId,String loanAmount,
	        String discountAmount,String description){//债权转让
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", userId);
        params.put("loanId", loanId);
        params.put("loanAmount", loanAmount);
        params.put("discountAmount", discountAmount);
        params.put("description", description);
        return SendRequest.post(config.get(Pks.RQB_ACCOUNT_PROJECT_TRANSFER), params);
	}
	
	public String myBandCardInfo(String user){
	        Map<String, Object> params = new HashMap<String, Object>();
	        params.put("loginName", user);
	        return SendRequest.post(config.get(Pks.RQB_MY_BAND_CARD_INFO), params);
	}
	public String getRealname(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.RQB_ACCOUNT_GET_USER_REALNAME), params);
	}
	public String changeCardIdentify(String account,String code){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("loginName", account);
        params.put("code", code);
        return SendRequest.post(config.get(Pks.RQB_CHANGE_CARD_INDENTIFY), params);
	}
	public String getAutoConstant(String userId){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", userId);
	    return SendRequest.post(config.get(Pks.RQB_AUTO_INVEST_CONSTANT_GET), params);
	}
	public String saveAutoSet(Map<String, Object> params){
	    return SendRequest.post(config.get(Pks.RQB_AUTO_INVEST_SET_SAVE), params);
	}
	public String getAutoList(Map<String, Object> params){
	    return SendRequest.post(config.get(Pks.RQB_AUTO_INVEST_GET_LIST), params);
	}
	public String autoRuleDelete(Map<String, Object> params){
	    return SendRequest.post(config.get(Pks.RQB_AUTO_INVEST_RULE_DELETE), params);
	}
	public String getCanTransferList(Map<String, Object> params){
	    return SendRequest.post(config.get(Pks.RQB_GET_CAN_TRANSFER_LIST), params);
	}
	public String getNewsList(){
        return SendRequest.post(config.get(Pks.RQB_ACCOUNT_GET_NEWS_LIST), null);
	}
	public String getCardList(String userId){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", userId);
        return SendRequest.post(config.get(Pks.RQB_ACCOUNT_REPAYMENT_CARD_LIST), params);
	}
	public String getCardListDetails(String userId,String paymentDate){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", userId);
        params.put("paymentDate", paymentDate);
        return SendRequest.post(config.get(Pks.RQB_ACCOUNT_REPAYMENT_CARD_DETAILS_LIST), params);
	}
	
	/**
	 * 获取我的资金明细列表
	 * @author wangya
	 * @since 2017-02-06
	 * @param request
	 * @return
	 */
	public String getMyAccountList (Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.ACCOUNT_FUNDING_LIST), params);
	}
	
	/**
	 * 获取账户余额
	 * @author wangya
	 * @since 2017-07-02
	 * @param request
	 * @return
	 */
	public String getUserBalance (Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.ACCOUNT_BALANCE), params);
	}
}
