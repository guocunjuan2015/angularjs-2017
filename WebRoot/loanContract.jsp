<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
  content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>借款合同</title> 
<meta name="viewport"
  content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet" />
<link href="css/common2.css" rel="stylesheet" />
<link href="css/common.css" rel="stylesheet" />
<link href="css/couponstyle.css" rel="stylesheet" />
<link href="css/bottom_munu.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script   type="text/javascript">
 var type = getRequestParam("couponType");
 var from = getRequestParam("from");
 
</script>
<style>
.loanAgreement p{padding:0 1rem 0 1rem;line-height:3rem;color:#666;font-size:1.4rem;}
.loanAgreement table{padding:0 1rem 0 1rem;margin-top:1rem;}
.loanAgreement td{padding:10px;}
</style>
<%@ include file="config/header.jsp" %>
</head>
<body>
    <section>
            <h1 class="home_title red_bg"> 
                                 借款合同          
            </h1>
    </section>
    
    <section class="loanAgreement">
          <p>甲方（借款人）：</p>
          <p>身份证号：</p>
          <p>乙方（出借人）：</p>
          <p>身份证号：</p>
          <p>特别提示：</p>
          <p>鉴于：</p>
          <p>1.甲方具有借款需求；</p>
          <p>2.甲方通过丙方运营的金融信息服务平台“小瑞快贷”向乙方提出借款需求以下或简称：“小瑞快贷”，丙方在此过程中为甲方办理借款申请、还款管理等系列服务；</p>
          <p> 3.如经甲方申请，前述借款匹配成功，甲方、乙方、丙方根据《中华人民共和国合同法>将共同签署《借款合同》。</p>
          <p>现各方经平等、自愿、友好协商一致，订立本《借款协议》，以资共同遵照履行：</p>
          <p><b>第一条借款的信息</b></p>
          <p><b>小额贷借款费用说明</b></p>
          <table border="1" style="width:100%;border-collapse:collapse;border:1px solid #ccc;text-align:center;color:#333;">
            <tr>
              <td>借款用途</td>
              <td>消费借款</td>
            </tr>
            <tr>
              <td>借款期限（天）</td>
              <td>21天</td>
            </tr>
            
            <tr>
              <td>服务费（元）</td>
              <td>管理费：19.31元  通道费：62.76元
                                      风控费：14.48元  服务利息：3.45元 （总计100元）</td>
            </tr>
            
            
            <tr>
              <td>违约金（元）</td>
              <td>违约金为借款总金额* 0.25%*逾期天数（逾期天数1-3天，含3天）
											违约金为借款总金额* 0.8%*逾期天数（逾期天数3-30天，含30天）
											违约金为借款总金额* 1%*逾期天数（逾期天数30天以上）</td>
            </tr>
            
             <tr>
              <td>关于还款</td>
              <td>1.提现金额使用期限为借款的期限，到期后由甲方主动还款或者丙方从甲方收取借款的银行卡进行扣款。2.甲方同意将借款利息和服务费由丙方在提现金额中直接扣除。</td>
            </tr>
          </table>
          <p>第二条 关于服务费</p>
          <p>本协议中的“服务费”是指因丙方为甲方提供信用咨询、还款提醒、账户管理、还款特殊情况沟通、建立档案等系列服务而由甲方支付给丙方的报酬</p>
          <p>第三条：关于还款和方式</p>
          <p>甲方应在借款到期日结算本息，甲方如未按期足额归还借款，视为甲方逾期。甲方发生逾期的，甲方须按照本协议第一条中约定的违约金计算方式向乙方支付违约金，该违约金由丙方平台代收。</p>
          <p>第四条 各方的权利义务</p>
          <p>1.甲方保证其提供的资料信息真实、有效、合法，同意乙方向有关单位查证、收集、电脑处理及保留相关资料。</p>
          <p>2.借款期间，甲方因姓名、身份证号、地址、电话号码、工作单位或其他足以影响借款合同履行的，应及时主动与丙方联系修改相关信息，并由丙方代为通知乙方。如甲方未能及时通知丙方更新信息的，乙、丙方将有关文书或信息以本协议签订时甲方的联系方式通知甲方后即视为送达。因联系方式变更造成乙方和/丙方损失的，甲方应承担全部责任。</p>
          <p>3.甲方应按照合同约定按时归还全部借款。</p>
          <p>4.乙方、丙方有权使用甲方提供的资料，并对资料的真实性、有效性进行核实。如甲方逾期还款超过30天，乙方、丙方有权通过甲方提供的其他联系人转告甲方还款，或将信用情况上报全国个人征信系统。</p>
          <p>第五条 违约责任</p>
          <p>（一）违约情形</p>
          <p>甲方发生的下列任一情况，均构成违约</p>
          <p>1．甲方未按照本协议规定按时足额偿还应还款额；</p>
          <p>2．甲方向丙方提供虚假的信息；</p>
          <p>3．甲方未履行在丙方平台的其他到期债务，或丙方发现甲方有其他拖欠债务的行为；</p>
          <p>4．甲方卷入或将卷入重大诉讼或仲裁程序及其他法律纠纷，可能影响甲方的偿债能力；</p>
          <p>5．甲方的资信情况或偿还能力出现其他重大不利变化；</p>
          <p>6．甲方将借款用于违法违规的活动。</p>
          <p>（二）违约责任</p>
          <p>如甲方出现上述任一违约情形，丙方有权采取下列一项或多项措施，包括但不限于：</p>
          <p>1.要求甲方限期纠正违约行为；</p>
          <p>2.宣布本协议的未偿还贷款提前到期，并要求甲方提前清偿全部借款。</p>
          <p>3.丙方有权停止向甲方发放任何款项；</p>
          <p>4.扣划甲方在银行卡账户中的金额用于清偿借款；</p>
          <p>5.按照本协议第一条规定的违约金及计算方式收取违约金</p>
          <p>第六条其他约定</p>
          <p> 1.在借款合同约定的甲方还款义务到期时，丙方有权向甲方催收、追回借款本息及相关费用，因催收、追回甲方逾期借款导致乙方和/或丙方产生费用支出的（包括但不限于律师费、诉讼费、取证费、公证费、催收所发生的交通费、差旅费等），该费用支出应由甲方全部承担。</p>
          <p> 2.甲方确认，无论借款合同项下的债权是否转让给第三方，甲方作为借入者在本协议下所形成的个人信用信息将被提供给中国人民银行个人信用信息基础数据库及借贷征信主管部门批准建立的个人信用数据库。有关单位、部门及个人可依法查询借款人的信用状况，查询获得的信用报告限用于中国人民银行颁布的《个人信用信息基础数据库管理暂行办法》规定用途范围内。</p>
          <p> 3.当甲方通过丙方运营的金融信息服务平台申请借款，点击“我已阅读并同意合同条款”，即视为甲方已经充分阅读并同意本协议全部内容；当乙方通过丙方运营的金融信息服务平台认购此借款时，即视为乙方已经充分阅读并同意本协议全部内容。</p>
          <p> 4.乙方将本协议项下的出借资金划转至甲方申请借款时提供的收款账户之日起，开始计算借款期限。</p>
          <p> 5.就各方签订的借款协议，甲方委托丙方代为保管，保管过程中，如果甲方需要查阅或使用该借款协议，可联系丙方并在办理相关手续后到丙方处查询，丙方应予以配合。</p>
          <p> 6.本协议及其附件的任何修改、补充均须以书面形式作出，本协议的补充协议及其附件与本协议具有同等法律效力。</p>
          <p> 第七条 争议的解决</p>
          <p>如有争议，各方优先以协商方式解决，协商不成的，三方一致同意在丙方所在地北京市西城区法院提起诉讼。</p>
          <p> 第八条 关于条款内涵</p>
          <p>本协议内容已经本协议各方仔细阅读，各方对此已有充分的认识与理解，并表示完全接受。</p> 
           <p>本协议各条款内涵的最终解释权归属于丙方，甲乙双方对此无异议。  </p>
           <p>本协议自甲、乙、丙三方签署或确认同意，且乙方放款之日起成立并生效。</p>
           <p><b>各方签署</b></p>
           <p> 甲方：</p>
           <p> 乙方：</p>
           <p> 丙方：</p> 
           <p style="text-align:right;"> 协议签署日期：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</p>      
  </section>
      
</body>
</html>