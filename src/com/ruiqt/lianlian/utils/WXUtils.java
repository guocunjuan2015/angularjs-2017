package com.ruiqt.lianlian.utils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.charset.Charset;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by baiguantao on 2017/4/28.
 * 微信公众号 发送消息模板
 */
public class WXUtils {
    /*开发者AppID*/
    private static  final String AppID="wxf2d2a3b6371ba334";
    /*开发者AccessToken   该值会失效  注意更新*/
    private static  String accessToken="";
    /*开发者秘钥*/
    private static  final String AppSecret="16207fa808e9c72dd88035f4e4527bb7";
    /*获取凭证url*/
    private static  final String AccessTokenURL="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+AppID+"&secret="+AppSecret;
    /*获取模板url
    * http请求方式：GET
    * 需要依赖AccessToken值
    * */
    private static  final String AllTemPlateURL="https://api.weixin.qq.com/cgi-bin/template/get_all_private_template?access_token=";
    /*
    获取用户列表 openID
    http请求方式: GET（请使用https协议）
      https://api.weixin.qq.com/cgi-bin/user/get?access_token=ACCESS_TOKEN
  * */
    private static  final String AllUserURL="https://api.weixin.qq.com/cgi-bin/user/get?access_token=";
    /*httpclient实例*/
    private static  final HttpClient httpClient=new DefaultHttpClient();
    /**
     * 消息模板
     *      json参数示例
     *  {
     "touser":"OPENID",
     "template_id":"ngqIpbwh8bUfcSsECmogfXcV14J0tQlEpBO27izEYtY",
     "url":"http://weixin.qq.com/download",
     "miniprogram":{
     "appid":"xiaochengxuappid12345",
     "pagepath":"index?foo=bar"
     },
     "data":{
     "first": {
     "value":"恭喜你购买成功！",
     "color":"#173177"
     },
     "keyword1":{
     "value":"巧克力",
     "color":"#173177"
     },
     "keyword2": {
     "value":"39.8元",
     "color":"#173177"
     },
     "keyword3": {
     "value":"2014年9月22日",
     "color":"#173177"
     },
     "keyword4": {
     "value":"2014年9月22日",
     "color":"#173177"
     },
     "keyword5": {
     "value":"2014年9月22日",
     "color":"#173177"
     },
     "remark":{
     "value":"欢迎再次购买！",
     "color":"#173177"
     }
     }
     }
     */
    public static String SENDMSGTEMPLATE(JSONObject jsonObject){
        String template_id=jsonObject.get("template_id").toString();
        Map<String,Object> postmap=new LinkedHashMap<String,Object>();
        postmap.put("touser",jsonObject.get("touser"));//OPENID
        postmap.put("template_id",template_id);
        if (jsonObject.containsKey("url")) {
            postmap.put("url",jsonObject.get("url"));
        }
        Map<String,Object> datamap=new LinkedHashMap<String,Object>();
        Map<String,Object> first=new LinkedHashMap<String,Object>();
        first.put("value",jsonObject.get("first"));
        first.put("color","#173177");
        datamap.put("first",first);
        Map<String,Object> keyword1=new LinkedHashMap<String,Object>();
        keyword1.put("value",jsonObject.get("keyword1"));
        keyword1.put("color","#173177");
        datamap.put("keyword1",keyword1);
        Map<String,Object> keyword2=new LinkedHashMap<String,Object>();
        keyword2.put("value",jsonObject.get("keyword2"));
        keyword2.put("color","#173177");
        datamap.put("keyword2",keyword2);
        Map<String,Object> keyword3=new LinkedHashMap<String,Object>();
        keyword3.put("value",jsonObject.get("keyword3"));
        keyword3.put("color","#173177");
        datamap.put("keyword3",keyword3);
        //充值结果通知 回款 投资成功通知
        if (template_id.equals(WXUtils.TEMPLATES.INVESTMONEY)||template_id.equals(WXUtils.TEMPLATES.RECHARGEMONEY)) {
            Map<String,Object> keyword4=new LinkedHashMap<String,Object>();
            keyword2.put("value",jsonObject.get("keyword4"));
            keyword2.put("color","#173177");
            datamap.put("keyword4",keyword4);
            Map<String,Object> keyword5=new LinkedHashMap<String,Object>();
            keyword3.put("value",jsonObject.get("keyword5"));
            keyword3.put("color","#173177");
            datamap.put("keyword5",keyword5);
        }
        Map<String,Object> remark=new LinkedHashMap<String,Object>();
        remark.put("value",jsonObject.get("remark"));
        remark.put("color","#173177");
        datamap.put("remark",remark);
        postmap.put("data",datamap);
        String postmsg=JSONArray.toJSONString(postmap);
        return  postmsg;
    }
    /**
     * 发送模板消息2 测试单个
     * post方式
     *
     * @return
     */
    private static String SendMsgSingle(String msg){
        if (StringUtils.isEmpty(accessToken)) {
            WXUtils.getAccessToken();//初始化AccessToken值
        }
        String result="";
        String sendWXBACKUrl="https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+accessToken;
        HttpPost httpPost=new HttpPost();
        HttpResponse response = null;
        try {
            httpPost.setURI(new URI(sendWXBACKUrl));
            httpPost.addHeader("Content-type","application/json; charset=utf-8");
            httpPost.setHeader("Accept", "application/json");
            httpPost.setEntity(new StringEntity(msg, Charset.forName("UTF-8")));
            response=httpClient.execute(httpPost);
            JSONObject jsonObject= getJSONObject(response);
            result=jsonObject.toString();
            System.out.println("发送消息处理--->begin:"+jsonObject);
            if (jsonObject.containsKey("errcode")) {
                String errcode=jsonObject.get("errcode").toString();
                if (errcode.equals("43004")) {
                    //接受者未关注
                    System.out.println("接受者未关注微信号 ，发送失败了");
                }
                if (errcode.equals("42001")
                        ||errcode.equals("40014")
                        ||errcode.equals("40001")) {
                    getAccessToken();//刷新AccessToken
                    SendMsgSingle(msg);
                }
            }
        } catch (URISyntaxException e) {
            e.printStackTrace();
            result="rqb服务器错误"+e.getMessage();
        } catch (ClientProtocolException e) {
            e.printStackTrace();
            result="rqb服务器错误"+e.getMessage();
        } catch (IOException e) {
            e.printStackTrace();
            result="rqb服务器错误"+e.getMessage();
        }finally {
            httpPost.releaseConnection();
        }
        return result;
    }
    /**
     * 获取AccessToken凭证
     * gget方式
     * @return
     */
    private static String getAccessToken(){
        accessToken="";
        HttpGet httpGet=new HttpGet();
        HttpResponse response = null;
        try {
            httpGet.setURI(new URI(AccessTokenURL));
            response=httpClient.execute(httpGet);
            JSONObject jsonObject= getJSONObject(response);
            accessToken=jsonObject.get("access_token").toString();
            System.out.println("access_token---:"+accessToken);
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return "error";
        } catch (ClientProtocolException e) {
            e.printStackTrace();
            return "error";
        } catch (IOException e) {
            e.printStackTrace();
            return "error";
        }finally {
            httpGet.releaseConnection();
        }
        return accessToken;
    }
    /**
     * 获取服务号平台用户openID列表
     * get方式
     * @return
     */
    private static JSONObject  getAllUser(){
        HttpGet httpGet=new HttpGet();
        HttpResponse response = null;
        JSONObject jsonObject=null;
        try {
            httpGet.setURI(new URI(AllUserURL+accessToken));
            response=httpClient.execute(httpGet);
            jsonObject= getJSONObject(response);
            System.out.println("allUser---:"+jsonObject);
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return msg("500");
        } catch (ClientProtocolException e) {
            e.printStackTrace();
            return msg("500");
        } catch (IOException e) {
            e.printStackTrace();
            return msg("500");
        }finally {
            httpGet.releaseConnection();
        }
        return jsonObject;
    }

