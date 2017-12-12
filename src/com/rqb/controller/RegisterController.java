package com.rqb.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Hex;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.rqb.common.ClientIPUtils;
import com.rqb.common.ConfigManager;
import com.rqb.common.SendRequest;
import com.rqb.controller.abs.AbstractController;
import com.rqb.service.RegisterService;
import com.ruiqt.lianlian.security.Md5Algorithm;
import com.ultrapower.cloudup.utils.EmptyUtils;

@Controller
@RequestMapping(value="/register")
public class RegisterController extends AbstractController{
	private static final Logger log = Logger.getLogger(RegisterController.class);
	private static final String BEIQING = "beiqing";
	 
	@Autowired
	private RegisterService registerService;
	
	/**注册*/
	@RequestMapping(value = "/regist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void register(HttpServletRequest request, HttpServletResponse response){
		try{
			log.info("RegisterController.register start");
			String u = request.getParameter("u"); //用户名
			String p = request.getParameter("p");
			String from = request.getParameter("f");
			String h = request.getParameter("h");
			String marny_id = request.getParameter("marny_id");//玛尼赚参数
			String hid = request.getParameter("hid");//和堂uid
			log.info("hid==="+hid);
			String hostName = request.getParameter("hostName");//主播代号
			log.info("hostName==="+hostName);
			//注册
			Map<String,Object> regParam = new HashMap<String,Object>();
			regParam.put("u", u); 
			regParam.put("p", p); //登陆密码
			regParam.put("m", request.getParameter("m")); //手机号
			regParam.put("c", request.getParameter("c")); //手机验证码
			regParam.put("f", from); //推荐人
			regParam.put("h", h); //推荐人
			regParam.put("referrer", request.getParameter("referrer")); //推荐人
			regParam.put("mid", marny_id); //玛尼赚参数
			regParam.put("hid", hid); //和堂uid
			regParam.put("hostName", hostName); //主播代号
			regParam.put("ip", ClientIPUtils.getClientIp(request));
			String result = registerService.register(regParam);
			
			JSONObject resultObject = JSON.parseObject(result);
			String res = resultObject.get("result").toString();
			if(Integer.parseInt(res) == 1){
				request.getSession().setAttribute("loginUser", u);
				request.getSession().setAttribute("loginPassword", p);
				log.info("RegisterController.register loginUser add session" + u);
				
				//获取userID
				if (resultObject!=null && resultObject.containsKey("resultObject")){
		            Object obj = resultObject.get("resultObject");
		            if (obj instanceof JSONObject){
		            JSONObject accountObject=resultObject.getJSONObject("resultObject");
		            if(accountObject!= null && accountObject.containsKey("userId")){
		                 String userId = accountObject.getString("userId");
		                 String tel = accountObject.getString("m");
		                 request.getSession().setAttribute("userId", userId);
		                 request.getSession().setAttribute("tel", tel);
		            }
		            _log.info("after hex --> " + result);
		            }
		        }
			}else{
				request.getSession().setAttribute("loginUser", "");
				request.getSession().setAttribute("loginPassword", "");
			}
            
			sendResponse(registerService, result, response);            
			log.info("RegisterController.register end result = " + result);
            regCallback(res, marny_id);//玛尼赚回调
		} catch (Exception e) {
			log.error("RegisterController.register error " + e);
			sendResponse(false, "服务器错误", null, response);
		}
	}
    
    /**
     * 玛尼赚注册回调
     *
     * @param result 注册结果
     * @param channelFlag 渠道标识
     * @return
     */
    private void regCallback(String result, String channelFlag) {

        if (!EmptyUtils.isEmpty(channelFlag) && !"null".equals(channelFlag) && Integer.parseInt(result) == 1) {//注册成功后回调
            log.info("玛尼赚回调开始...marny_id=" + channelFlag);
            String key = Md5Algorithm.getInstance().md5Digest((channelFlag + ConfigManager.getInstance().getProperty("marny.secret.key")).getBytes()).substring(8);
            String url = ConfigManager.getInstance().getProperty("marny.regCallback.url");
            SendRequest.requestByGetMethod(url + "?marny_id=" + channelFlag + "&keyt=" + key);//请求玛尼赚返回结果
        }
    }
	
	/**检查用户是否存在*/
	@RequestMapping(value = "/checkUser.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void checkUser(HttpServletRequest request, HttpServletResponse response){
		try{
			log.info("RegisterController.checkUser start");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("u", request.getParameter("u"));
			params.put("m", request.getParameter("m"));
			String result = registerService.checkUser(params);
			sendResponse(registerService, result, response);
			log.info("RegisterController.checkUser end result = " + result);
		} catch (Exception e) {
			log.error("RegisterController.checkUser error " + e);
			sendResponse(false, "服务器错误", null, response);
		}
	}
	
