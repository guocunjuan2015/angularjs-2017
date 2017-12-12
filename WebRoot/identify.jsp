<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
String tel = "";
String tex = "";
    HttpSession s = request.getSession();
    if(s!=null){
        tel = (String)s.getAttribute("tel");
        tex = tel.substring(0,3) +"******";
    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/more.css" rel="stylesheet"/>
    <link href="css/accountcenterstyle.css" rel="stylesheet" />
    <script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min3.0.3.js"></script>
<script src="js/identify.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
    <title></title>
</head>
<body>
<button style="display: none" id="myModal" type="button"
        class="btn btn-danger mt20 ml20" data-toggle="modal"
        data-target=".bs-example-modal-lg">提示信息</button>
    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
        aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">提示信息</h4>
                </div>
                <div class="modal-body">
                    <h4 class="text-success text-center" id="body_content_h4">注册成功!</h4>
                    <!-- <p>投资金额：<span class="text-danger" id="money_invest_modal">1000</span>元</p> -->
                </div>
                <div class="modal-footer" style="display:none">
                    <button type="button" onclick="gotoPage()"
                        class="btn btn-danger btn-block">登录</button>
                </div>
                <div class="modal-footer" id="phone_code_div" style="display: none">
                    <table style="width:100%">
                        <tr>
                            <td align="center" valign="middle" width="50%">
                                <button type="button" data-dismiss="modal" 
                                    id="bt_invite" class="btn btn-danger">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;取消&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>
                            </td>
                            <td align="center" valign="middle" width="50%"><button type="button" data-dismiss="modal"
                                    onclick="getRadioCode()" id="bt_to_invest"
                                    class="btn btn-danger">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;接收&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
<section class="bank-codes">
   <p class="bank-p">你的手机号码 <span id="phone_number"><%=tex %></span></p>
    <div class="bank-code">
        <label>验证码</label><input type="text" id="c" name="c"  placeholder="短信验证码" style="width: 35%"/>
        <button  class="get-code" id="getc">获取验证码</button>
    </div>
    <p style="text-align:right;padding:2% 6% 4%;font-size:1.2rem;"><a onclick="showGetRadioCode()">没有收到验证码</a></p>
    <div class="bank-code" style="display:none">
        <label>身份证号</label><input type="text" placeholder="本人身份证号码" style="border:0;"/>
    </div>
    <input type="hidden" id="my_tel" value="<%=tel%>">
    <p style="width:70%;margin:10% auto 0;text-align:center;"><button class="btn btn-block btn-red" style="width:100%" id="next" onclick="identify()">下一步</button></p>
<div id="error_info" class="error_info"></div>
</section>
</body>
</html>