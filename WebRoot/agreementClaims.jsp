<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%
  String userId = "";
  String investId = "";
  userId = request.getParameter("userId");
  if (userId == null || "".equals(userId)) {
    userId = "";
  }
  investId = request.getParameter("investId");
  if (investId == null || "".equals(investId)) {
    investId = "";
  }
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
    <meta name="format-detection" content="telephone=no"/> 
    <title>债权转让协议-瑞钱宝</title>
    <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
    <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，活动期间你可以选择适合您的理财产品，活动期间设置自动幸运抽奖区，投资理财奖品主要有三星电视、九阳榨汁机、iphone 6s 等，活动时间6月6日-6月24日。" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
    <style>
   		body{background-color:#fff;}
      .Lending_Agreement {
        width:100%;
        height:auto;
        margin:0px;
        padding:0px;
      }
      .Lending_Agreement_center {
      /*   width:1024px; */
        height:auto;
        margin:0 auto;
        border:1px solid #EEEEEE;
      }
      .lending_ageeement_tit {
     /*    width:960px; */
        height:45px;
        line-height:45px;
        color:#666666;
        font-family:Arial, Helvetica, sans-serif;
        font-size:1.6rem;
        font-weight:bold;
        text-align:center;
        margin:0 auto;
        margin-top:30px;
        border-bottom:1px solid #EEEEEE;
      }
      .ageeement_content {
      /*   width:1000px; */
        height:auto;
        margin:0 auto;
        margin-top:2rem;
        font-size:1.4rem;
        font-weight:bold;
        color:#666666;
        overflow:auto;
        font-family:Arial, Helvetica, sans-serif;
      }
      .ageeement_content h3 {
       font-size:1.4rem;
        font-weight:bold;
        color:#999999;
        font-family:Arial, Helvetica, sans-serif;
        padding-left:10px;
      }
      .font_lendig {
       font-size:1.4rem;
        font-weight:bold;
        color:#666666;
        font-family:Arial, Helvetica, sans-serif;
        padding-left:10px;
        margin-bottom:10px;
        display:block;
        margin-top:20px;
      }
      .ageeement_content p {
        line-height:26px;
        font-family:Tahoma, Geneva, sans-serif;
        font-size:1.4rem;
        color:#999999;
        margin:0px;
        font-weight:normal;
        padding-left:10px;
        margin-top:6px;
      }
      .ageement_tab {
        height:40px;
        line-height:40px;
      }
      .ageement_tab_ite {
        height:40px;
        line-height:40px;
        font-weight:normal;
      }
      .lending_top_inf {
        /* width:1000px; */
        height:auto;
        margin-left:10px;
      }
      .lending_logo {
        /* width:1000px; */
        height:70px;
        padding-top:20px;
        border-bottom:2px solid #00ADEE;
      }
      .lenging_left_logo {
       /*  height:100px; */
        float:left;
      }
      .name_inf {
      /*   width:400px; */
        height:65px;
        float:left;
        margin-left:40px;
        margin-top:2px;
      }
      .lenging_right_inf {
        width:260px;
        height:50px;
        float:left;
        margin-top:9px;
      }
      .lenging_right_inf ul {
        margin:0px;
        padding:0px;
      }
      .lenging_right_inf ul li {
        width:400px;
        height:25px;
        line-height:25px;
        font-family:Arial, Helvetica, sans-serif;
        font-size:14px;
        color:#999999;
        list-style:none;
        float:left;
        padding-left:0px;
      }
      .lenging_right_inf ul li a {
        color:#999999;
        text-decoration:none;
      }
      .lenging_right_inf ul li a:hover {
        color:#FF9900;
        text-decoration:none;
      }
      .Seal {
        width:auto;
        height:auto;
        margin-right:20px;
        float:right;
        text-align:center;
      }
      .seal_text {
        font-family:Arial, Helvetica, sans-serif;
       font-size:1.4rem;
        color:#999999;
        margin-top:6px;
        margin-bottom:40px;
        display:block;
        font-weight:normal;
      }
    /*   a,a:visited{color: #E67714; text-decoration:none;} */
    </style>
    <script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
      $(function() {
        $.ajax({
          url:'<%=localPath%>/invest/showAgreementClaimsResp',
                  type:'POST',
                  dataType:'json',
                  data : {
                    userId : "<%=userId %>",
                    investId : "<%=investId %>"
                  },
                  success : function (data) {
                    if (data.success) {
                      $(".realNameTransfer").html(data.umpTransferRegister.realName);
                      $(".cardNoTransfer").html(data.umpTransferRegister.cardNo);
                      $(".realName").html(data.umpRegister.realName);
                      $(".cardNo").html(data.umpRegister.cardNo);
                      $(".projectName").html(data.umploan.transferProjectName);
                      $(".investAmount").html(data.umpInvest.investAmount);
                      $(".loanRate").html(data.loan.loanRate);
                      $(".createDate").html(data.reateDate);
                      $(".endtime").html(data.endtime);
                      var seal = '';
                      seal += '居间方:' + data.configProductName;
                      seal += '<span class="seal_text">' + data.umpInvest.updateDate;
                      seal += '</span>';
                      $(".Seal").html(seal);
                    }
                  },
                  error : function (data) {
                    
                  }
        })
      })
    </script>
  </head>
  <body>
    <!--startprint1-->
      <div class="lending_ageeement_tit">
        <span class="Agreement_pic">债权转让协议</span>
    </div>
      <div class="ageeement_content">
        <p align="left">原债权人（以下简称甲方）：<label class="realNameTransfer"></label></p>
        <p align="left">身份证（护照）号码：   <label class="cardNoTransfer"></label></p>
        <p align="left">新债权人（以下简称乙方）：<label class="realName"></label></p>
        <p>身份证（护照）号码: <label class="cardNo"></label></p>
        <p>
            鉴于甲方在北京瑞钱宝资产管理服务有限公司运营管理的瑞钱宝平台（“瑞钱宝”，域名为www.rqbao.com，以下简称平台）上对债务人拥有合法债权，<br>
            现甲方将其债权通过平台转让给乙方。双方达成如下协议：
        </p>
        <p align="left">（一） 转让债权标的： </p>
        <p align="left">债权人姓名：<label class="realName"></label></p>
        <p align="left">债权人身份证号码： <label class="cardNo"></label></p>
        <p align="left">项目名称：<label class="projectName"></label></p>
        <p align="left">转让债权本金：人民币 <label class="investAmount"></label>元整</p>
        <p align="left">债权年化利率：<label class="loanRate"></label>%</p>
        <p align="left">转让后债权期限从  <label class="createDate"></label> 到 <label class="endtime"></label></p>
        <p align="left">还款方式：按月付息，到期还本</p>
        <p>（二） 债权转让价格：<label class="investAmount"></label>元整(小写),支付方式：按照平台提供方式选择支付方式，一次性支付转让价款。</p>
        <p>（三） 本债权自本合同签订之日起转移，甲方对本债权的所有权利义务同时转移给乙方。</p>
        <p>（四） 甲方因转让债权而产生的相关费用由平台代扣代缴。</p>
        <!-- <p>（五） 乙方承继甲方债权后可以再转让给第三人。</p> -->
        <p>（五） 乙方保证其支付受让标的债权的资金来源合法，乙方是该资金的合法所有人。</p>
        <p>（六） 甲乙双方签署本协议并办理相关手续均为各自真实意思表示并获得相关授权。</p>
        <p>（七） 甲乙双方均确认本协议的签订、生效和履行以不违反中国的法律法规为前提。如果本协议中的任何一条或多条违反适用的法律法规，
                     则该条将被视为无效，但该无效条款并不影响本协议其他条款的效力。</p>
        <p>（八） 本协议自转让资金支付到甲方账户起生效，双方如有异议均可向各自所在地人民法院提起诉讼。
        </p>
          <div class="Seal">
            居间方：
            <span class="seal_text"></span>
          </div>
      </div>
    <!--endprint1--> 
  </body>
</html>