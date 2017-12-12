package com.rqb.borrowing.jxl.vo;

/**
 * 请求对象
 * 
 * @author zhaojianjun
 *
 */
public class ReqMsg {

    /** 用户令牌 **/
    private String token;
    /** 网站名称 **/
    private String website;
    /** 网站账号 **/
    private String account;
    /** 网站密码 **/
    private String password;
    /** 动态密码 **/
    private String captcha;
    /** 请求类型 **/
    private String type = null;
    /** 客户名称 **/
    private String org_name = null;
    /** 客户标识码 **/
    private String client_secret = null;
    //信用卡参数
    /** 邮箱账号 **/
    private String email = null;
    /** 独立密码 **/
    private String identity = null;
    /** 申请信息 **/
    private ApplyInfo apply_info = null;
    //手机接口参数
    /** 用户id **/
    private String userId;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCaptcha() {
        return captcha;
    }

    public void setCaptcha(String captcha) {
        this.captcha = captcha;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getOrg_name() {
        return org_name;
    }

    public void setOrg_name(String org_name) {
        this.org_name = org_name;
    }

    public String getClient_secret() {
        return client_secret;
    }

    public void setClient_secret(String client_secret) {
        this.client_secret = client_secret;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
    } 

    public ApplyInfo getApply_info() {
        return apply_info;
    }

    public void setApply_info(ApplyInfo apply_info) {
        this.apply_info = apply_info;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "ReqMsg [token=" + token + ", website=" + website + ", account=" + account + ", password=" + password + ", captcha=" + captcha + ", type=" + type + "]";
    }
}
