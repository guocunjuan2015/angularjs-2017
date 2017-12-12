package com.rqb.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rqb.common.Constants.Pks;
import com.rqb.common.SendRequest;
import com.rqb.service.abs.AbstractService;

import net.sf.json.JSONObject;

@Service
public class ProjectService extends AbstractService{
	public static final String ALL = "000";
	public static final String FUND = "108";
	public static final String TRANSFER = "106";
	public static final String ASSURE = "200";
	public static final String BAOLI = "109";
	public static final String JIAOYU = "120";
	public static final String GEDAI = "121";
	
	public String getProject(){
		return SendRequest.post(config.get(Pks.PROJECT_LOANS), null);
	}
	
	public String getProject(String type){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("projectType", type);
		params.put("loanAmount", "609");
		params.put("loanRate", "631");
		params.put("loanPeriod", "621");
		return SendRequest.post(config.get(Pks.PROJECT_LOANSCLASSIFY), params);
	}
	
	/**
	 * 获取产品列表
	 * @author wangya
	 * @since 2016-01-03
	 * @param projectType
	 * @param pageSize
	 * @param currentPage
	 * @param from
	 * @return
	 */
	public String getNewProject(String projectType,
			String pageSize,String currentPage, String from, String userId){
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("projectType", projectType);
	    params.put("currentPage", currentPage);
	    params.put("pageSize", pageSize);
	    params.put("from", from);
	    params.put("userId", userId);
	    return SendRequest.post(config.get(Pks.PROJECT_LOANS_LIST), params);
	}
	
	public String getNewProject(String type,String childType,String status,
	        String order, String orderType,String index,String size,String from){
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("type", type);
	    params.put("childType", childType);
	    params.put("status", status);
	    params.put("order", order);
	    params.put("orderType", orderType);
	    params.put("index", index);
	    params.put("size", size);
	    params.put("from", from);
	    return SendRequest.post(config.get(Pks.PROJECT_NEW_LOANS), params);
	}
	
	public String getTransferList(String type,String childType,String status,
            String order, String orderType,String index,String size){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("type", type);
        params.put("childType", childType);
        params.put("status", status);
        params.put("order", order);
        params.put("orderType", orderType);
        params.put("index", index);
        params.put("size", size);
        return SendRequest.post(config.get(Pks.PROJECT_TRANSFER_LOANS), params);
    }
	public String getBingGoRate(String projectId,String amount){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("projectId", projectId);
        params.put("amount", amount);
        return SendRequest.post(config.get(Pks.PROJECT_BINGGO_RATE), params);
	}
	public String getTransferBuyRecord(String projectId,String pageSize,String pageNo){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("projectId", projectId);
        params.put("pageSize", pageSize);
        params.put("pageNo", pageNo);
        return SendRequest.post(config.get(Pks.PROJECT_TRANSFER_BUY_RECORD), params);
	}
	public String checkContributionPsw(String projectId,String password){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("projectId", projectId);
        params.put("password", password);
        return SendRequest.post(config.get(Pks.PROJECT_CHECK_CONTRIBUTION_PSW), params);
	}
	
	public String find(String id){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("k", id);
		return SendRequest.post(config.get(Pks.PROJECT_VLOAN), params);
	}
	public String transferFind(String id){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("projectId", id);
        return SendRequest.post(config.get(Pks.PROJECT_TRANSFER_VLOAN), params);
    }
	
	public String detail(String id){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("k", id);
		return SendRequest.post(config.get(Pks.PROJECT_INVESTMORE), params);
	}
	
	public String invest(String id, String account, String money, String loginPassword,
			String password,String code,String couponId,String ticketId,String tel,String f){
		_log.info("account [" + account + "] invest project [" + id + "] -> money = " + money);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("k", id);
		params.put("u", account);
		params.put("m", money);
		params.put("p", loginPassword);
		params.put("y", password);
		params.put("code", code);
		params.put("c", couponId);
		params.put("t", ticketId);
		params.put("tel", tel);
		params.put("f", f);
		return SendRequest.post(config.get(Pks.CONFIRM_INVEST_TOPAY), params);
	}
	
