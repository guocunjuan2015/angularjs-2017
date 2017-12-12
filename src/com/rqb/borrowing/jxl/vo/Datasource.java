package com.rqb.borrowing.jxl.vo;

/**
 * 数据源对象
 *
 * @author zhaojianjun
 *
 *
 */
public class Datasource {

    /**
     * 网站英文名称 *
     */
    private String website;
    /**
     * 网站中文名称 *
     */
    private String name;
    /**
     * 网站分类英文名称 *
     */
    private String category;
    /**
     * 网站分类中文名称 *
     */
    private String category_name;

    /**
     * 数据源状态 0 未开发 1 上线 2下线 3 禁用 *
     */
    private Integer status;
    /**
     * 密码重置方式 0 不支持密码重置 1 需要输入动态密码 2 需要输入动态密码、新密码 *
     */
    private Integer reset_pwd_method;

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getReset_pwd_method() {
        return reset_pwd_method;
    }

    public void setReset_pwd_method(Integer reset_pwd_method) {
        this.reset_pwd_method = reset_pwd_method;
    }

    @Override
    public String toString() {
        return "Datasource [website=" + website + ", name=" + name + ", category=" + category + ", category_name=" + category_name + ", status=" + status + ", reset_pwd_method=" + reset_pwd_method + "]";
    }
}
