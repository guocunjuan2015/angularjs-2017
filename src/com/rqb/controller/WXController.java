package com.rqb.controller;

import com.alibaba.fastjson.JSONObject;
import com.rqb.controller.abs.AbstractController;
import com.ruiqt.lianlian.utils.WXUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

/**
 * 微信服务号相关操作
 * 这里是
 * */
@Controller
@RequestMapping(value = "/wx")
public class WXController extends AbstractController {

    /**
     * 微信回调接口 用于处理消息发送
     * @param request
     * @param session
     * @param response
     */
    // 用户同意授权之后的操作
    @RequestMapping(value = "/back.do")
    public void getPointsInfo(HttpServletRequest request,
                              HttpServletResponse response) {
        PrintWriter write=null;
        String result="";
        try {
            write=response.getWriter();
            //jsonObject是模板数据
            JSONObject jsonObject=new JSONObject();
            //params   ;符号分割
            // 第一位是 标识   1  回款 2 充值  3 投资
             String params= request.getParameter("params");
            String[] paramsArray=params.split(";");
            String type=paramsArray[0];
            String title=getRealResult(paramsArray[1]);//标题
            String remark=getRealResult(paramsArray[2]);//备注
            //三个模板都有三个参数
            String keyword1=getRealResult(paramsArray[3]);
            String keyword2=getRealResult(paramsArray[4]);
            String keyword3=getRealResult(paramsArray[5]);
            jsonObject.put("first", title);
            jsonObject.put("keyword1",keyword1);
            jsonObject.put("keyword2",keyword2);
            jsonObject.put("keyword3",keyword3);
            jsonObject.put("remark",remark);

            if (type.equals("1")) {
                jsonObject.put("template_id", WXUtils.TEMPLATES.BACKMONEY);
            }else if (type.equals("2")) {
                jsonObject.put("template_id", WXUtils.TEMPLATES.RECHARGEMONEY);
                String keyword4=getRealResult(paramsArray[6]);
                String keyword5=getRealResult(paramsArray[7]);
                jsonObject.put("keyword4",keyword4);
                jsonObject.put("keyword5",keyword5);
            }else if (type.equals("3")) {
                jsonObject.put("template_id", WXUtils.TEMPLATES.INVESTMONEY);
                String keyword4=getRealResult(paramsArray[6]);
                String keyword5=getRealResult(paramsArray[7]);
                jsonObject.put("keyword4",keyword4);
                jsonObject.put("keyword5",keyword5);
            }
            result= WXUtils.getOpenIdAndSendMsg(request,jsonObject);
        } catch (Exception e) {
            e.printStackTrace();
            result="rqb异常："+e.getMessage();
        }finally {
            write.print(result);
        }

    }

    /**
     * 微信解密转字符集
     * @param errorResult
     * @return
     * @throws UnsupportedEncodingException
     */
    private String getRealResult(String errorResult) throws UnsupportedEncodingException {
        return URLDecoder.decode(new String(errorResult.getBytes("ISO-8859-1"), "UTF-8"),"UTF-8");
    }
}
