package com.rqb.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.rqb.common.Constants.Msg;
import com.rqb.common.Constants.Pks;
import com.rqb.common.SendRequest;
import com.rqb.service.abs.AbstractService;

@Service
public class UMPService extends AbstractService{
	
	
	public String searchBranch(String cityCode,String bankCode,String branchName){
		String url = config.get(Pks.SEARCH_BRANCH_NAME)+"?cityCode="+cityCode+"&bankCode="+bankCode+"&branchName="+branchName;
		_log.info("searchBranch info -> " + url);
		return SendRequest.post(url, null);
	}
	
	public String checkRegisterStatus(String u,String p){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", u);
        params.put("p", p);
        String url = config.get(Pks.CHECK_UMP_STATUS_START_TIME);
        String result = SendRequest.post(url, params);
        _log.info("ump check register status result -> " + result);
        return result;
	}
	
	public String checkUMPStart(){
	    String url = config.get(Pks.CHECK_UMP_STATUS_START_TIME);
	    String result = SendRequest.post(url, null);
	    return result;
	}
	
	public String umpBindCard(String account, String isOpenFastPayment,String cardId,String retUrl,String cardCode){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("loginName", account);
        params.put("isOpenFastPayment", isOpenFastPayment);
        params.put("cardId", cardId);
        params.put("retUrl", retUrl);
        params.put("cardCode", cardCode);
        return SendRequest.post(config.get(Pks.RQB_UMP_BIND_CARD), params);
	}
	public String umpChangeCard(String account, String isOpenFastPayment,String cardId,String retUrl,String cardCode){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("loginName", account);
        params.put("isOpenFastPayment", isOpenFastPayment);
        params.put("cardId", cardId);
        params.put("retUrl", retUrl);
        params.put("cardCode", cardCode);
        return SendRequest.post(config.get(Pks.RQB_UMP_CHANGE_CARD), params);
    }
	
	public String umpMoneyRecharge(String account,String amount,String payType,String retUrl){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("loginName", account);
        params.put("amount", amount);
        params.put("payType", payType);
        params.put("retUrl", retUrl);
        return SendRequest.post(config.get(Pks.RQB_UMP_MONEY_RECHARGE), params);
	}
	
	public String umpMoneyCash(String account,String amount,String retUrl){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("loginName", account);
        params.put("amount", amount);
        params.put("retUrl", retUrl);
        return SendRequest.post(config.get(Pks.RQB_UMP_MONEY_CASH), params);
	}
	public String umpInvestFbaba(String account,String amount,String loanId,String ticketId,String couponId,String moreRateId,String channel,String retUrl,String utm_source,String uid){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("loginName", account);
        params.put("amount", amount);
        params.put("loanId", loanId);
        params.put("ticketId", ticketId);
        params.put("couponId", couponId);
        params.put("morerateId", moreRateId);
        params.put("channel", channel);
        params.put("retUrl", retUrl);
        params.put("utm_source", utm_source);
        params.put("uid", uid);
        return SendRequest.post(config.get(Pks.RQB_UMP_INVEST), params);
    }
	public String umpTransferInvestFbaba(String account,String amount,String loanId,String ticketId,String couponId,String moreRateId,String channel,String retUrl,String utm_source,String uid){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("loginName", account);
        params.put("amount", amount);
        params.put("loanId", loanId);
        params.put("ticketId", ticketId);
        params.put("couponId", couponId);
        params.put("morerateId", moreRateId);
        params.put("channel", channel);
        params.put("retUrl", retUrl);
        params.put("utm_source", utm_source);
        params.put("uid", uid);
        return SendRequest.post(config.get(Pks.RQB_UMP_TRANSFER_INVEST), params);
    }
	public String umpInvest(String account,String amount,String loanId,String ticketId,String couponId,String moreRateId, String channel,String retUrl){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("loginName", account);
        params.put("amount", amount);
        params.put("loanId", loanId);
        params.put("ticketId", ticketId);
        params.put("couponId", couponId);
        params.put("morerateId", moreRateId);
        params.put("channel", channel);
        params.put("retUrl", retUrl);
        return SendRequest.post(config.get(Pks.RQB_UMP_INVEST), params);
	}
	public String umpTransferInvest(String account,String amount,String loanId,String ticketId,String couponId,String moreRateId,String channel,String retUrl){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("loginName", account);
        params.put("amount", amount);
        params.put("loanId", loanId);
        params.put("ticketId", ticketId);
        params.put("couponId", couponId);
        params.put("morerateId", moreRateId);
        params.put("channel", channel);
        params.put("retUrl", retUrl);
        return SendRequest.post(config.get(Pks.RQB_UMP_TRANSFER_INVEST), params);
    }
	
	public String payPswReset(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("loginName", account);
	    return SendRequest.post(config.get(Pks.RQB_UMP_PAY_PASSWORD_RESET), params);
	}
	public String openPayment(String account,String payment,String retUrl){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("loginName", account);
        params.put("payment", payment);
        params.put("retUrl", retUrl);
        return SendRequest.post(config.get(Pks.RQB_UMP_OPEN_PAYMENT), params);
    }
	public String cloasePayment(String account,String payment,String retUrl){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", account);
        params.put("payment", payment);
        params.put("retUrl", retUrl);
        return SendRequest.post(config.get(Pks.RQB_UMP_CLOSE_PAYMENT), params);
	}
}
