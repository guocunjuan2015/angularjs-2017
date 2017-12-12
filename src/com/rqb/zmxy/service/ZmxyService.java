package com.rqb.zmxy.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rqb.borrowing.jxl.vo.ApplyInfo;
import com.rqb.borrowing.jxl.vo.ReqMsg;
import com.rqb.common.SendRequest;
import com.rqb.common.Constants.Pks;
import com.rqb.service.abs.AbstractService;

/**
 * 聚信立
 * @author wangya
 * @since 2017-02-16
 */
@Service
public class ZmxyService extends AbstractService {
	
	/**
     * 芝麻信用授权(H5)
     *
     * @param response
     * @param request
     */
    @RequestMapping(value = "ZMAuthorization")
    @ResponseBody
    public String ZMAuthorization(Map<String, Object> params) throws Exception{
    	return SendRequest.post(config.get(Pks.BACKEND_URL_ZMXY_ZMAUTHORIZATION), params);
    }
}
