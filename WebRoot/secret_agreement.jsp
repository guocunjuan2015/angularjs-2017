<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String basePath = "http://www.rqbao.com/";
    String payment="ZTBB0G00";//无密投资协议
    String returl = basePath + "/rqb/ump_callback_result.jsp";
    String from = request.getParameter("from");
    if (from == null || (!"app".equals(from) && !"app1".equals(from) && !"pc".equals(from))) {
        from = "";
    }
    if (from != null && "app".equals(from) || "app1".equals(from)|| "pc".equals(from)) {
        String user = request.getParameter("user");
        String userId = request.getParameter("userId");
        if (user != null && user != "" && userId != null
                && userId != "") {
            HttpSession s = request.getSession();
            s.setAttribute("loginUser", user);
            s.setAttribute("userId", userId);
        }
    }
    
    if (from != null && ("app1".equals(from) || "pc".equals(from))) {
    	payment="ZHKB0H01";//无密还款协议
        if("pc".equals(from)){
            returl=basePath + "credit/";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
    content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>免密协议</title>
<meta name="viewport"
    content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/common2.css">
<link rel="stylesheet" type="text/css" href="css/utils.css">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
<style>
main{
background: #fff;
padding-bottom: 10%;
}
.sign_div{
padding: 3% 3%;
color: #333;
font-size: 1.6rem;
border-bottom: 1px solid #f1f1f1;
}
.sign_div span{
float: right;
font-size: 1.5rem;
}
.sign_btn{
width: 80%;
margin: 0 auto;
padding: 10% 0 6% 0;
}
main p{
color: #666;
padding: 2% 5%;
text-indent:25px;
}
</style>
<script type="text/javascript">
var noPassWordInvest = -1;
$(function(){
	var from = '<%=from%>'
	if("app" != from){
		$("#secretHeader")[0].style.display = "block";
	}
    checkUMPStatus();
});

function openNoPasswordInvest(){//免密
    $.ajax({
        type: "POST",
        url: "ump/payment/open.do",
        data: {
            payment:"<%=payment%>",
            returl:"<%=returl%>",
        },
        success: function(response) {
            if(response.success){
            	dismissAys('ays2');
            	var info = $.parseJSON(response.result);
            	if(info.result){
                    document.getElementById("no_password_form")
                    .setAttribute("action",info.resultObject.url);
                    $("#no_password_form").submit();
            	}else{
            		errorMsg(info.errInfo);
            	}
            }else{
                if(isEmpty(response.result)){
                    errorMsg(response.msg);
                }else{
                    window.location.href = response.result;
                }
            }
        },
        dataType: "json"
    });
}
function closeNoPasswordInvest(){//close免密
    $.ajax({
        type: "POST",
        url: "ump/payment/close.do",
        data: {
            payment:"<%=payment%>",
            returl:"<%=basePath%>/ump_callback_result.jsp",
        },
        success: function(response) {
            if(response.success){
            	dismissAys('ays');
                var info = $.parseJSON(response.result);
                if(info.result){
                	document.getElementById("no_password_form")
                    .setAttribute("action",info.resultObject.url);
                    $("#no_password_form").submit();
                }else{
                	errorMsg(info.errInfo);
                }
            }else{
                if(isEmpty(response.result)){
                    errorMsg(response.msg);
                }else{
                    window.location.href = response.result;
                }
            }
        },
        dataType: "json"
    });
}

function checkUMPStatus() {
    $.ajax({
                type : "POST",
                url : "ump/check/register/status.do",
                data : {},
                success : function(response) {
                    if (response.success) {
                        var info = $.parseJSON(response.result);
                        var data = info.resultObject;
                        noPassWordInvest = data.noPassWordInvest;
                        var flag=noPassWordInvest==1&&data.repaymentPasswordFree==1?1:-1;
                        initPage(flag);
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

function initPage(flag){
	if(parseInt(flag) == 1){
		$("#signOrNot")[0].innerHTML = "已签约";
		$("#signBtn")[0].innerHTML = "我要解约";
		$("#signBtn").click(function(){
			//showAys('','ays');
                        closeNoPasswordInvest();
		});
	}else{
		$("#signOrNot")[0].innerHTML = "未签约";
		$("#signBtn")[0].innerHTML = "我要签约";
		$("#signBtn").click(function(){
                    //showAys('','ays2');
                    openNoPasswordInvest();
        });
	}
}

function dismissAys(id){
    $("#bg")[0].style.display = "none";
    $("#"+id)[0].style.display = "none";
}
function showAys(value,id){
    //$("#ays_content2")[0].innerHTML = value;
    $("#bg").css("height", document.body.scrollHeight);
    $("#bg")[0].style.display = "block";
    $("#"+id)[0].style.display = "block";
}
/* function dismissAys2(){
    $("#bg")[0].style.display = "none";
    $("#ays2")[0].style.display = "none";
}
function showAys2(){
    //$("#ays_content2")[0].innerHTML = value;
    $("#bg").css("height", document.body.scrollHeight);
    $("#bg")[0].style.display = "block";
    $("#ays2")[0].style.display = "block";
} */
</script>
</head>
<body>
<div id="bg"></div>
<section class="alert-dialog" id="ays"  >
        <h5 class="alert-dialog-title">提示信息</h5>
        <div class="alert-dialog-content" id="ays_content">确定要解除免密协议吗？</div>
        <ul class="alert-dialog-button">
            <li><button onclick="dismissAys('ays')">取消</button></li>
            <li><button onclick="closeNoPasswordInvest()">确定</button></li>
        </ul>
</section>
<section class="alert-dialog" id="ays2"  >
        <h5 class="alert-dialog-title">提示信息</h5>
        <div class="alert-dialog-content" id="ays_content2">确定要签订免密协议吗？</div>
        <ul class="alert-dialog-button">
            <li><button onclick="dismissAys('ays2')">取消</button></li>
            <li><button onclick="openNoPasswordInvest()">确定</button></li>
        </ul>
</section>

    <header id="secretHeader" style="display:none">
        <div class="home_title_red">
             免密协议 
        </div>
    </header>
     
     <main>
     <div class="sign_div">免密<%=(payment.equals("ZHKB0H01")?"还款":"自动投标")%>协议<span id="signOrNot"> </span></div>
     <div class="sign_btn"><button id="signBtn" class="btn   btn-block btn-danger">&nbsp;</button></div>
     <!-- <p>签订免密协议后，无需重复输入第三方支付平台（联动优势）支付密码，便可以进行投资操作。</p> -->
     <p>签订免密<%=(payment.equals("ZHKB0H01")?"还款":"自动投标")%>协议后，借款用户到还款日时，将自动扣除您瑞钱宝帐户中的可用余额用于还款</p>
     </main>
     
     <div style="display: none">
        <form action=""
            method="post" id="no_password_form">
        </form>
    </div>
    <div id="error_info" class="error_info"></div>
</body>
</html>