	public String getCoupon(String account,String projectIdToCop){//获取代金券，投资券
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		params.put("k", projectIdToCop);
		return SendRequest.post(config.get(Pks.GET_ALL_COUPON), params);
	}
	public String getProjectInfo(String account,String id){//获取投资项目信息
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("u", account);
		params.put("k", id);
		return SendRequest.post(config.get(Pks.FIND_PROJECT_INFO), params);
	}
	
	public String getProjectMoreDetails(String id){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("k", id);
        return SendRequest.post(config.get(Pks.RQB_GET_PROJECT_MORE_INFO), params);
	}
	public String getTransferProjectMoreDetails(String id){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("projectId", id);
        return SendRequest.post(config.get(Pks.RQB_GET_TRANSFER_PROJECT_MORE_INFO), params);
    }
	
	public String getProjectInvestRecord(String id){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("k", id);
        return SendRequest.post(config.get(Pks.RQB_GET_PROJECT_INVEST_RECORD), params);
	}
	public String getTransferProjectInvestRecord(String id){
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("projectId", id);
        return SendRequest.post(config.get(Pks.RQB_GET_TRANSFER_PROJECT_INVEST_RECORD), params);
    }
	
	public String getNoticeInfo(String n,String c){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("n", n);
        params.put("c", c);
        return SendRequest.post(config.get(Pks.RQB_PROJECT_GET_NOTICE_INFO), params);
	}
	public String getNoticeDetails(String k){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("k", k);
        return SendRequest.post(config.get(Pks.RQB_PROJECT_GET_NOTICE_DETAILS), params);
	}
	public String getWapData(){
        return SendRequest.post(config.get(Pks.RQB_HOME_WAP_DATA), null);
	}
	
	/**
	 * 获取产品详情
	 * @author wangya
	 * @since 2016-01-04
	 * @param projectType
	 * @param pageSize
	 * @param currentPage
	 * @param from
	 * @return
	 */
	public String getLoanDetail(String projectId, String projectType, String userId) {
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("projectId", projectId);
	    params.put("projectType", projectType);
	    params.put("userId", userId);
	    return SendRequest.post(config.get(Pks.PROJECT_LOANS_DETAIL), params);
	}
	
	/**
	 * 首页数据接口
	 * @author wangya
	 * @since 2017-01-04
	 * @param userId
	 * @return
	 */
	public String getHomeInfo(String userId) {
		Map<String, Object> params = new HashMap<String, Object>();
	    params.put("userId", userId);
	    return SendRequest.post(config.get(Pks.PROJECT_HOME_INFO), params);
	}
	
	/**
	 * 我的投资 - 投资列表和转让列表
	 * @author wangya
	 * @since 2017-01-09
	 * @param request
	 * @param response
	 * @return
	 */
	public String getMyInvestList(Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.PROJECT_MY_INVEST_LIST), params);
	}
	
	/**
	 * 我的投资祥情
	 * @author wangya
	 * @since 2017-01-09
	 * @param request
	 * @param response
	 * @return
	 */
	public String getMyInvestDetail(Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.PROJECT_MY_INVEST_DETAIL), params);
	}
	
	/**
	 * 产品详情页投资记录
	 * @author wangya
	 * @since 2017-01-10
	 * @param request
	 * @param response
	 * @return
	 */
	public String getRyInvestList(Map<String, Object> params) {
		return SendRequest.post(config.get(Pks.PROJECT_RY_INVEST_LIST), params);
	}
	
	/**
	 * 借款申请接口
	 * @author wangya
	 * @since 2017-02-22
	 * @param request
	 * @param response
	 * @return
	 */
	public String apply(JSONObject jsonObject) {
		return SendRequest.post(config.get(Pks.BACKEND_URL_LOAN_APPLY), jsonObject);
	}
}
