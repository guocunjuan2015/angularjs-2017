package com.rqb.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.rqb.common.Constants.Pks;
import com.rqb.common.SendRequest;
import com.rqb.service.abs.AbstractService;

@Service
public class PointsService extends AbstractService{
	
	public String getTaskDetails(Map<String, Object> params){
		return SendRequest.post(config.get(Pks.POINTS_POINTS_TASK_DETAILS), params);
	}
	
	public String getShakeSignInfo(Map<String, Object> params){
        return SendRequest.post(config.get(Pks.POINTS_POINT_SHAKE_SIGN_INFO), params);
    }
	
	public String saveSign(Map<String, Object> params){
        return SendRequest.post(config.get(Pks.POINTS_SAVE_SIGN), params);
    }
	 
}