    /**
     * 获取openID并发送模板消息
     * @param request
     * @param templateJson  消息模板封装数据
     * @return
     */
    public static String getOpenIdAndSendMsg(HttpServletRequest request,JSONObject templateJson){
        String result="";
        try {
          //code 使用一次就失效了
            String code = request.getParameter("code");
            System.out.println("******************code=" + code);
            //第二步：通过code换取网页授权access_token
            String tokenurl= getAccessTokenUrl(code);
            JSONObject jsonObject=WXUtils.getByHttpGetBackJson(tokenurl);
            if (!jsonObject.isEmpty()) {
                //判断是否出错
                if (jsonObject.containsKey("code")&&jsonObject.get("code").equals("500")) {
                    //进入判断是请求时发生异常
                    result= "微信服务器发生异常";
                } else {
                    //获取openId
                    String openId=jsonObject.get("openid").toString();
                    //设置发送用户
                    templateJson.put("touser",openId);
                    String msg=SENDMSGTEMPLATE(templateJson);
                    result=SendMsgSingle(msg);
                }

            } else {
                //todo 待处理
                result="获取openId失败";
            }
        }catch (Exception e){
            e.printStackTrace();
            result="rqb服务器发生异常";
            return result;
        }
        return result;
    }
    /**
     * 公共方法
     * get方式的json返回数据处理
     * @return
     */
    private static JSONObject  getByHttpGetBackJson(String url){
        HttpGet httpGet=new HttpGet();
        HttpResponse response = null;
        JSONObject jsonObject=null;
        try {
            httpGet.setURI(new URI(url));
            response=httpClient.execute(httpGet);
            jsonObject= getJSONObject(response);
            System.out.println("getByHttpGetBackJson---:"+jsonObject);
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return msg("500");
        } catch (ClientProtocolException e) {
            e.printStackTrace();
            return msg("500");
        } catch (IOException e) {
            e.printStackTrace();
            return msg("500");
        }finally {
            httpGet.releaseConnection();
        }
        return jsonObject;
    }
    /**
     * 获取服务号平台用户具体信息
     *  GET https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID&lang=zh_CN
     * get方式
     * @return
     */
    private static JSONObject  getSingleUser(String openID){
        HttpGet httpGet=new HttpGet();
        HttpResponse response = null;
        JSONObject jsonObject=null;
        String singleUrl="https://api.weixin.qq.com/cgi-bin/user/info?access_token="+accessToken+"&openid="+openID+"&lang=zh_CN";
        try {
            httpGet.setURI(new URI(singleUrl));
            response=httpClient.execute(httpGet);
            jsonObject= getJSONObject(response);
            System.out.println("单个用户：---:"+openID+"opendid:"+jsonObject.get("nickname"));
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return msg("500");
        } catch (ClientProtocolException e) {
            e.printStackTrace();
            return msg("500");
        } catch (IOException e) {
            e.printStackTrace();
            return msg("500");
        }finally {
            httpGet.releaseConnection();
        }
        return jsonObject;
    }

