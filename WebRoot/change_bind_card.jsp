<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%@ include file="/config/global.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet" />
<link href="css/accountcenterstyle.css" rel="stylesheet" />
<link href="css/common2.css" rel="stylesheet" />
<link href="css/more.css" rel="stylesheet" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	getCardInfo();
	checkUMPRegister();
});

function changeCard(){
	window.location.href = "identify.jsp";
}

function getCardInfo(){
	$.ajax({
        type : "POST",
        url : "account/mybandcard/info/get.do",
        data : {
        },
        success : function(response) {
            if (response.success) {
                var info = $.parseJSON(response.result);
                if (info.result) {
                	var data = info.resultObject;
                	$("#bank_name")[0].innerHTML = data.bankName;
                    $("#bank_code")[0].innerHTML ="**** **** **** " + data.cardId;
                    var doc = document.getElementById("bank_logo");
                    switch (data.gateId) {
					case "ICBC":
						doc.setAttribute("src", "images/logo/gs_bk.png");
						break;
					case "BOC":
                        doc.setAttribute("src", "images/logo/zg_bk.png");
                        break;
					case "ABC":
                        doc.setAttribute("src", "images/logo/ny_bk.png");
                        break;
					case "CCB":
                        doc.setAttribute("src", "images/logo/js_bk.png");
                        break;
					case "COMM":
                        doc.setAttribute("src", "images/logo/jt_bk.png");
                        break;
					case "PSBC":
                        doc.setAttribute("src", "images/logo/yc_bk.png");
                        break;
					case "CMBC":
                        doc.setAttribute("src", "images/logo/mc_bk.png");
                        break;
					case "CITIC":
                        doc.setAttribute("src", "images/logo/zx_bk.png");
                        break;
					case "CEB":
                        doc.setAttribute("src", "images/logo/gd_bk.png");
                        break;
					case "HXB":
                        doc.setAttribute("src", "images/logo/hx_bk.png");
                        break;
					case "GDB":
                        doc.setAttribute("src", "images/logo/gf_bk.png");
                        break;
					case "CIB":
                        doc.setAttribute("src", "images/logo/xy_bk.png");
                        break;
					case "SPDB":
                        doc.setAttribute("src", "images/logo/pf_bk.png");
                        break;
					case "SPAB":
                        doc.setAttribute("src", "images/logo/pa_bk.png");
                        break;
					case "CMB":
                        doc.setAttribute("src", "images/logo/zs_bk.png");
                        break;
					}
                } else {
                    errorMsg(info.errInfo);
                }
            } else {
                if (isEmpty(response.result)) {
                    errorMsg(response.msg);
                } else {
                    window.location.href = response.result;
                }
            }
        },
        dataType : "json"
    });
}

/**检查是否开启快捷支付*/
function checkUMPRegister() {
    $.ajax({
        type : "POST",
        url : "ump/check/register/status.do",
        data : {},
        success : function(response) {
            if (response.success) {
                var info = $.parseJSON(response.result);
                var data = info.resultObject;
                        if("1" == data.isOpenFastPayment){
                            $("#alopen")[0].style.display = "block";
                        }else{
                            $("#openFastBtn")[0].style.display = "block";
                        }
            }else {
                if (isEmpty(response.result)) {
                    errorMsg(response.msg);
                } else {
                    window.location.href = response.result;
                }
            }
        },
        dataType : "json"
    });
}

function doOpenPayment(){
    $("#openFastBtn").attr("disabled", true);
    $.ajax({
        type: "POST",
        url: "ump/payment/open.do",
        data: {
            payment:"ZKJP0700",
            returl:"http://www.rqbao.com/rqb/ump_callback_result.jsp",
        },
        success: function(response) {
            if(response.success){
            	var info = $.parseJSON(response.result);
            	window.location.href = info.resultObject.url;
              /*   document.getElementById("payment_form")
                .setAttribute("action",info.resultObject.url); */
                //$("#payment_form").submit();
            }else{
                if(isEmpty(response.result)){
                    errorMsg(response.msg);
                }else{
                    window.location.href = response.result;
                }
            }
            $("#openFastBtn").attr("disabled", false);
        },
        dataType: "json"
       
    });
}
</script>
<title>银行卡</title>
</head>
<body>
<%@ include file="/config/globalHead.jsp" %>
<!-- <header>
        <div class="home_title red_bg">
            <a style="display:inline-block;width:2rem;float: left;color:#fff;" href="#" onclick="history.back(-1)"> < </a> 银行卡 <span class="sp_titile_left"
                 onclick="changeCard()">更改银行卡</span>
        </div>
    </header> -->
	<section class="banks-info"> 
     <div class="banks"> 
     	<img class="fl" id="bank_logo" src=""/> 
         <span class="bank-name fl" id="bank_name"></span> 
	     <span class="alopen fr" id="alopen" style="display:none">已开通</span>
	     <button class="openFastBtn fr" style="display:none" id="openFastBtn" onclick="doOpenPayment()">开通快捷支付</button>
         <span class="bank-card" id="bank_code"></span> 
     </div> 
     <p><span style="margin:1rem 0 0 4rem;display: inline-block;font-size:1.2rem;"><font style="margin-right:4px;width:20px;height:20px;line-height:20px;color:#A2A2A2;border-radius:50%;border:1px solid #ccc;display: inline-block;text-align:center;">!</font>如需要更换银行卡，请下载app或移步至pc端</span></p>
 </section>
	<section style="margin-top: 35%;">
        <div class="safe" >
        </div>
    </section>
    <div style="display: none">
        <form action=""
            method="post" id="payment_form">
            <ul>
                <li><input type="hidden" name="payment_data" id="payment_data" /></li>
            </ul>
        </form>
    </div>
    <div id="error_info" class="error_info"></div>
</body>
</html>