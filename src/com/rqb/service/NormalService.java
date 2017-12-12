package com.rqb.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.rqb.common.Constants.Pks;
import com.rqb.common.SendRequest;
import com.rqb.service.abs.AbstractService;

@Service
public class NormalService extends AbstractService{
	
	public String getPeiziRate(){
		return SendRequest.post(config.get(Pks.NORMAL_GET_PEIZI_RATE), null);
	}
	public String getOralInvest(){
	    return SendRequest.post(config.get(Pks.NORMAL_GET_ORAL_INVEST_LIST), null);
	}
	public String showActiveLogo(String type){
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("type", type);
	    return SendRequest.post(config.get(Pks.NORMAL_SHOW_ACTIVE_LOGO), params);
	}
	public String getReferenceRankList(){
        return SendRequest.post(config.get(Pks.NORMAL_GET_REFERENCE_RANK_LIST), null);
	}
	public String getBannerList(String account){
	    Map<String, Object> params = new HashMap<String, Object>();
        params.put("u", account);
        return SendRequest.post(config.get(Pks.NORMAL_GET_BANNER_LIST), params);
	}
	 
}