    /**
     * 解析json格式返回为jsonObject对象
     * @param response
     * @return
     */
    private static   JSONObject getJSONObject(HttpResponse response){
        String result= null;
        JSONObject jsonObject=null;
        try {
            HttpEntity entity = response.getEntity();
            result = EntityUtils.toString(entity,"UTF-8");
            jsonObject=JSONObject.parseObject(result);
            if (jsonObject.containsKey("errcode")) {
                //AccessToken相关  失效  超时  这里重新获取  并重新执行该方法
                String errcode=jsonObject.get("errcode").toString();
                if (errcode.equals("42001")
                        ||errcode.equals("40014")
                        ||errcode.equals("40001")) {
                    getAccessToken();//刷新AccessToken
                    getJSONObject(response);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return  null;
        }
        return  jsonObject;
    }

    /**
     * 查找想要的single用户
     * oSSRZ0uK5qANkka3rHKPQwtm-nPI  路上有你的openid
     */
    public static   void getSingleOpenId(){
        JSONObject jsonObject=WXUtils.getAllUser();
        String data=jsonObject.get("data").toString();
        JSONArray openids=jsonObject.getJSONObject("data").getJSONArray("openid");
        System.out.println("data:"+data);
        System.out.println("openids:"+openids);
        int len=openids.size();
        for (int i=0;i<len;i++) {
            WXUtils.getSingleUser(openids.getString(i));
        }
    }

    /**
     * msg  默认500  服务器错误
     * @param msg
     * @return
     */
    private  static JSONObject msg(String msg){
        if (StringUtils.isEmpty(msg)) {
            msg="500";
        }
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("code",msg);
        return jsonObject;
    }
    public static void main(String[] args) {
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("touser","oSSRZ0uK5qANkka3rHKPQwtm-nPI");
        jsonObject.put("template_id",WXUtils.TEMPLATES.BACKMONEY);
        jsonObject.put("first","我是回款标题");
        jsonObject.put("keyword1","100分");
        jsonObject.put("keyword2","10000");
        jsonObject.put("keyword3","100");
        jsonObject.put("remark","我是回款备注");
        jsonObject.put("touser","222");
        //String postmsg=WXUtils.SENDMSGTEMPLATE(jsonObject);
        System.out.println(jsonObject.toString());
        //System.out.println(postmsg);
       // WXUtils.getAccessToken();
        //WXUtils.SendMsgSingle(postmsg);
    }
    /***
     * 获取token
     * 用于网页授权
     * @param code
     * @return
     */
    private static String getAccessTokenUrl(String code){
        String result="https://api.weixin.qq.com/sns/oauth2/access_token?appid="+AppID+"&secret="+AppSecret+"&code="+code+"&grant_type=authorization_code";
        return result;
    }
    public interface TEMPLATES{
        public final String BACKMONEY="NIQgWYPEOWERnWtIvjiDzxXz0L7Ch3WqIHJu6gtXTT8";
        public final String RECHARGEMONEY="R2fJlbSbslC9uepBVKGXvSKh8DTe_s8RQMtgbeBjMK0";
        public final String INVESTMONEY="ePQqoE3t7zlpIENneMEQfvATuEFHscvCHqYWQeUzMvk";
    }
}