	/**获取手机验证码*/
	@RequestMapping(value = "/getMCode.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void getMCode(HttpServletRequest request, HttpServletResponse response){
		try{
			log.info("RegisterController.getMCode start");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("m", request.getParameter("m")); //手机号
			
			String result = registerService.getMCode(params);
			sendResponse(registerService, result, response);
			log.info("RegisterController.getMCode end result = "+result);
		} catch (Exception e) {
			log.error("RegisterController.getMCode error " + e);
			sendResponse(false, "服务器错误", null, response);
		}
	}
	
	 
	/**获取语音验证码*/
	@RequestMapping(value = "/getRadioCode.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void getRadioCode(HttpServletRequest request, HttpServletResponse response){
		try{
			log.info("RegisterController.getRadioCode start");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("m", request.getParameter("m")); //手机号
			
			String result = registerService.getRadioCode(params);
			sendResponse(registerService, result, response);
			log.info("RegisterController.getRadioCode end result = "+result);
		} catch (Exception e) {
			log.error("RegisterController.getRadioCode error " + e);
			sendResponse(false, "服务器错误", null, response);
		}
	}
	
	
    /** 登录 */
    @RequestMapping(value = "/login.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void login(HttpServletRequest request, HttpServletResponse response) {
        log.info("RegisterController.login start");
        String u = request.getParameter("u");
        String p = request.getParameter("p");
        if (u == null || "".equals(u) || p == null || "".equals(p)) {
            String result = getResult(0, "用户名和密码不能为空！");
            sendResponse(registerService, result, response);
        } else {
            try {
                Map<String, Object> loginParams = new HashMap<String, Object>();
                loginParams.put("u", request.getParameter("u"));
                loginParams.put("p", request.getParameter("p"));
                String result = registerService.login(loginParams);

                JSONObject resultObject = JSON.parseObject(result);
                String res = resultObject.get("result").toString();
                if (Integer.parseInt(res) == 1) {
                    request.getSession().setAttribute(
                            "loginUser",
                            resultObject.getJSONObject("resultObject")
                                    .getString("u"));
                    request.getSession().setAttribute("loginPassword",
                            request.getParameter("p"));
                    log.info("RegisterController.login loginUser add session"
                            + request.getParameter("u"));
                    log.info("RegisterController.login loginUser add session");
                    // 获取userId
                    if (resultObject != null
                            && resultObject.containsKey("resultObject")) {
                        Object obj = resultObject.get("resultObject");
                        if (obj instanceof JSONObject) {
                            JSONObject accountObject = resultObject
                                    .getJSONObject("resultObject");
                            if (accountObject != null
                                    && accountObject.containsKey("userId")) {
                                String userId = accountObject
                                        .getString("userId");
                                String tel = accountObject.getString("m");
                                request.getSession().setAttribute("userId",
                                        userId);
                                request.getSession().setAttribute("tel", tel);
                            }
                        }
                    }
                } else {
                    request.getSession().setAttribute("loginUser", "");
                    // request.getSession().setAttribute("loginPassword", "");
                }
                sendResponse(registerService, result, response);
                log.info("RegisterController.login end result = " + result);
            } catch (Exception e) {
            	e.printStackTrace();
                log.error("RegisterController.login error " + e);
                sendResponse(false, "服务器错误", null, response);
            }
        }
    }
	
	/**注销*/
	@RequestMapping(value = "/logout.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void logout(HttpServletRequest request, HttpServletResponse response){
		log.info("RegisterController.logout start");
		request.getSession().setAttribute("loginUser", null);
		request.getSession().setAttribute("userId", null);
		sendResponse(true, "操作成功", null, response);
	}
	
	/**实名认证*/
	@RequestMapping(value = "/realName.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void realName(HttpServletRequest request, HttpServletResponse response){
		log.info("RegisterController.realName start");
		//认证
		try {
			//已登录用户才可以实名认证
			Object userObj = request.getSession().getAttribute("loginUser");
			String u = "";
			if(null != userObj && !"".equals(userObj.toString())){
				u = userObj.toString();
				Map<String,Object> authParam = new HashMap<String,Object>();
				authParam.put("u", u); //用户名
				authParam.put("r", request.getParameter("r")); //真实姓名
				authParam.put("n", request.getParameter("n")); //身份证号
				String authRes = registerService.authentication(authParam);
				
				sendResponse(registerService, authRes, response);
				log.info("RegisterController.realName end result = "+authRes);
			}else{
				
				String result = getResult(0,"请登录再实名认证!");
				sendResponse(registerService, result, response);
				log.info("RegisterController.realName end result = "+result);
			}
			
			
		} catch (Exception e) {
			log.error("RegisterController.realName error " + e);
			sendResponse(false, "服务器错误", null, response);
		}
		
	}
	
	
	/**UMP实名认证及注册*/
    @RequestMapping(value = "/ump/register.do", method = {RequestMethod.GET, RequestMethod.POST})
    public void umpRegister(HttpServletRequest request, HttpServletResponse response){
        log.info("RegisterController.realName start");
        //认证
        try {
            //已登录用户才可以实名认证
            Object userObj = request.getSession().getAttribute("loginUser");
            String u = "";
            if(null != userObj && !"".equals(userObj.toString())){
                u = userObj.toString();
                Map<String,Object> authParam = new HashMap<String,Object>();
                authParam.put("loginName", u); //用户名
                authParam.put("realName", request.getParameter("r")); //真实姓名
                authParam.put("cardNo", request.getParameter("n")); //身份证号
                String authRes = registerService.umpRegister(authParam);
                sendResponse(registerService, authRes, response);
                log.info("RegisterController.realName end result = "+authRes);
            }else{
                String result = getResult(0,"请登录再实名认证!");
                sendResponse(registerService, result, response);
                log.info("RegisterController.realName end result = "+result);
            }
            
            
        } catch (Exception e) {
            log.error("RegisterController.realName error " + e);
            sendResponse(false, "服务器错误", null, response);
        }
        
    }
	
	
	/**修改登录密码*/
	@RequestMapping(value = "/modifyPassword.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void modifyPassword(HttpServletRequest request, HttpServletResponse response){
		log.info("RegisterController.modifyPassword start");
		try {
			//已登录用户才可以修改登录密码
			Object userObj = request.getSession().getAttribute("loginUser");
			String u = "";
			if(null != userObj && !"".equals(userObj.toString())){
				u = userObj.toString();
				Map<String,Object> modifyParam = new HashMap<String,Object>();
				modifyParam.put("u", u); //用户名
				modifyParam.put("o", request.getParameter("o")); //旧密码
				modifyParam.put("p", request.getParameter("p")); //新密码
				String result = registerService.modifyPassword(modifyParam);
				
				sendResponse(registerService, result, response);
				log.info("RegisterController.modifyPassword end result = "+result);
			}
		} catch (Exception e) {
			log.error("RegisterController.modifyPassword error " + e);
			sendResponse(false, "服务器错误", null, response);
		}
		
	}
	
	/**修改支付密码*/
	@RequestMapping(value = "/modifyPayPassword.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void modifyPayPassword(HttpServletRequest request, HttpServletResponse response){
		log.info("RegisterController.modifyPayPassword start");
		try {
			//已登录用户才可以修改登录密码
			Object userObj = request.getSession().getAttribute("loginUser");
			String u = "";
			if(null != userObj && !"".equals(userObj.toString())){
				u = userObj.toString();
				Map<String,Object> modifyPayParam = new HashMap<String,Object>();
				modifyPayParam.put("u", u); //登录密码
				modifyPayParam.put("o", request.getParameter("o")); //登录密码
				modifyPayParam.put("p", request.getParameter("p")); //新密码
				String result = registerService.modifyPayPassword(modifyPayParam);
				
				sendResponse(registerService, result, response);
				log.info("RegisterController.modifyPayPassword end result = "+result);
			}
		} catch (Exception e) {
			log.error("RegisterController.modifyPayPassword error " + e);
			sendResponse(false, "服务器错误", null, response);
		}
		
	}
	
	/**重置密码*/
	@RequestMapping(value = "/findPW.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void findPW(HttpServletRequest request, HttpServletResponse response){
		log.info("RegisterController.findPW start");
		try {
			Map<String,Object> findPwParam = new HashMap<String,Object>();
			findPwParam.put("m", request.getParameter("m")); //手机号
			findPwParam.put("c", request.getParameter("c")); //验证码
			findPwParam.put("p", request.getParameter("p")); //密码
			findPwParam.put("r", request.getParameter("r")); //重置密码
			String result = registerService.findPW(findPwParam);
			
			sendResponse(registerService, result, response);
			log.info("RegisterController.findPW end result = "+result);
		} catch (Exception e) {
			log.error("RegisterController.findPW error " + e);
			sendResponse(false, "服务器错误", null, response);
		}
		
	}
	
	/**检查手机号是否被重用*/
	@RequestMapping(value = "/checkmobile/used.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void checkMobileUsed(HttpServletRequest request, HttpServletResponse response){
		log.info("RegisterController.checkMobileUsed");
		try {
			String m = request.getParameter("m"); //手机号
			String result = registerService.checkMobileUsed(m);
			sendResponse(registerService, result, response);
			log.info("RegisterController.findPW end result = "+result);
		} catch (Exception e) {
			log.error("RegisterController.findPW error " + e);
			sendResponse(false, "服务器错误", null, response);
		}
		
	}
	
	public String getResult(int result, String message){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("errInfo", message); 
		param.put("result", result); 
		String res = JSONObject.toJSONString(param);
		return res;
	}
}
